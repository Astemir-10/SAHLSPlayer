//
//  SAPlayerView.swift
//  AAS
//
//  Created by Shibzukhov Astemir on 14.05.2022.
//

import UIKit
import AVKit


final class SAPlayerView: SABasePlayerView, SAPlayerControlViewDelegate, SAPlayerProgressViewDelegate, SABasePlayerOberver  {
    
    private var currentURL: URL? {
        didSet {
            
            guard let url = currentURL else { return }
            self.player = .init(url: url)
        }
    }
    
    private var urls: [URL] = []
    
    private(set) var isPlaying: Bool = false {
        didSet {
//            self.controlView.state = isPlaying ? .play : .pause
        }
    }
    
    private lazy var controlView: UIView = {
        let control = UIView()
//        control.delegate = self
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var progressView: SAPlayerProgressView = {
        let view = SAPlayerProgressView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var control: SAPlayerControlViw2 = {
        let sd = SAPlayerControlViw2()
        sd.translatesAutoresizingMaskIntoConstraints = false
        return sd
    }()
        
    init(urls: [URL]) {
        super.init(frame: .zero)
        self.urls = urls
        self.setup()
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUrls(_ urls: [URL]) {
        self.urls = urls
        self.currentURL = urls.first
    }
    
    private func setup() {
        self.addPlayerTimeObserver(self)

        self.currentURL = urls.first
        self.addSubview(control)
//        self.addSubview(progressView)
//        NSLayoutConstraint.activate(self.controlView.makeConstraints(to: self, top: 40, leading: 40, trailing: -20, bottom: -20))
//        NSLayoutConstraint.activate([
//            progressView.heightAnchor.constraint(equalToConstant: 35),
//            progressView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
//        ])
        NSLayoutConstraint.activate(control.makeDefaultConstraints(to: self))
        
        control.closure1 = { [weak self] in
            guard let self = self else { return }
            if self.isPlaying {
                self.player?.pause()
            } else {
                self.player?.play()
            }
            self.isPlaying.toggle()
            
            
        }
    }
    
    public func setUrls(urls: [URL]) {
        self.urls = urls
    }
    
    func saPlayer(didUpdate time: CMTime) {
        if let dur = self.player?.currentItem?.asset.duration {
            DispatchQueue.main.async {
//                let minutes = Int(dur.seconds / 60)
//                let seconds = Int(Int(dur.seconds) % 60)
//                if dur == time {
//                    self.isPlaying = false
//                    self.player?.seek(to: .zero)
//                    self.progressView.setProgress(progress: 0, currentTime: "00:00", duration: "\(minutes < 10 ? "0": "")\(minutes):\(seconds < 10 ? "0" : "")\(seconds)")
//                } else {
//                    let currentMinutes = Int(time.seconds / 60)
//                    let currentSeconds = Int(Int(time.seconds) % 60)
//                    self.progressView.setProgress(progress: time.seconds / dur.seconds, currentTime: "\(currentMinutes < 10 ? "0": "")\(currentMinutes):\(currentSeconds < 10 ? "0" : "")\(currentSeconds)", duration: "\(minutes < 10 ? "0": "")\(minutes):\(seconds < 10 ? "0" : "")\(seconds)")
//                }
            }
        }

    }
    
    func playerViewControlDidTapPlay() {
        if self.isPlaying {
            self.player?.pause()
        } else {
            self.player?.play()
        }
        self.isPlaying.toggle()
    }
    
    func saPlayer(didChange status: AVPlayer.Status) {
        if let dur = self.player?.currentItem?.asset.duration, status == .readyToPlay {
            self.setTime(from: dur)
        }
    }
    
    func playerViewControlDidTapNext() {
        
    }
    
    func playerViewControlDidTapPreview() {
    
    }
    
    func progresView(progress: Double) {
        if let dur = self.player?.currentItem?.asset.duration {
            self.player?.seek(to: CMTimeMakeWithSeconds(progress * dur.seconds, preferredTimescale: 1))
        }
    }
    
    private func setTime(from duration: CMTime) {
//        let minutes = Int(duration.seconds / 60)
//        let seconds = Int(Int(duration.seconds) % 60)
//        self.progressView.setProgress(progress: 0, currentTime: "00:00", duration: "\(minutes < 10 ? "0": "")\(minutes):\(seconds < 10 ? "0" : "")\(seconds)")
    }
    
}
