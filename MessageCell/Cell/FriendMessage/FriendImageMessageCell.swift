//
//  FriendImageMessageCell.swift
//  MessageCell
//
//  Created by Ray on 2021/7/8.
//

import Foundation
import UIKit

final class FriendImageMessageCell: FriendMessageCell {
    
    private var imageMessageView: ImageMessageView = .fromNib()
    var imgView: UIImageView {
        imageMessageView.photoView
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        messageStackView.addArrangedSubview(imageMessageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
