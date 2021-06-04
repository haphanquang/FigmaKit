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

import UIKit
extension Shadow {
    public var color: UIColor? {
        switch self {
        case let .drop(color, _, _, _, _, _):
            return color?.color ?? .clear
        }
    }
    public var x: CGFloat {
        switch self {
        case let .drop(_, x, _, _, _, _):
            return x
        }
    }
    public var y: CGFloat {
        switch self {
        case let .drop(_, _, y, _, _, _):
            return y
        }
    }
    public var b: CGFloat {
        switch self {
        case let .drop(_, _, _, b, _, _):
            return b
        }
    }
    public var s: CGFloat {
        switch self {
        case let .drop(_, _, _, _, s, _):
            return s
        }
    }
    public var alpha: Float {
        switch self {
        case let .drop(_, _, _, _, _, alpha):
            return alpha / 100
        }
    }
    
}

extension CornerRadius {
    public var corners: [(UIRectCorner, CGFloat)] {
        switch self {
        case let .all(val):
            return [(.topLeft, val), (.bottomLeft, val), (.topRight, val), (.bottomRight, val)]
        case let .mixed(tl, tr, br, bl):
            return [(.topLeft, tl), (.topRight, tr), (.bottomRight, br), (.bottomLeft, bl)]
        }
    }
}

extension Stroke {
    public var color: UIColor? {
        switch self {
        case let .center(color, _): return color?.color ?? .white
        case let .inside(color, _): return color?.color ?? .white
        case let .outside(color, _): return color?.color ?? .white
        }
    }
    
    public var adjustedWidth: CGFloat {
        switch self {
        case let .inside(_, size): return size / 2
        case .center: return 0
        case let .outside(_, size): return -size / 2
        }
    }
    
    public var lineWidth: CGFloat {
        switch self {
        case let .inside(_, size): return size
        case let .center(_, size): return size
        case let .outside(_, size): return size
        }
    }
}

extension Fill {
    public var startPoint: CGPoint? {
        switch self {
        case .solid:
            return nil
        case let .linear(_, start, _, _):
            return start
        }
    }
    public var endPoint: CGPoint? {
        switch self {
        case .solid:
            return nil
        case let .linear(_, _, end, _):
            return end
        }
    }
    public var colors: [(ColorType?, CGFloat?)] {
        switch self {
        case let .solid(color, _):
            return [(color, nil)]
            
        case let .linear(colors, _, _, _):
            return colors
        }
    }
    public var type: CAGradientLayerType {
        switch self {
        default: return .axial
        }
    }
    
    public var alpha: CGFloat {
        switch self {
        case let .solid(_, a):
            return a
            
        case let .linear(_, _, _, a):
            return a
        }
    }
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

extension Int {
    var fontWeight: UIFont.Weight {
        switch self {
        case 100: return .thin
        case 200: return .ultraLight
        case 300: return .light
        case 400: return .regular
        case 500: return .medium
        case 600: return .semibold
        case 700: return .bold
        case 800: return .heavy
        case 900: return .black
        default: return .regular
        }
    }
    
    var proxFontWeight: UIFont.Weight {
        return prox.fontWeight
    }
    
    private var prox: Int {
        return Int((CGFloat(self) / 100).rounded() * 100)
    }
}

extension UIFont.Weight {
    var name: String {
        switch self {
        case .thin: return "Thin"
        case .ultraLight: return "UltraLight"
        case .light: return "Light"
        case .regular: return "Regular"
        case .medium: return "Medium"
        case .semibold: return "Semibold"
        case .bold: return "Bold"
        case .heavy: return "Heavy"
        case .black: return "Black"
        default:
            return "Regular"
        }
    }
}
