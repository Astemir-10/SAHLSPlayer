//
//  SAPlayerControlView.swift
//  AAS
//
//  Created by Shibzukhov Astemir on 14.05.2022.
//

import UIKit
import AVKit




public class SAPlayerControlViw2: UIView {
    
    var closure1: (() -> ())? = {}
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    let buttonPlayPause: UIButton = UIButton()
    
    private let layerA = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.layerA.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
        
        self.layer.addSublayer(layerA)
        addSubview(buttonPlayPause)
        self.tapGestureRecognizer = .init(target: self, action: #selector(didTapGesture(_:)))
        addGestureRecognizer(self.tapGestureRecognizer)
        self.setupConstraints()
        
        buttonPlayPause.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        buttonPlayPause.setImage(.init(imageLiteralResourceName: "play"), for: .normal)
        buttonPlayPause.tintColor = .white
    }
    
    private func setupConstraints() {
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layerA.frame = self.bounds
        buttonPlayPause.frame.size = .init(width: 100, height: 100)
        buttonPlayPause.center = center
    }
    
    @objc
    private func didTapGesture(_ gestire: UITapGestureRecognizer) {
        layerA.isHidden.toggle()
        buttonPlayPause.isHidden = layerA.isHidden
    }
    var flag = true
    @objc
    private func didTapPlayPause() {
        closure1?()
        
        if !flag {
            buttonPlayPause.setImage(.init(imageLiteralResourceName: "play"), for: .normal)
        } else {
            buttonPlayPause.setImage(.init(imageLiteralResourceName: "pause"), for: .normal)
        }
        flag.toggle()
       
    }
    
}


























protocol SAPlayerControlViewDelegate: AnyObject {
    func playerViewControlDidTapPlay()
    func playerViewControlDidTapNext()
    func playerViewControlDidTapPreview()
}
//
//class SAPlayerControlView: UIView {
//    enum SAPlayerControlViewPlayState {
//        case play, pause
//    }
//
//    var pointSize: CGFloat = 100
//    var size: CGFloat = 60
//
//    weak var delegate: SAPlayerControlViewDelegate?
//
//    private let multiplier: CGFloat = 0.6
//
//    var state: SAPlayerControlViewPlayState = .pause {
//        didSet {
//            let config = UIImage.SymbolConfiguration.init(pointSize: self.pointSize, weight: .medium, scale: .large)
//            var image: UIImage?
//            switch state {
//            case .play:
//                image = UIImage.init(systemName: "pause.fill", withConfiguration: config)
//            case .pause:
//                image = UIImage.init(systemName: "play.fill", withConfiguration: config)
//            }
//
//            self.playButton.setImage(image, for: .normal)
//        }
//    }
//
//    private(set) lazy var nextButton: UIButton = {
//        let button = UIButton()
//        let config = UIImage.SymbolConfiguration.init(pointSize: self.pointSize * self.multiplier, weight: .medium, scale: .large)
//        let image = UIImage.init(systemName: "forward.fill", withConfiguration: config)
//        button.setImage(image, for: .normal)
//        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    private(set) lazy var previewButton: UIButton = {
//        let button = UIButton()
//        let config = UIImage.SymbolConfiguration.init(pointSize: self.pointSize * self.multiplier, weight: .medium, scale: .large)
//        let image = UIImage.init(systemName: "backward.fill", withConfiguration: config)
//        button.setImage(image, for: .normal)
//        button.addTarget(self, action: #selector(didTapPreview), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    private(set) lazy var playButton: UIButton = {
//        let button = UIButton()
//        let config = UIImage.SymbolConfiguration.init(pointSize: self.pointSize, weight: .medium, scale: .large)
//        let image = UIImage.init(systemName: "play.fill", withConfiguration: config)
//        button.setImage(image, for: .normal)
//        button.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        [self.nextButton, self.previewButton, playButton].forEach({ self.addSubview($0) })
//        self.nextButton.backgroundColor = .yellow
//        self.previewButton.backgroundColor = .yellow
//        self.playButton.backgroundColor = .gray
//
//
//        NSLayoutConstraint.activate([
//            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//
//
//
//        ])
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    @objc private func didTapPlay() {
//        self.delegate?.playerViewControlDidTapPlay()
//        print(playButton.frame.size)
//        print(self.center)
//        print(playButton.center)
//    }
//
//    @objc private func didTapNext() {
//        self.delegate?.playerViewControlDidTapNext()
//    }
//
//    @objc private func didTapPreview() {
//        self.delegate?.playerViewControlDidTapPreview()
//    }
//}
