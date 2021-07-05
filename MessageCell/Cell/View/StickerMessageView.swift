//
//  StickerMessageView.swift
//  Beanfun
//
//  Created by Joe Pan on 2020/5/11.
//  Copyright © 2020 Gamania. All rights reserved.
//

import Foundation
import UIKit

final class StickerMessageView: UIView {

    var tapCallback: (() -> Void)?

    @IBOutlet private(set) var stickerImgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
//        if SDImageCodersManager.shared.coders?.first(where: { $0 is SDImageAPNGCoder }) == nil {
//            SDImageCodersManager.shared.addCoder(SDImageAPNGCoder.shared)
//        }
//        stickerImgView.contentMode = .scaleAspectFit
//        gestureRecognizers?.removeAll()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle(_:)))
//        tap.numberOfTapsRequired = 1
//        addGestureRecognizer(tap)
    }

//    func configure(with stickerURL: URL?) {
//        ImageDownloader.downloadAnimatedImage(with: stickerURL) { [weak self] (image) in
//            self?.stickerImgView.image = image
//        }
//    }
//
//    func configureForReuse() {
//        stickerImgView.image = nil
//    }

    @objc private func tapHandle(_ sender: UITapGestureRecognizer) {
        tapCallback?()
    }
}
