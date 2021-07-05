//
//  FriendMessageCell.swift
//  MessageCell
//
//  Created by Ray on 2021/7/4.
//

import UIKit

class FriendMessageCell: BasicMessageCell {
    
    var userAvatarImageView: UIImageView!
    var userNameLabel: UILabel!
    var bubbleImageView: UIImageView!
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
extension FriendMessageCell {
    
    // ---------ContentView-----------------------------------------------------|
    // |     |10                                                                |
    // |   |-------|   |-----outsideStackView-------------------------------|   |
    // |-8-|avatar |-8-||------userNameLabel-------------------------------||   |
    // |   |       |   ||------ H:14 --------------------------------------||   |
    // |   |-------|   |------- spacing:4 ----------------------------------|   |
    // | H:30,W:30     ||------- messageView-------------------------------||   |
    // |               |||-------bubbleImageView-------------|             ||   |
    // |               |||           |8                      |             ||   |
    // |               |||    |----messageStackView-----|    |             ||-6-|
    // |               |||-12-|                         |-12-| H: >=40     ||   |
    // |               |||    |-------------------------|    | W: <=250    ||   |
    // |               |||           |8                      |             ||   |
    // |               |||-----------------------------------|-2-|dataLabel||   |
    // |               ||--------------------------------------------------||   |
    // |               |----------------------------------------------------|   |
    // |                    | 10                                                |
    // |------------------------------------------------------------------------|
    private func initSetupUI() {
        userAvatarImageView = .init()
            .add(to: contentView)
            .anchor(\.heightAnchor, to: 30)
            .anchor(\.widthAnchor, to: 30)
            .anchor(\.topAnchor, to: contentView.topAnchor, constant: 10)
            .anchor(\.leadingAnchor, to: contentView.leadingAnchor, constant: 8)
        
        let outsideStackView: UIStackView = .init()
            .add(to: contentView)
            .anchor(\.topAnchor, to: userAvatarImageView.topAnchor)
            .anchor(\.leadingAnchor, to: userAvatarImageView.leadingAnchor, constant: 8)
            .anchor(\.trailingAnchor, to: contentView.trailingAnchor, constant: -8)
            .anchor(\.bottomAnchor, to: contentView.bottomAnchor, constant: -10)
        
        outsideStackView.axis = .vertical
        outsideStackView.alignment = .leading
        outsideStackView.distribution = .fill
        outsideStackView.spacing = 4
        
        userNameLabel = .init()
        outsideStackView.addArrangedSubview(userNameLabel)
        userNameLabel.anchor(\.heightAnchor, to: 14)
        userNameLabel.font = .systemFont(ofSize: 11)
        userNameLabel.text = "Ray"
        
        let messageView: UIView = .init()
        outsideStackView.addArrangedSubview(messageView)
        messageView.translatesAutoresizingMaskIntoConstraints = false
        
        bubbleImageView = .init()
            .add(to: messageView)
            .anchor(\.heightAnchor, .greaterThanOrEqual, to: 40)
            .anchor(\.widthAnchor, .greaterThanOrEqual, to: 40)
            .anchor(\.widthAnchor, .lessThanOrEqual, to: 250)
            .anchor(\.topAnchor, to: messageView.topAnchor)
            .anchor(\.leadingAnchor, to: messageView.leadingAnchor)
            .anchor(\.bottomAnchor, to: messageView.bottomAnchor)
        
        messageStackView = .init()
            .add(to: messageView)
            .anchor(\.topAnchor, to: bubbleImageView.topAnchor, constant: 8)
            .anchor(\.leadingAnchor, to: bubbleImageView.leadingAnchor, constant: 12)
            .anchor(\.trailingAnchor, to: bubbleImageView.trailingAnchor, constant: -12)
            .anchor(\.bottomAnchor, to: bubbleImageView.bottomAnchor, constant: -8)
        
        dateLabel = .init()
            .add(to: messageView)
            .anchor(\.bottomAnchor, to: messageView.bottomAnchor)
            .anchor(\.leadingAnchor, to: bubbleImageView.trailingAnchor, constant: 2)
            .anchor(\.trailingAnchor, .greaterThanOrEqual, to: messageView.trailingAnchor, constant: -20)
        
        dateLabel.font = .systemFont(ofSize: 10)
    }
}
