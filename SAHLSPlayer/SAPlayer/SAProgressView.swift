//
//  SAProgressView.swift
//  AAS
//
//  Created by Shibzukhov Astemir on 14.05.2022.
//

import UIKit
import AVKit


protocol SAPlayerProgressViewDelegate: AnyObject {
    func progresView(progress: Double)
}

final class SAPlayerProgressView: UIView {
    
    private lazy var progressPoint: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var startLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "--:--"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 11)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var endLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "--:--"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 11)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let labelWidth: CGFloat = 40
    private let progressPointSize: CGFloat = 20
    private let lineHeight: CGFloat = 5
    private let progressLayer = CALayer()
    private var isChangeProgress = false
    private var startOffset: CGFloat = 0
    private var progressPointMaxConstntX: CGFloat {
        self.frame.width - (labelWidth * 2) - progressPointSize
    }
    
    private var progressPointConstraint: NSLayoutConstraint!
    
    weak var delegate: SAPlayerProgressViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(progressLayer)
        progressLayer.backgroundColor = UIColor.orange.cgColor
        addSubview(progressPoint)
        addSubview(startLabel)
        addSubview(endLabel)
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGestureAction))
        addGestureRecognizer(panGesture)
        
        progressPointConstraint = progressPoint.leadingAnchor.constraint(equalTo: startLabel.trailingAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            startLabel.topAnchor.constraint(equalTo: topAnchor),
            startLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            startLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            startLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            
            endLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            endLabel.topAnchor.constraint(equalTo: topAnchor),
            endLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            endLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            progressPoint.heightAnchor.constraint(equalToConstant: progressPointSize),
            progressPoint.widthAnchor.constraint(equalToConstant: progressPointSize),
            progressPoint.centerYAnchor.constraint(equalTo: centerYAnchor),
            progressPointConstraint
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let constatnt = labelWidth * 2 + 10
        progressLayer.frame.size = .init(width: self.frame.width - constatnt, height: lineHeight)
        progressLayer.cornerRadius = progressLayer.frame.height / 2
        progressLayer.frame.origin = .init(x: labelWidth + 5, y: (frame.size.height / 2) - (lineHeight / 2))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProgress(progress: Double, currentTime: String, duration: String) {
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            self.progressPointConstraint.constant = min(self.progressPointMaxConstntX * progress, self.progressPointMaxConstntX)
            self.layoutIfNeeded()
        }
        startLabel.text = currentTime
        self.endLabel.text = duration
    }
    
    @objc private func panGestureAction(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            print(progressPoint.frame)
            startOffset = progressPointConstraint.constant
            isChangeProgress = progressPoint.frame.contains(gesture.location(in: self))
        case .changed:
            if isChangeProgress {
                let translationX = gesture.translation(in: self).x + startOffset
                print(translationX)
                progressPointConstraint.constant = max(0, min(progressPointMaxConstntX, translationX))
                delegate?.progresView(progress: progressPointConstraint.constant / progressPointMaxConstntX)
            }
        case .ended:
            isChangeProgress = false
        default: return
        }
    }
}
