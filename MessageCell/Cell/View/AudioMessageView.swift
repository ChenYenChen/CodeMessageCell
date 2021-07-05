//
//  AudioMessageView.swift
//  Beanfun
//
//  Created by JXEE on 2020/8/28.
//  Copyright © 2020 Gamania. All rights reserved.
//

import UIKit

protocol AudioMessageViewDelegate: class {
    func audioMessageViewDidDragSlider(phase: UITouch.Phase, value: Float?)
}

final class AudioMessageView: UIView {
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var currentLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider! {
        didSet {
            progressSlider.addTarget(self, action: #selector(onSliderChanged(slider:for:)), for: .valueChanged)
        }
    }
    
    @IBOutlet private weak var widthConstraint: NSLayoutConstraint!
    
    weak var delegate: AudioMessageViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with current: Int, duration: Int, isPlaying: Bool = false, isMe: Bool = true) {
//        durationLbl.textColor = isMe ? .white : .customGray1
//        progressSlider.maximumTrackTintColor = isMe ? .customGray2 : .customGray3
//        progressSlider.minimumTrackTintColor = isMe ? .white : .customMain
//        progressSlider.thumbTintColor = isMe ? .white : .customMain
        
        let isHidden = !isPlaying
        widthConstraint.constant = isHidden ? 0 : UIScreen.main.bounds.width * 0.6
        stackView.isHidden = isHidden
        layoutIfNeeded()
        
//        currentLbl.text = Timestamp(current).toDate().toString(formater: .mmss)
//        durationLbl.text = Timestamp(duration).toDate().toString(formater: .mmss)
        progressSlider.value = Float(current) / Float(duration)
    }
    
    @objc private func onSliderChanged(slider: UISlider, for event: UIEvent) {
        guard let touch = event.allTouches?.first else { return }
        delegate?.audioMessageViewDidDragSlider(phase: touch.phase, value: slider.value)
    }
}
