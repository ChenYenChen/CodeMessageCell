//
//  FullMessageCell.swift
//  MessageCell
//
//  Created by Ray on 2021/7/4.
//

import UIKit

class FullMessageCell: BasicMessageCell {
    
    var messageStackView: UIStackView!
    var dateLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSetupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetupUI()
    }
}
extension FullMessageCell {
    
    // ---------ContentView--------
    // |          |8              |
    // |   |----StackView-----|   |
    // |   |                  |   |
    // |   |                  |   |
    // |-8-|                  |-8-|
    // |   |                  |   |
    // |   |                  |   |
    // |   |                  |   |
    // |   |                  |   |
    // |   |------------------|   |
    // |                  -4|     |
    // |          | dateLabel |-H:15
    // |          |-----------|   |
    // |                   8|     |
    // |--------------------------|
    private func initSetupUI() {
        messageStackView = .init()
            .add(to: contentView)
            .anchor(\.topAnchor, to: contentView.topAnchor, constant: 8)
            .anchor(\.leadingAnchor, to: contentView.leadingAnchor, constant: 8)
            .anchor(\.trailingAnchor, to: contentView.trailingAnchor, constant: -8)
        
        messageStackView.axis = .vertical
        messageStackView.alignment = .fill
        messageStackView.distribution = .fill
        messageStackView.spacing = 0
        
        dateLabel = .init()
            .add(to: contentView)
            .anchor(\.heightAnchor, to: 15)
            .anchor(\.topAnchor, to: messageStackView.bottomAnchor, constant: 4)
            .anchor(\.trailingAnchor, to: messageStackView.trailingAnchor)
            .anchor(\.bottomAnchor, to: contentView.bottomAnchor, constant: -8)
    }
}
