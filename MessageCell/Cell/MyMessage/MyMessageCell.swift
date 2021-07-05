//
//  MyMessageCell.swift
//  MessageCell
//
//  Created by Ray on 2021/7/4.
//

import UIKit

class MyMessageCell: BasicMessageCell {
    
    var resendButton: UIButton!
    var bubbleImageView: UIImageView!
    var messageStackView: UIStackView!
    var statusImageView: UIImageView!
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
extension MyMessageCell {
    
    // ---------ContentView----------------------------------------------------------|
    // |                                                   |10                       |
    // |                                   |-----------outsideStackView----------|   |
    // |                                   ||------messageView------------|-|----|   |
    // |                                   |||------bubbleImageView------||s|re  |   |
    // |                                   |||           |8              ||p|send|   |
    // |                                   |||    |-messageStackView|    ||a|btn |   |
    // |                                   |||    |                 |    ||c|    |   |
    // |                                   |||    |                 |    ||i||--||   |
    // |                                   |||-12-|                 |-12-||n||--||-8-|
    // |                                   |||    |                 |    ||g|    |   |
    // |                                   |||    |-----------------|    ||:|H:24|   |
    // |                H:14               |||           |8              ||8|W:24|   |
    // |        |----dateStackView--------||||---------------------------|| |    |   |
    // |-min:20-||dateLabel|2|statusImage||||-----------------------------| |    |   |
    // |        |-------------------------||-------------------------------------|   |
    // |                                                    |10                      |
    // |-----------------------------------------------------------------------------|
    private func initSetupUI() {
        
        let outsideStackView: UIStackView = .init()
            .add(to: contentView)
            .anchor(\.topAnchor, to: contentView.topAnchor, constant: 10)
            .anchor(\.trailingAnchor, to: contentView.trailingAnchor, constant: -8)
            .anchor(\.bottomAnchor, to: contentView.bottomAnchor, constant: -10)
        
        outsideStackView.axis = .horizontal
        outsideStackView.alignment = .center
        outsideStackView.distribution = .fill
        outsideStackView.spacing = 8
        
        let messageView: UIView = .init()
        outsideStackView.addArrangedSubview(messageView)
        
        resendButton = .init()
        outsideStackView.addArrangedSubview(resendButton)
        resendButton
            .anchor(\.heightAnchor, to: 24)
            .anchor(\.widthAnchor, to: 24)
        
        bubbleImageView = .init()
            .add(to: messageView)
            .anchor(\.heightAnchor, .greaterThanOrEqual, to: 40)
            .anchor(\.widthAnchor, .greaterThanOrEqual, to: 40)
            .anchor(\.widthAnchor, .lessThanOrEqual, to: 250)
            .anchor(\.topAnchor, to: messageView.topAnchor)
            .anchor(\.leadingAnchor, to: messageView.leadingAnchor)
            .anchor(\.trailingAnchor, to: messageView.trailingAnchor)
            .anchor(\.bottomAnchor, to: messageView.bottomAnchor)
        
        messageStackView = .init()
            .add(to: messageView)
            .anchor(\.topAnchor, to: bubbleImageView.topAnchor, constant: 8)
            .anchor(\.leadingAnchor, to: bubbleImageView.leadingAnchor, constant: 12)
            .anchor(\.trailingAnchor, to: bubbleImageView.trailingAnchor, constant: -12)
            .anchor(\.bottomAnchor, to: bubbleImageView.bottomAnchor, constant: -8)
        
        let dateStackView: UIStackView = .init()
            .add(to: contentView)
            .anchor(\.heightAnchor, to: 14)
            .anchor(\.bottomAnchor, to: outsideStackView.bottomAnchor)
            .anchor(\.trailingAnchor, to: outsideStackView.leadingAnchor)
            .anchor(\.leadingAnchor, .greaterThanOrEqual, to: contentView.leadingAnchor, constant: 20)

        dateStackView.axis = .horizontal
        dateStackView.alignment = .fill
        dateStackView.distribution = .fill
        dateStackView.spacing = 2
        
        dateLabel = .init()
        dateStackView.addArrangedSubview(dateLabel)
        
        statusImageView = .init()
        dateStackView.addArrangedSubview(statusImageView)
        statusImageView.anchor(\.widthAnchor, to: 14)
    }
}
