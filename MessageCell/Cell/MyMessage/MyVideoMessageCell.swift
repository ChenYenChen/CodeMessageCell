//
//  MyVideoMessageCell.swift
//  MessageCell
//
//  Created by Ray on 2021/7/7.
//

import Foundation
import UIKit

final class MyVideoMessageCell: MyMessageCell {
    
    private var videoView: VideoMessageView = .fromNib()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        messageStackView.addArrangedSubview(videoView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
