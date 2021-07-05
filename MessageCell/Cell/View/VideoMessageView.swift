//
//  VideoMessageView.swift
//  Beanfun
//
//  Created by Joe Pan on 2020/4/18.
//  Copyright © 2020 Gamania. All rights reserved.
//

import Foundation
import UIKit

final class VideoMessageView: UIView {
    
    @IBOutlet private(set) weak var previewImageView: UIImageView!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var videoViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var videoViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var loadingViewLabel: UILabel! {
        didSet {
//            loadingViewLabel.font = .caption3
//            loadingViewLabel.textColor = .bfWhite
        }
    }
    @IBOutlet private weak var readyViewLabel: UILabel! {
        didSet {
//            readyViewLabel.font = .caption3M
//            readyViewLabel.textColor = .bfWhite
        }
    }
    @IBOutlet private weak var failViewLabel: UILabel! {
        didSet {
//            failViewLabel.font = .caption3M
//            failViewLabel.textColor = .bfWhite
        }
    }
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var failView: UIView!
    @IBOutlet weak var readyView: UIView!
    
    private var totalFileSize: Int = 0
    
    weak var delegate: MediaMessageViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        progressView.layer.masksToBounds = true
        progressView.layer.cornerRadius = 4
        layer.cornerRadius = 5
        layer.masksToBounds = true
        previewImageView.contentMode = .scaleAspectFill
        loadingView.isHidden = true
        readyView.isHidden = true
        failView.isHidden = true
//        failViewLabel.text = .bf_chatSendFailed
    }
    
    deinit {
        progressView.observedProgress?.removeObserver(self, forKeyPath: "fractionCompleted")
    }
    
    
    // TODO: refactor progress ui update logic.
    func configure(with photoURL: URL?,
                   videoURL: URL?,
                   progress: Progress? = nil,
                   previewImageSize: CGSize?,
                   duration: Int?,
                   isCancelable: Bool,
                   fileSize: Int?) {
        
        let size = MessageCalculate().imageSize(with: previewImageSize ?? .zero)
        resizeMessageView(with: size)
        
        updateMainImage(imageURL: photoURL,
                        previewImageSize: size,
                        updateProgressUIByDownloadProgress: progress == nil)
        
        cancelButton.isHidden = !isCancelable
        
        let isProgressHidden = progress == nil || progress?.fractionCompleted == 1
        loadingView.isHidden = isProgressHidden
        progressView.observedProgress = progress
        progress?.addObserver(self, forKeyPath: "fractionCompleted", options: [.new, .old], context: nil)
        progress?.resume()
        if let fileSize = fileSize {
            totalFileSize = fileSize
            let currentValue: Int = Int(Float(totalFileSize) * progressView.progress)
            loadingViewLabel.text = "\(convertFileSizeText(size: currentValue))/\(convertFileSizeText(size: fileSize))"
        } else {
            loadingViewLabel.text = nil
        }
//        readyViewLabel.text = duration?.toDate().toString(formater: .mmss)
    }
    
    func configureForReuse() {
//        previewImageView.image = .bf_chatMessageCellPlaceholder
        loadingViewLabel.text = nil
        loadingView.isHidden = true
        readyView.isHidden = true
        failView.isHidden = true
    }
}

extension VideoMessageView {
    
    @IBAction private func playDidTapped(_ sender: UIButton) {
        delegate?.mediaMessageViewDidTapped()
    }
    
    @IBAction private func cancelDidTapped(_ sender: UIButton) {
        delegate?.mediaMessageViewCancelDidTapped()
    }
    
    // TODO: 補完影片Cell大小調整的邏輯
    private func updateMainImage(imageURL: URL?,
                                 previewImageSize: CGSize,
                                 updateProgressUIByDownloadProgress: Bool) {
        
        if let photoURL = imageURL {
            resizeMessageView(with: previewImageSize)
            
//            ImageDownloader.setImage(
//                previewImageView,
//                with: photoURL,
//                placeholder: .bf_chatMessageCellPlaceholder,
//                transitionDuration: 0.25,
//                progressBlock: { [weak self] value in
//                    guard updateProgressUIByDownloadProgress else { return }
//                    self?.progressView.setProgress(value, animated: true)
//                },
//                completion: { [weak self] image, error, _, url in
//                    guard let self = self else { return }
//                    guard let image = image else { return }
//
//                    let newSize = self.calculateSize(with: image.size)
//                    self.resizeMessageView(with: newSize)
//
//                    guard newSize.width != previewImageSize.width || newSize.height != previewImageSize.height else { return }
//                    self.resizeMessageView(with: newSize)
//                    self.delegate?.mediaMessageViewSizeDidUpdate(to: newSize)
//            })
        } else {
//            previewImageView.image = .bf_chatMessageCellPlaceholder
            resizeMessageView(with: previewImageSize)
        }
    }
    
    private func resizeMessageView(with imageSize: CGSize) {
        guard !imageSize.width.isNaN && !imageSize.height.isNaN else { return }
        videoViewWidthConstraint.constant = imageSize.width
        videoViewHeightConstraint.constant = imageSize.height
    }
    
    private func convertFileSizeText(size: Int) -> String {
        let units = ["bytes", "KB", "MB", "GB"]
        var value: Double = Double(size)
        var factor = 0
        while value > 1024 {
            value /= 1024
            factor += 1
        }
        return String(format: "%.0f%@", value, units[factor])
    }
}

extension VideoMessageView {
    override internal func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        DispatchQueue.main.async {
            let current = self.convertFileSizeText(size: Int(Float(self.totalFileSize) * self.progressView.progress))
            let total = self.convertFileSizeText(size: self.totalFileSize)
            self.loadingViewLabel.text = "\(current)/\(total)"
        }
    }
}
