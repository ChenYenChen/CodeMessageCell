//
//  MyTextMessageCell.swift
//  MessageCell
//
//  Created by Ray on 2021/7/4.
//

import Foundation
import UIKit

final class MyTextMessageCell: MyMessageCell {
    
    private var textView: TextMessageView = .fromNib()
    var textContentLabel: UILabel {
        textView.contentLabel
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        messageStackView.addArrangedSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
