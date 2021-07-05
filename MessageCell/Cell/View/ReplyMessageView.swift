//
//  ReplyMessageView.swift
//  Beanfun
//
//  Created by Joe Pan on 2020/4/17.
//  Copyright © 2020 Gamania. All rights reserved.
//

import Foundation
import UIKit

final class ReplyMessageView: UIView {

    var tapCallback: (() -> Void)?

    @IBOutlet private(set) var userIcon: UIImageView!
    @IBOutlet private(set) var nameLabel: UILabel!
    @IBOutlet private(set) var contentLabel: UILabel!
    @IBOutlet private(set) var mediaImgView: UIImageView!
    @IBOutlet private(set) var separatorLine: UIView!

    override func awakeFromNib() {
        superview?.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 57),
            // 這邊限制為最小134的話，回覆訊息最小會為UI要的最小值150
            widthAnchor.constraint(greaterThanOrEqualToConstant: 134.0)
        ])
        gestureRecognizers?.removeAll()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        tap.numberOfTapsRequired = 1
        addGestureRecognizer(tap)
        mediaImgView.contentMode = .scaleAspectFill
        mediaImgView.layer.cornerRadius = 10
        nameLabel.text = ""
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let edge: CGFloat = 8 + userIcon.frame.width + 8 + 12
        nameLabel.sizeToFit()
        contentLabel.sizeToFit()
        let nameWidth = nameLabel.frame.width
        let contentWidth = contentLabel.frame.width
        let maxTextWidth = nameWidth > contentWidth ? nameWidth : contentWidth
        let imageWidth: CGFloat = mediaImgView.isHidden ? 0 : mediaImgView.frame.width + 4
        var finalWidth = edge + maxTextWidth + imageWidth
        finalWidth = finalWidth > 200 ? 200 : finalWidth
        finalWidth = finalWidth < 134 ? 134 : finalWidth
        return CGSize(width: finalWidth, height: 57)
    }
}

// MARK: - Public

extension ReplyMessageView {

//    func configure(with message: Chat.DisplayedReplyMessage) {
//        setupUserIcon(with: message)
//        setupNameLabel(with: message)
//        setupContentLabel(with: message)
//        setupMediaImgView(with: message)
//    }

    func configureForReuse() {
//        userIcon.cancelImageDownloadTask()
//        mediaImgView.cancelImageDownloadTask()
//        userIcon.image = .bf_chatDefaultPortrait
//        mediaImgView.image = .bf_chatMessageCellPlaceholder
        nameLabel.text = ""
        contentLabel.text = ""
    }
    
//    func setupUserInfo(with info: Chat.DisplayUser?) {
//        nameLabel.text = info?.nickName ?? ""
//        ImageDownloader.setImage(userIcon,
//                                 with: info?.avator ?? nil,
//                                 placeholder: .bf_chatListDefaultUser)
//    }
}

// MARK: - Private

extension ReplyMessageView {

//    private func setupUserIcon(with message: Chat.DisplayedReplyMessage) {
//        userIcon.layer.cornerRadius = userIcon.frame.width / 2
//        let url = URL(string: message.senderAvatar)
//        ImageDownloader.setImage(userIcon,
//                                 with: url ,
//                                 placeholder: .bf_chatListDefaultUser)
//    }
//
//    private func setupNameLabel(with message: Chat.DisplayedReplyMessage) {
//        nameLabel.text = message.senderNickname
//    }
//
//    private func setupContentLabel(with message: Chat.DisplayedReplyMessage) {
//        contentLabel.text = message.content
//    }
//
//    private func setupMediaImgView(with message: Chat.DisplayedReplyMessage) {
//        if !message.thumbnailUri.isEmpty {
//            // TODO: holder
//            mediaImgView.isHidden = false
//            mediaImgView.sd_setImage(with: URL(string: message.thumbnailUri))
//        } else {
//            mediaImgView.isHidden = true
//        }
//    }

    @objc private func tapHandler(_ sender: UITapGestureRecognizer) {
        tapCallback?()
    }
}
