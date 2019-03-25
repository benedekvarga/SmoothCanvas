//
//  SmoothCanvasView.swift
//  SmoothCanvas
//
//  Created by Benedek Varga on 2019. 03. 16..
//  Copyright © 2019. Benedek Varga. All rights reserved.
//

import UIKit

open class SmoothCanvasImageView: UIImageView {
    // MARK: Public properties
    public let defaultLineWidth: CGFloat = 1.3

    // MARK: Private properties
    private var drawColor: UIColor = .black
    private var maximumLineWidth: CGFloat {
        return defaultLineWidth + 0.7
    }
    private var eraserColor: UIColor {
        return backgroundColor ?? .white
    }
    private var drawingImage: UIImage?

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        drawingImage?.draw(in: bounds)

        var touches = [UITouch]()
        if let coalescedTouches = event?.coalescedTouches(for: touch) {
            touches = coalescedTouches
        } else {
            touches.append(touch)
        }

        for touch in touches {
            drawStroke(context: context, touch: touch)
        }
        drawingImage = UIGraphicsGetImageFromCurrentImageContext()
        if let predictedTouches = event?.predictedTouches(for: touch) {
            for touch in predictedTouches {
                drawStroke(context: context, touch: touch)
            }
        }
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        image = drawingImage
    }

    override open func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        image = drawingImage
    }

    private func drawStroke(context: CGContext?, touch: UITouch) {
        let previousLocation = touch.previousLocation(in: self)
        let location = touch.location(in: self)

        var lineWidth: CGFloat
        switch touch.type {
        case .pencil:
            lineWidth = lineWidthForDrawing(touch: touch)
            drawColor.setStroke()
        default:
            lineWidth = 40
            eraserColor.setStroke()
        }

        context?.setLineWidth(lineWidth)
        context?.setLineCap(.butt)
        context?.move(to: CGPoint(x: previousLocation.x, y: previousLocation.y))
        context?.addLine(to: CGPoint(x: location.x, y: location.y))
        context?.strokePath()
    }

    private func lineWidthForDrawing(touch: UITouch) -> CGFloat {
        var lineWidth = defaultLineWidth
        if touch.force > 0 {
            lineWidth = touch.force > maximumLineWidth ? maximumLineWidth : (touch.force < defaultLineWidth ? defaultLineWidth : touch.force)
        }
        return lineWidth
    }

    func clearCanvas(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }, completion: { finished in
                self.alpha = 1
                self.image = nil
                self.drawingImage = nil
            })
        } else {
            image = nil
            drawingImage = nil
        }
    }
}
