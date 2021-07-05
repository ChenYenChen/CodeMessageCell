//
//  MyAudioMessageCell.swift
//  MessageCell
//
//  Created by Ray on 2021/7/8.
//

import Foundation
import UIKit

final class MyAudioMessageCell: MyMessageCell {
    
    private var audioView: AudioMessageView = .fromNib()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        messageStackView.addArrangedSubview(audioView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
