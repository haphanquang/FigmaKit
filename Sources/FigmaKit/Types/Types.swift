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

public protocol ShadowType {
    var color: UIColor? { get }
    var x: CGFloat { get }
    var y: CGFloat { get }
    var b: CGFloat { get }
    var s: CGFloat { get }
    var alpha: Float { get }
}
public protocol CornerType {
    var corners: [(UIRectCorner, CGFloat)] { get }
}
public protocol StrokeType {
    var color: UIColor? { get }
    var adjustedWidth: CGFloat { get }
}

public protocol FillType {
    var startPoint: CGPoint? { get }
    var endPoint: CGPoint? { get }
    var colors: [(ColorType?, CGFloat?)] { get }
    var type: CAGradientLayerType { get }
    var alpha: CGFloat { get }
}
public protocol TypographyType {
    var font: UIFont { get }
    var lineHeight: CGFloat { get }
    var letterSpacing: CGFloat { get }
}
public enum Shadow: ShadowType {
    case drop(ColorType?, x: CGFloat, y: CGFloat, b: CGFloat, s: CGFloat, alpha: Float)
}

public enum CornerRadius: CornerType {
    case all(CGFloat)
    case mixed(_ topLeft: CGFloat = .zero, _ topRight: CGFloat = .zero, _ bottomRight: CGFloat = .zero, _ bottomLeft: CGFloat = .zero)
}
public enum Stroke: StrokeType {
    case inside(ColorType?, size: CGFloat)
    case outside(ColorType?, size: CGFloat)
    case center(ColorType?, size: CGFloat)
}

public enum Fill: FillType {
    case solid(ColorType?, _ alpha: CGFloat = 100)
    case linear(colors: [(ColorType?, CGFloat?)], start: CGPoint? = nil, end: CGPoint? = nil, alpha: CGFloat = 100)
}
public enum Typography: TypographyType {
    case custom(String, weight: Int, style: FontStyle = .normal, size: CGFloat, lineHeight: CGFloat = 0, letter: CGFloat = 0.0)
    case font(UIFont, lineHeight: CGFloat = 0, letter: CGFloat = 0.0)
}
