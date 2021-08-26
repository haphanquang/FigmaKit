// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.
//
// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
// For more information, please refer to <http://unlicense.org/>

import Foundation
import UIKit

// MARK: - UIElements

private struct StyleHolder {
    static var font: UIFont?
    static var color: UIColor?
    static var attributes: [NSAttributedString.Key: Any]?
}
public extension UILabel {
    enum TextStyle {
        case normal
        case underlined
        case strikeThrough
        case link(String)
    }
    @discardableResult
    func typography(_ typo: Typography) -> Self {
        self.font = typo.font
        self.numberOfLines = 0
        self.lineSpacing(max((typo.lineHeight - typo.font.pointSize), 0))
        self.letterSpacing(typo.letterSpacing)
        return self
    }
    @discardableResult
    func content(_ string: String) -> Self {
        self.text = string
        return self
    }
    @discardableResult
    func color(_ color: ColorType) -> Self {
        self.textColor = color.color
        return self
    }
    
    @discardableResult
    func add(_ string: NSAttributedString) -> Self {
        let recent = self.attributedText ?? NSAttributedString()
        let new = NSMutableAttributedString(attributedString: recent)
        new.append(string)
        self.attributedText = new
        self.invalidateIntrinsicContentSize()
        return self
    }
    
    @discardableResult
    func add(_ string: String, style: TextStyle = .normal, typography: Typography? = nil, color: ColorType? = nil, background: ColorType? = nil) -> Self {
        let font = typography?.font ?? StyleHolder.font ?? .systemFont(ofSize: 12)
        let color = color ?? StyleHolder.color ?? .black
        let background = background ?? UIColor.clear
        switch style {
            case .normal:
                return self.add(string.normal(font, color: color, background: background))
            case .underlined:
                return self.add(string.underlined(font, color: color, background: background))
            case .strikeThrough:
                return self.add(string.strikeThrough(font, color: color, background: background))
            case let .link(url):
                return self.add(string.link(url: url, font: font, color: color, background: background))
        }
    }
    
    @discardableResult
    func setDefault(_ typography: Typography, color: ColorType) -> Self {
        StyleHolder.font = typography.font
        StyleHolder.color = color.color
        
        let style = NSMutableParagraphStyle()
        let lineSpacing = max((typography.lineHeight - typography.font.pointSize), 0)
        if lineSpacing > 0 {
            style.lineSpacing = lineSpacing
            style.lineHeightMultiple = 1.0
        }
        StyleHolder.attributes = [.paragraphStyle: style]
        
        self.typography(typography)
        return self
    }

    @discardableResult
    func cleanUp() -> Self {
        StyleHolder.font = nil
        StyleHolder.color = nil
        StyleHolder.attributes = nil
        return self
    }
    
    @discardableResult
    func lineSpacing(_ value: CGFloat) -> Self {
        guard let attributedString = currentAttributedString() else { return self }
        let style = (StyleHolder.attributes?[.paragraphStyle] as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()
        let newAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style as Any
        ]
        let range = NSMakeRange(0, attributedString.length)
        attributedString.addAttributes(newAttributes, range: range)
        self.attributedText = attributedString
        return self
    }
    
    @discardableResult
    func letterSpacing(_ value: CGFloat) -> Self {
        guard let attributedString = currentAttributedString() else { return self }
        let newAttributes: [NSAttributedString.Key: Any] = [
            .kern: value
        ]
        let range = NSMakeRange(0, attributedString.length)
        attributedString.addAttributes(newAttributes, range: range)
        self.attributedText = attributedString
        return self
    }
    
    @discardableResult
    func alignment(_ align: NSTextAlignment) -> Self {
        guard let attributedString = currentAttributedString() else { return self }
        
        let style = (StyleHolder.attributes?[.paragraphStyle] as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()
        style.alignment = align
        let newAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style as Any
        ]
        let range = NSMakeRange(0, attributedString.length)
        attributedString.addAttributes(newAttributes, range: range)
        self.attributedText = attributedString
        return self
    }
    
    private func currentAttributedString() -> NSMutableAttributedString? {
        let attributedString: NSMutableAttributedString
        if let text = self.attributedText, text.length > 0 {
            attributedString = NSMutableAttributedString(attributedString: text)
        } else {
            guard let text = self.text else { return nil }
            attributedString = NSMutableAttributedString(string: text)
        }
        return attributedString
    }
}

public extension UIButton {
    @discardableResult
    func padding(_ edge: UIEdgeInsets) -> Self {
        self.contentEdgeInsets = edge
        return self
    }
    
    @discardableResult
    func tint(_ color: ColorType) -> Self {
        self.tintColor = color.color
        return self
    }
    @discardableResult
    func typography(_ typo: Typography) -> Self {
        self.titleLabel?.typography(typo)
        return self
    }
}


public extension UIStackView {
    
}
