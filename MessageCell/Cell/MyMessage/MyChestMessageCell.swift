//
//  MyChestMessageCell.swift
//  MessageCell
//
//  Created by Ray on 2021/7/7.
//

import Foundation
import UIKit

final class MyChestMessageCell: MyMessageCell {
    
    private var chestView: ChestMessageView = .fromNib()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        messageStackView.addArrangedSubview(chestView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
