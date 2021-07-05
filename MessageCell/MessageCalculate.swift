//
//  MessageCalculate.swift
//  MessageCell
//
//  Created by Ray on 2021/7/7.
//

import UIKit

class MessageCalculate {
    
    // MARK: - calculate cell height
    func textMessageCellHeight(content: NSAttributedString,
                               isSystem: Bool,
                               isMeSend: Bool,
                               hiddenNickname: Bool,
                               hasReply: Bool) -> CGFloat {
        var maxWidth: CGFloat = UIScreen.main.bounds.width
        
        guard !isSystem else {
            maxWidth = maxWidth - 46 - 46
            let calculationHeight = calculationTextHeight(maxWidth: maxWidth, content: content)
            let height = calculationHeight > 18 ? calculationHeight : 18
            return defaultCellEdge(hasMargins: false) + height
        }
        
        maxWidth = 250 - 12 - 12
        let height = calculationTextHeight(maxWidth: maxWidth, content: content)
        
        return defaultCellEdge() + calculationNameHeight(hiddenNickname: isMeSend || hiddenNickname) + height + calculationReplyMessageHeight(hasReply: hasReply)
    }
    
    func stickerMessageCellHeight(isMeSend: Bool, hiddenNickname: Bool, hasReply: Bool) -> CGFloat {
        let defaultStickerHeight: CGFloat = 120
        let totalHeight = defaultStickerHeight + defaultCellEdge(hasMargins: hasReply) + calculationNameHeight(hiddenNickname: isMeSend || hiddenNickname) + calculationReplyMessageHeight(hasReply: hasReply)
        return totalHeight
    }
    
    func albumDescriptionCellHeight(isMeSend: Bool, hiddenNickname: Bool, hasReply: Bool) -> CGFloat {
        let specHeight: CGFloat = 86
        let totalHeight = defaultCellEdge() + calculationNameHeight(hiddenNickname: isMeSend || hiddenNickname) + specHeight
        return totalHeight
    }
    
    func audioMessageCellHeight(isMeSend: Bool, hiddenNickname: Bool, hasReply: Bool) -> CGFloat {
        let buttonHeight: CGFloat = 36
        let totalHeight = defaultCellEdge() + calculationNameHeight(hiddenNickname: isMeSend || hiddenNickname) + buttonHeight + calculationReplyMessageHeight(hasReply: hasReply)
        return totalHeight
    }
    
    func imageMessageCellHeight(size: CGSize, isMeSend: Bool, hiddenNickname: Bool, hasReply: Bool) -> CGFloat {
        let maxHeight: CGFloat = imageSize(with: size).height
        let totalHeight = defaultCellEdge(hasMargins: hasReply) + calculationNameHeight(hiddenNickname: isMeSend || hiddenNickname) + maxHeight + calculationReplyMessageHeight(hasReply: hasReply)
        return totalHeight
    }
    
