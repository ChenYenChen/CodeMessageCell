//
//  ImageMessageView.swift
//  Beanfun
//
//  Created by Joe Pan on 2020/4/18.
//  Copyright © 2020 Gamania. All rights reserved.
//

import Foundation
import UIKit

protocol MediaMessageViewDelegate: class {
    func mediaMessageViewSizeDidUpdate(to size: CGSize)
    func mediaMessageViewDidTapped()
    func mediaMessageViewCancelDidTapped()
}

final class ImageMessageView: UIView {
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private(set) var photoView: UIImageView!
    @IBOutlet private weak var photoHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var photoWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var loadingViewLabel: UILabel!
    @IBOutlet private weak var failViewLabel: UILabel!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var failView: UIView!
    
    private var totalFileSize: Int = 0
    
    weak var delegate: MediaMessageViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = true
        progressView.layer.masksToBounds = true
        progressView.layer.cornerRadius = 4
        photoView.contentMode = .scaleAspectFill
        loadingView.isHidden = true
        failView.isHidden = true
        failViewLabel.text = "上傳失敗"
        let tap = UITapGestureRecognizer(target: self, action: #selector(photoDidTapped))
        addGestureRecognizer(tap)
    }
    
    deinit {
        progressView.observedProgress?.removeObserver(self, forKeyPath: "fractionCompleted")
    }
    
    func configure(with photoURL: URL?, progress: Progress? = nil, imageSize: CGSize?, fileSize: Int?) {
        let size = MessageCalculate().imageSize(with: imageSize ?? .zero)
        resizeMessageView(with: size)
        
        if let imageUrl = photoURL {
            updateMainImage(
                imageURL: imageUrl,
                updateProgressUIByDownloadProgress: progress == nil,
                imageSize: size
            )
        } else {
            photoView.image = nil
        }
        
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
    }
    
    func configureForReuse() {
        photoView.image = nil
        loadingViewLabel.text = nil
        loadingView.isHidden = true
        failView.isHidden = true
    }
}

extension ImageMessageView {

    @objc private func photoDidTapped() {
        delegate?.mediaMessageViewDidTapped()
    }
    
    @IBAction private func cancelDidTapped(_ sender: UIButton) {
        delegate?.mediaMessageViewCancelDidTapped()
    }
}

extension ImageMessageView {
    
    private func updateMainImage(imageURL: URL,
                                 updateProgressUIByDownloadProgress: Bool,
                                 imageSize: CGSize) {
        
    }
    
    private func resizeMessageView(with imageSize: CGSize) {
        guard !imageSize.width.isNaN && !imageSize.height.isNaN else { return }
        photoWidthConstraint.constant = imageSize.width
        photoHeightConstraint.constant = imageSize.height
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

extension ImageMessageView {
    override internal func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        DispatchQueue.main.async {
            let current = self.convertFileSizeText(size: Int(Float(self.totalFileSize) * self.progressView.progress))
            let total = self.convertFileSizeText(size: self.totalFileSize)
            self.loadingViewLabel.text = "\(current)/\(total)"
        }
    }
}
