//
//  TextMessageView.swift
//  MessageCell
//
//  Created by Ray on 2021/7/4.
//

import UIKit

final class TextMessageView: UIView {

    @IBOutlet var contentLabel: UILabel!
    
    private var clickableRects: [CGRect] = []
    private var clickablHandlers: [() -> Void] = []
    private var urlTapHandler: ((URL) -> Void)?
    private var phoneResults: [NSTextCheckingResult] = []
    private var linkResults: [NSTextCheckingResult] = []
    
    private lazy var tapLinkGesture: UITapGestureRecognizer = {
        return .init(target: self, action: #selector(labelDidTapped(_:)))
    }()
    
    func setupLinkTapAction(with phoneResults: [NSTextCheckingResult], linkResults: [NSTextCheckingResult], urlTapHandler: ((URL) -> Void)?) {
        self.phoneResults = phoneResults
        self.linkResults = linkResults
        contentLabel.removeGestureRecognizer(tapLinkGesture)
        guard phoneResults.isEmpty == false || linkResults.isEmpty == false else { return }
        contentLabel.addGestureRecognizer(tapLinkGesture)
    }
}
extension TextMessageView {
    private func measureCoreText(with rect: CGRect, attrStr: NSAttributedString, point: CGPoint) {
        guard phoneResults.isEmpty == false || linkResults.isEmpty == false else { return }
        clickableRects = []
        clickablHandlers = []

        // new Frame
        let path = CGPath(rect: rect, transform: nil)

        let frameSetter = CTFramesetterCreateWithAttributedString(attrStr as CFAttributedString)
        let range = CFRange(location: 0, length: 0)
        let frame = CTFramesetterCreateFrame(frameSetter, range, path, nil)

        let lines: NSArray = CTFrameGetLines(frame) // 不宣告則預設CFArray 哭出來的難用
        let count = lines.count
        var origins: [CGPoint] = Array.init(repeating: .zero, count: count)
        CTFrameGetLineOrigins(frame, CFRange(location: 0, length: 0), &origins)

        for i in 0 ..< count {
            let line = lines[i] as! CTLine
            let origin = origins[i]

            let runs: NSArray = CTLineGetGlyphRuns(line)

            runs.forEach { ctRun in
                let run = ctRun as! CTRun

                var runAscent = CGFloat()
                var runDescent = CGFloat()

                let width = CGFloat(CTRunGetTypographicBounds(run, CFRange(location: 0, length: 0), &runAscent, &runDescent, nil))
                let leftSpacing = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, nil)
                let runRect = CGRect(x: origin.x + leftSpacing, y: self.frame.height - (origin.y - runDescent) - runAscent, width: width, height: runAscent + 5)

                let range = CTRunGetStringRange(run)
                // URL
                for link in linkResults {
                    if checkIfRunInResult(runRange: range, resultRange: link.range) {
                        clickableRects.append(runRect)
                        clickablHandlers.append {
                            guard let url = link.url else { return }
                            self.urlTapHandler?(url)
                        }
                        print("clickable url \(link.url?.absoluteString ?? "nil")")
                    }
                }
                // Phone
                for phone in phoneResults {
                    if checkIfRunInResult(runRange: range, resultRange: phone.range) {
                        clickableRects.append(runRect)
                        clickablHandlers.append {
                            guard let phone = phone.phoneNumber, let url = URL(string: "tel://\(phone)") else { return }
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                        print("clickable phoneNumber \(phone.phoneNumber ?? "nil")")
                    }
                }
                // TODO: handle Tag User
            }
        }
    }

    @objc
    private func labelDidTapped(_ sender: UITapGestureRecognizer) {
        let touchPoint: CGPoint = sender.location(in: contentLabel)
        guard let contentAttributed = contentLabel.attributedText else { return }
        measureCoreText(with: contentLabel.frame, attrStr: contentAttributed, point: touchPoint)
        guard let index = getTouchIndex(for: touchPoint) else { return }
        handleClickEvent(withIndex: index)
    }

    private func checkIfRunInResult(runRange: CFRange, resultRange: NSRange) -> Bool {

        if resultRange.location <= runRange.location &&
            runRange.location < resultRange.location + resultRange.length {
            return true
        }
        return false
    }

    private func checkIfTouchInRect(point: CGPoint, rect: CGRect) -> Bool {
        guard rect.minX ... rect.maxX ~= point.x else { return false }
        guard rect.minY ... rect.maxY ~= point.y else { return false }
        return true
    }

    private func getTouchIndex(for point: CGPoint) -> Int? {
        for i in 0 ..< clickableRects.count {
            guard let rect: CGRect = clickableRects[safe: i] else { continue }
            guard checkIfTouchInRect(point: point, rect: rect) else { continue }
            return i
        }
        return nil
    }

    private func handleClickEvent(withIndex index: Int) {
        guard let handler = clickablHandlers[safe: index] else {
            print("handler index not found")
            return
        }
        handler()
    }
}
