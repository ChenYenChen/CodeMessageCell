//
//  ObjectMessageView.swift
//  Beanfun
//
//  Created by Joe Pan on 2020/4/28.
//  Copyright © 2020 Gamania. All rights reserved.
//

import UIKit

final class ChestMessageView: UIView {

    var buttonClicked: (() -> Void)?

    var expiredTime: TimeInterval = 1.0 {
        didSet {
            startTimer()
        }
    }
    
    var timer: CADisplayLink?
    
    private var enableString: String?
    private var disabelString: String?
    
    @IBOutlet weak var titleLabelBottomToIconImagBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var contentViewToTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lineView: UIView! {
        didSet {
//            lineView.backgroundColor = .bfLightGray
        }
    }
    
    @IBOutlet weak var countdownView: UIView! {
        didSet {
            countdownView.layer.cornerRadius = countdownLabel.layer.frame.height / 2
            countdownView.layer.borderWidth = 1
//            countdownView.layer.borderColor = UIColor.bfSecondaryA.cgColor
            countdownView.isHidden = true
        }
    }

    @IBOutlet private var countdownLabel: UILabel! {
        didSet {
//            countdownLabel.textColor = .bfSecondaryA
            countdownLabel.textAlignment = .center
//            countdownLabel.backgroundColor = .bfWhite
//            countdownLabel.font = .caption2M
        }
    }
    
    @IBOutlet private(set) var contentView: UIView! {
        didSet {
//            contentView.backgroundColor = .bfWhite
            contentView.layer.masksToBounds = true
            contentView.layer.cornerRadius = 20
            contentView.layer.borderWidth = 1
//            contentView.layer.borderColor = UIColor.bfLightGray.cgColor
        }
    }
    @IBOutlet private(set) var backgroundImg: UIImageView!
    @IBOutlet private(set) var backgroundImgHeight: NSLayoutConstraint!
    @IBOutlet private var iconImg: UIImageView!
    @IBOutlet private(set) var titleLabel: UILabel! {
        didSet {
//            titleLabel.font = .headline
//            titleLabel.textColor = .bfDark
        }
    }
    @IBOutlet private(set) var descLabel: UILabel! {
        didSet {
//            descLabel.font = .body2
//            descLabel.textColor = .bfDarkGray
        }
    }
    @IBOutlet private(set) var button: UIButton! {
        didSet {
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 20.0
//            button.backgroundColor = .bfDarkPrimary
//            button.setBackgroundImage(UIImage(color: .bfPrimary), for: .normal)
//            button.setBackgroundImage(UIImage(color: .bfDarkPrimary), for: .highlighted)
//            button.setBackgroundImage(UIImage(color: .bfDarkPrimary), for: .selected)
//            button.setBackgroundImage(UIImage(color: .bfLightGray), for: .disabled)
//            button.setTitleColor(.bfWhite, for: .normal)
//            button.setTitleColor(.bfWhite, for: .highlighted)
//            button.setTitleColor(.bfWhite, for: .selected)
//            button.setTitleColor(.bfWhite, for: .disabled)
//            button.set(font:.subhead1M )
        }
    }

//    func configure(with message: Chat.DisplayedChestMessage) {
//        enableString = message.enableString
//        disabelString = message.disableString
//
//        setupBackgroundImg(message.background, thumbnail: message.backgroundThumbnail, haveIcon: message.icon != nil)
//        setupIcon(message.icon, thumbnail: message.iconThumbnail)
//        setupTitle(message.title)
//        setupContent(message.content)
//        expiredTime = TimeInterval(message.expiredTime)
        
        // Need to checkout expired
//        if let time = countdownTime() {
//            let isExpired = time <= 0
//            setupButton(expired: isExpired)
//            showCountdownView(isExpired: isExpired, time: time)
//        } else {
//            setupButton(expired: false)
//        }
//
//    }
    
    func startTimer() {
        stopTimer()
        timer = CADisplayLink(target: self, selector: #selector(handleTimer(_:)))
        timer?.add(to: .main, forMode: .default)
    }
    
    func stopTimer() {
        countdownView.isHidden = true
        timer?.invalidate()
        timer = nil
    }
}

private extension ChestMessageView {

    @IBAction private func buttonClicked(_ sender: UIButton) {
        buttonClicked?()
    }

    private func setupBackgroundImg(_ url: URL?, thumbnail: URL?, haveIcon: Bool) {
        lineView.isHidden = haveIcon
        titleLabelBottomToIconImagBottomConstraint.constant = haveIcon ? 32.0 : 10.0
        contentViewToTopConstraint.constant = haveIcon ? iconImg.bounds.height / 2 : 0
        
        if url == nil {
            // 沒背景圖片但有Icon圖片, 高要 60
            // 沒背景圖片且沒Icon圖片, 高為 0
            backgroundImgHeight.constant = haveIcon ? 60.0 : 0.0
        } else {
            // 有背景圖片, 高要 16: 9
            backgroundImgHeight.constant =  frame.width * 9 / 16
//            backgroundImg.kf.setImage(with: thumbnail)
//            backgroundImg.kf.setImage(with: url)
        }
    }

    private func setupIcon(_ url: URL?, thumbnail: URL?) {
//        iconImg.kf.setImage(with: thumbnail ?? url)
    }

    private func setupTitle(_ aTitle: String?) {
        titleLabel.text = aTitle
    }

    private func setupContent(_ desc: String?) {
        descLabel.text = desc
    }

    private func setupButton(expired: Bool) {
        button.isEnabled = !expired
        let title = expired ? disabelString : enableString
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .highlighted)
        button.setTitle(title, for: .disabled)
    }
    
    // if return is nil, means never expired
    private func countdownTime() -> TimeInterval? {
        // if expiredTime <= 0.0, means do not check expired
        guard expiredTime > 0.0 else { return nil }
        
        let expiredDate = Date(timeIntervalSince1970: expiredTime)
        let now = Date()
        let time = expiredDate.timeIntervalSince(now)
        
        return time
    }
    
    private func showCountdownView(isExpired: Bool, time: TimeInterval) {
//        countdownLabel.text = time.countDownString
        countdownView.isHidden = isExpired
    }

    @objc
    private func handleTimer(_ timer: CADisplayLink) {
        guard let time = countdownTime() else {
            stopTimer()
            return
        }
        
        if time <= 0 {
            setupButton(expired: true)
            stopTimer()
        } else {
//            countdownLabel.text = time.countDownString
            countdownView.isHidden = false
        }
    }
}