    func chestMessageCellHeight(title: String, content: String, hasIcon: Bool, isFull: Bool, isMeSend: Bool, hiddenNickname: Bool) -> CGFloat {
        let buttonHeight: CGFloat = 40
        // bottom constraint, button to description constraint,
        var spacingHeight: CGFloat = 16 + 12
        let hasMargin: Bool = true
        let marginWidth: CGFloat = 8
        var iconHeight: CGFloat = 0
        var maxWidth: CGFloat = UIScreen.main.bounds.width
        var titleHieght: CGFloat = 0
        var contentHeight: CGFloat = 0
        
        let titleAttribute: NSMutableAttributedString = .init(string: title)
//        titleAttribute.setAttributes([NSAttributedString.Key.font: UIFont.headline],
//                                     range: NSRange.init(location: 0, length: titleAttribute.length))
        let contentAttribute: NSMutableAttributedString = .init(string: content)
//        contentAttribute.setAttributes([NSAttributedString.Key.font: UIFont.body2],
//                                       range: NSRange.init(location: 0, length: contentAttribute.length))
        func calculationIconHeight() {
            iconHeight = hasIcon ? (maxWidth * 0.35) : 38
        }
        
        func calculationText() {
            // left constraint, right constraint
            let textWidth = maxWidth - 12 - 12
            if !title.isEmpty {
                titleHieght = calculationTextHeight(maxWidth: textWidth, content: titleAttribute)
                spacingHeight = spacingHeight + 32 - titleHieght
            } else {
                // ChestMessageView spec
                spacingHeight = spacingHeight + 10
            }
            
            if !content.isEmpty {
                contentHeight = calculationTextHeight(maxWidth: textWidth, content: contentAttribute)
                contentHeight = contentHeight + (title.isEmpty ? 0 : 8)
            }
        }
        
        guard !isFull else {
            maxWidth = maxWidth - 8 - 8 - (hasMargin ? (marginWidth * 2) : 0)
            calculationIconHeight()
            calculationText()
            // time label height, content constraint label
            let timeHeight: CGFloat = 15 + 11
            let totalHeight = defaultCellEdge(hasMargins: hasMargin) + buttonHeight + iconHeight + titleHieght + contentHeight + spacingHeight + timeHeight
            return totalHeight
        }
        // MyChestMessageCell and FriendChestMessageCell width
        maxWidth = (maxWidth / 375.0 * 250.0)
        calculationIconHeight()
        calculationText()
        let totalHeight = defaultCellEdge(hasMargins: hasMargin) + calculationNameHeight(hiddenNickname: isMeSend || hiddenNickname) + buttonHeight + iconHeight + titleHieght + contentHeight + spacingHeight
        return totalHeight
    }
    
    func interactiveMessageCellHeight(title: String, content: String, options: [String], isExpired: Bool, expiredString: String, isFull: Bool, isMeSend: Bool, hiddenNickname: Bool, hasImage: Bool) -> CGFloat {
        var maxWidth: CGFloat = UIScreen.main.bounds.width
        let hasMargin: Bool = true
        let marginWidth: CGFloat = 8
        // baseHeight
        var titleHeight: CGFloat = 16
        var contentHeight: CGFloat = 8
        var optionHeight: CGFloat = 12
        var imageHeight: CGFloat = 0
        
        func calculationImageHeight() {
            imageHeight = hasImage ? (maxWidth / 414 * 233) : 0
        }
        
        func calculactionText() {
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineBreakMode = .byWordWrapping
            let contentWidth = maxWidth - 12 - 12
            if title.isEmpty == false {
                let titleAttribute: NSMutableAttributedString = .init(string: title)
//                titleAttribute.setAttributes([.font: UIFont.headline],
//                                             range: NSRange.init(location: 0, length: titleAttribute.length))
                titleHeight = titleHeight + calculationTextHeight(maxWidth: contentWidth, content: titleAttribute)
            }
            
            if content.isEmpty == false {
                let contentAttribute: NSMutableAttributedString = .init(string: content)
//                contentAttribute.setAttributes([.font: UIFont.subhead1],
//                                               range: NSRange.init(location: 0, length: contentAttribute.length))
                contentHeight = contentHeight + calculationTextHeight(maxWidth: contentWidth, content: contentAttribute)
            }
            
            // left constraint, right constraint
            let optionTextWidth = maxWidth - 12 - 12
            if isExpired {
                let optionText: NSMutableAttributedString = .init(string: expiredString)
//                optionText.setAttributes([.font: UIFont.subhead1],
//                                         range: NSRange.init(location: 0, length: optionText.length))
                let textHeight = calculationTextHeight(maxWidth: optionTextWidth, content: optionText)
                // optionText top constraint, bottom constraint
                let optionItemHeight: CGFloat = textHeight + 15 + 15
                optionHeight = optionHeight + optionItemHeight
            } else {
                options.forEach({
                    let optionText: NSMutableAttributedString = .init(string: $0)
//                    optionText.setAttributes([.font: UIFont.subhead1],
//                                             range: NSRange.init(location: 0, length: optionText.length))
                    let textHeight = calculationTextHeight(maxWidth: optionTextWidth, content: optionText)
                    let optionItemHeight: CGFloat = textHeight + 15 + 15
                    optionHeight = optionHeight + optionItemHeight
                })
            }
        }
        
        guard !isFull else {
            maxWidth = maxWidth - 8 - 8 - (hasMargin ? (marginWidth * 2) : 0)
            let timeLabelHeight: CGFloat = 15
            calculactionText()
            calculationImageHeight()
            let totalHeight = defaultCellEdge(hasMargins: hasMargin) + imageHeight + titleHeight + contentHeight + optionHeight + timeLabelHeight
            return totalHeight
        }
        maxWidth = (maxWidth / 375.0 * 250.0)
        calculactionText()
        calculationImageHeight()
        let totalHeight = defaultCellEdge(hasMargins: hasMargin) + imageHeight + calculationNameHeight(hiddenNickname: isMeSend || hiddenNickname) + titleHeight + contentHeight + optionHeight
        return totalHeight
    }
    
