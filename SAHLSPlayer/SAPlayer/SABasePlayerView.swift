//
//  SABasePlayerView.swift
//  AAS
//
//  Created by Shibzukhov Astemir on 11.05.2022.
//

import UIKit
import AVKit

public protocol SABasePlayerStatusObserver: AnyObject {
    func saPlayer(didChange status: AVPlayer.Status)
}

public extension SABasePlayerStatusObserver {
    func saPlayer(didChange status: AVPlayer.Status) { }
}

public protocol SABasePlayerTimeOberver: AnyObject {
    func saPlayer(didUpdate time: CMTime)
}

public protocol  SABasePlayerOberver: SABasePlayerStatusObserver, SABasePlayerTimeOberver {
    
}

private final class WeakPlayerTimeObserver {
    private(set) weak var value: SABasePlayerOberver?
    
    init(_ v: SABasePlayerOberver?) {
        self.value = v
    }
}

public class SABasePlayerView: UIView {
    
    var player: AVPlayer? {
        didSet {
            self.updatePlayer()
        }
    }
    
    private(set) var playerTime: CMTime?
    
    private var timeObserver: Any!
    
    private var observers =  [WeakPlayerTimeObserver]()
    private var statusObserver: NSKeyValueObservation?
    
    private let saBasePlayerTimingDispatchQueue = DispatchQueue.init(label: "saBasePlayerTimingDispatchQueue", qos: .userInteractive)
    
    private lazy var playerLayer: AVPlayerLayer = {
        let playerLayer = AVPlayerLayer()
        return playerLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.playerLayer.frame = self.bounds
        
    }
    
    public func addPlayerTimeObserver(_ observer: SABasePlayerOberver) {
        print("ADD OBSERVER")
        self.observers.append(.init(observer))
    }
    
    public func removePlayerTimeObserver(_ observer: SABasePlayerOberver) {
        self.observers.append(.init(observer))
    }
    
    private func updatePlayer() {
        if timeObserver != nil {
            player?.removeTimeObserver(observers)
            timeObserver = nil
        }
        
        if self.statusObserver != nil {
            self.statusObserver = nil
        }
        
        self.statusObserver = self.player?.observe(\.status, options: [.new, .old], changeHandler: { [weak self] player, changed in
            self?.observers.removeAll(where: { $0.value == nil })
            self?.observers.forEach({
                $0.value?.saPlayer(didChange: player.status)
            })
        })
        
        self.playerLayer.player = self.player
        
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        
        self.timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(0.01, preferredTimescale: timeScale), queue: self.saBasePlayerTimingDispatchQueue, using: { [weak self] time in
            self?.playerTime = time
            self?.observers.removeAll(where: { $0.value == nil })
            self?.observers.forEach({ $0.value?.saPlayer(didUpdate: time) })
        })
    }
}
