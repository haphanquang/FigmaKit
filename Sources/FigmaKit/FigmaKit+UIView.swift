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

public extension UIView {
    private func getTargetView() -> FigmaView {
        if let figmaView = self.subviews
            .first(where: { $0 is FigmaView } ) {
            return figmaView as! FigmaView
        }
        
        let figmaView = FigmaView(frame: self.bounds)
        figmaView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(figmaView, at: 0)
        
        NSLayoutConstraint.activate([
            figmaView.topAnchor.constraint(equalTo: self.topAnchor),
            figmaView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            figmaView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            figmaView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        return figmaView
    }
    
    @discardableResult
    func shadow(_ shadow: Shadow) -> Self {
        getTargetView().setShadow(shadow)
        return self
    }
    
    @discardableResult
    func corner(_ corner: CornerRadius) -> Self {
        getTargetView().setCorner(corner)
        return self
    }
    
    @discardableResult
    func stroke(_ stroke: Stroke) -> Self {
        getTargetView().setStroke(stroke)
        return self
    }
    
    func stroke(_ color: ColorType, size: CGFloat = 1) -> Self {
        getTargetView().setStroke(.inside(color, size: size))
        return self
    }
    
    @discardableResult
    func fill(_ type: Fill) -> Self {
        getTargetView().setFill(type)
        return self
    }
}


private class FigmaView: UIView {
    
    private let shadowLayer = CAShapeLayer()
    private let backgroundLayer = CAGradientLayer()
    private let backgroundMaskLayer = CAShapeLayer()
    private let strokeLayer = CAShapeLayer()
    
    private var stroke: Stroke?
    private var corners: CornerRadius?
    private var shadow: Shadow?

    override init(frame: CGRect) {
        super.init(frame: frame)
        shadowLayer.fillColor = UIColor.clear.cgColor
        backgroundMaskLayer.fillColor = UIColor.white.cgColor
        strokeLayer.fillColor = UIColor.clear.cgColor
        
        layer.insertSublayer(shadowLayer, at: 0)
        layer.insertSublayer(backgroundLayer, above: shadowLayer)
        layer.insertSublayer(strokeLayer, above: backgroundLayer)
        
        backgroundLayer.mask = backgroundMaskLayer
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePaths()
        backgroundLayer.frame = self.bounds
    }
    
    func setShadow(_ shadow: Shadow) {
        self.shadowLayer.fillColor = UIColor.white.cgColor
        self.shadowLayer
            .setShadow(color: shadow.color, alpha: shadow.alpha, x: shadow.x, y: shadow.y, blur: shadow.b, spread: shadow.s)
    }
    
    func setFill(_ fill: Fill) {
        let layer = self.backgroundLayer
        switch fill {
        case let .solid(color, _):
            layer.backgroundColor = color?.color?.cgColor
            self.alpha = alpha
        default:
            layer.colors = fill.colors.compactMap { $0.0?.color?.cgColor }
            layer.locations = fill.colors.map { NSNumber(value: Float($0.1 ?? 0)) }
            if let start = fill.startPoint {
                layer.startPoint = start
            }
            if let end = fill.endPoint {
                layer.endPoint = end
            }
            layer.type = fill.type
        }
        self.alpha = fill.alpha / 100
        updatePaths()
    }
    
    func setStroke(_ stroke: Stroke) {
        self.stroke = stroke
        strokeLayer.strokeColor = stroke.color?.cgColor
        strokeLayer.lineWidth = stroke.lineWidth
        updatePaths()
    }

    func setCorner(_ corner: CornerRadius) {
        self.corners = corner
        updatePaths()
    }
}

extension FigmaView {
    private func createPath() -> UIBezierPath {
        return createPathInFrame(getAdjustedFrame())
    }
    
    private func createShadowPath() -> UIBezierPath {
        return createPathInFrame(getShadowFrame())
    }
    
    private func createStrokePath() -> UIBezierPath {
        return createPathInFrame(getAdjustedFrame())
    }
    
    private func getAdjustedFrame() -> CGRect {
        var rect = self.bounds
        if let stroke = self.stroke, rect != .zero {
            rect = rect.insetBy(dx: stroke.adjustedWidth, dy: stroke.adjustedWidth)
        }
        return rect
    }
    
    private func updatePaths() {
        shadowLayer.path = self.createShadowPath().cgPath
        backgroundMaskLayer.path = self.createPath().cgPath
        strokeLayer.path = self.createStrokePath().cgPath
    }
    
    private func getShadowFrame() -> CGRect {
        var rect = self.bounds
        if let stroke = self.stroke {
            rect = rect.insetBy(dx: stroke.adjustedWidth - stroke.lineWidth / 2, dy: stroke.adjustedWidth - stroke.lineWidth / 2)
        }
        return rect
    }
    
    private func createPathInFrame(_ rect: CGRect) -> UIBezierPath {
        var topLeftRadius = CGSize.zero
        var topRightRadius = CGSize.zero
        var bottomLeftRadius = CGSize.zero
        var bottomRightRadius = CGSize.zero
        
        if let corners = self.corners {
            for corner in corners.corners {
                if corner.0 == .topLeft {
                    topLeftRadius = CGSize(width: corner.1, height: corner.1)
                }
                if corner.0 == .topRight {
                    topRightRadius = CGSize(width: corner.1, height: corner.1)
                }
                if corner.0 == .bottomLeft {
                    bottomLeftRadius = CGSize(width: corner.1, height: corner.1)
                }
                if corner.0 == .bottomRight {
                    bottomRightRadius = CGSize(width: corner.1, height: corner.1)
                }
            }
        }
    
        return UIBezierPath(shouldRoundRect: rect, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
    }
}

extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){

        self.init()
        let path = CGMutablePath()

        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x + topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x - topRightRadius.width, y: topRight.y))
            path.addCurve(
                to: CGPoint(x: topRight.x, y: topRight.y + topRightRadius.height),
                control1: CGPoint(x: topRight.x, y: topRight.y),
                control2: CGPoint(x: topRight.x, y: topRight.y + topRightRadius.height))
        } else {
             path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }

        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - bottomRightRadius.height))
            path.addCurve(
                to: CGPoint(x: bottomRight.x - bottomRightRadius.width, y: bottomRight.y),
                control1: CGPoint(x: bottomRight.x, y: bottomRight.y),
                control2: CGPoint(x: bottomRight.x - bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }

        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x + bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(
                to: CGPoint(x: bottomLeft.x, y: bottomLeft.y - bottomLeftRadius.height),
                control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y),
                control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }

        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + topLeftRadius.height))
            path.addCurve(
                to: CGPoint(x: topLeft.x + topLeftRadius.width, y: topLeft.y),
                control1: CGPoint(x: topLeft.x, y: topLeft.y),
                control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        path.closeSubpath()
        cgPath = path
    }
}