    func albumPhotoMessageCellHeight(isMeSend: Bool, hiddenNickname: Bool) -> CGFloat {
        // MyAlbumMessagePhotoCell
        let sepcHeight: CGFloat = 326
        let totalHeight = defaultCellEdge(hasMargins: false) + calculationNameHeight(hiddenNickname: isMeSend || hiddenNickname) + sepcHeight
        return totalHeight
    }
    
    func imageSize(with originSize: CGSize) -> CGSize {
        let minWidth: CGFloat = 80
        let minHeight: CGFloat = 80
        let maxWidth: CGFloat = 240
        let maxHeight: CGFloat = 320
        
        guard originSize.height.isNaN == false,
              originSize.width.isNaN == false,
              originSize.height != 0,
              originSize.width != 0 else {
            return .init(width: maxWidth, height: maxHeight)
        }
        
        let width: CGFloat
        let height: CGFloat
        
        if originSize.width > originSize.height {
            if originSize.width / originSize.height > maxWidth / minHeight {
                width = maxWidth
                height = minHeight
            } else {
                width = maxWidth
                height = originSize.height / originSize.width * maxWidth
            }
        } else {
            if originSize.height / originSize.width > maxHeight / minWidth {
                width = minWidth
                height = maxHeight
            } else {
                width = originSize.width / originSize.height * maxHeight
                height = maxHeight
            }
        }
        return .init(width: width, height: height)
    }
}
extension MessageCalculate {
    private func defaultCellEdge(hasMargins: Bool = true) -> CGFloat {
        let top: CGFloat = 10
        let bottom: CGFloat = 10
        let margins: CGFloat = 8
        return top + bottom + (hasMargins ? margins * 2 : 0)
    }
    
    private func calculationNameHeight(hiddenNickname: Bool) -> CGFloat {
        let nicknameHeight: CGFloat = 14
        let nicknameSpacing: CGFloat = 4
        return hiddenNickname ? 0 : nicknameHeight + nicknameSpacing
    }
    
    private func calculationReplyMessageHeight(hasReply: Bool) -> CGFloat {
        return hasReply ? 57 : 0
    }
    
    private func calculationTextHeight(maxWidth: CGFloat, content: NSAttributedString) -> CGFloat {
//        let framesetter = CTFramesetterCreateWithAttributedString(content as CFAttributedString)
//
//        let rect = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,
//                                                                CFRange(location: 0, length: 0),
//                                                                nil,
//                                                                size,
//                                                                nil)
        
        let size: CGSize = .init(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let calculationHeight = content.boundingRect(with: size,
                                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                     context: nil).height
        return ceil(calculationHeight)
    }
}
