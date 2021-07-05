//
//  StickersComboMessageView.swift
//  Beanfun
//
//  Created by Terry Lai on 2020/5/19.
//  Copyright © 2020 Gamania. All rights reserved.
//

import Foundation
import UIKit

final class StickersComboMessageView: UIView {

    var tapCallback: (() -> Void)?

    @IBOutlet private var stickerImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
//        if SDImageCodersManager.shared.coders?.first(where: { $0 is SDImageAPNGCoder }) == nil {
//            SDImageCodersManager.shared.addCoder(SDImageAPNGCoder.shared)
//        }
//        stickerImageView.contentMode = .scaleAspectFit
//        gestureRecognizers?.removeAll()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle(_:)))
//        tap.numberOfTapsRequired = 1
//        addGestureRecognizer(tap)
    }

//    func configure(with stickers: [StickerItem]) {
//        stickerImageView.loadComboSticker(withStickerItem: stickers)
//    }
//    
//    func configureForReuse() {
//        stickerImageView.image = nil
//    }

    @objc private func tapHandle(_ sender: UITapGestureRecognizer) {
        tapCallback?()
    }
}
