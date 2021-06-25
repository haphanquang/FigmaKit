/**
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
 */

import Foundation
import UIKit

public enum Typography: TypographyType {
    case custom(String, weight: Int, style: FontStyle = .normal, size: CGFloat, lineHeight: CGFloat = 0, letter: CGFloat = 0.0)
    case system(weight: Int, style: FontStyle = .normal, size: CGFloat, lineHeight: CGFloat = 0, letter: CGFloat = 0.0 )
    case font(UIFont, lineHeight: CGFloat = 0, letter: CGFloat = 0.0)
}

extension Typography {
    public enum FontStyle: String {
        case normal = ""
        case italic = "Italic"
    }
    
    public var font: UIFont {
        switch self {
        case let .custom(name, weight, style, size, _, _):
            let fontName = name + "-" + weight.proxFontWeight.name + style.rawValue
            let font = UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size)
            if style == .italic, let des = font.fontDescriptor.withSymbolicTraits(.traitItalic) {
                return UIFont(descriptor: des, size: 0)
            }
            return font
        
        case let .system(weight, style, size, _, _):
            let font = UIFont.systemFont(ofSize: size, weight: weight.fontWeight)
            if style == .italic, let des = font.fontDescriptor.withSymbolicTraits(.traitItalic) {
                return UIFont(descriptor: des, size: 0)
            }
            return font
        
        case let .font(font, _, _):
            return font
            
        }
    }
    
    public var lineHeight: CGFloat {
        switch self {
        case let .custom(_, _, _, _, lineHeight, _):
            return lineHeight
        case let .font(_, lineHeight, _):
            return lineHeight
        case let .system(_, _, _, lineHeight, _):
            return lineHeight
        }
    }
    
    public var letterSpacing: CGFloat {
        switch self {
        case let .custom(_, _, _, _, _, letter):
            return letter
        case let .font(_, _, letter):
            return letter
        case let .system(_, _, _, _, letter):
            return letter
        }
    }
}
