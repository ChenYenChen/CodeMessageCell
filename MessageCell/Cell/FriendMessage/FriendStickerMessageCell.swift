//
//  FriendStickerMessageCell.swift
//  MessageCell
//
//  Created by Ray on 2021/7/8.
//

import Foundation
import UIKit

final class FriendStickerMessageCell: FriendMessageCell {
    
    private var stickerView: StickerMessageView = .fromNib()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        messageStackView.addArrangedSubview(stickerView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
