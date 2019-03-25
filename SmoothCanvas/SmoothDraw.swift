//
//  SmoothDraw.swift
//  SmoothCanvas
//
//  Created by Benedek Varga on 2019. 03. 19..
//  Copyright © 2019. Benedek Varga. All rights reserved.
//
import UIKit

class drawImageView: UIImageView {

    var previousPoint1 = CGPoint()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        previousPoint1 = touch.previousLocation(in: self)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        let previousPoint2 = previousPoint1
        previousPoint1 = touch.previousLocation(in: self)
        let currentPoint = touch.location(in: self)


        // calculate mid point
        let mid1 = midPoint(firstPoint: previousPoint1, secondPoint: previousPoint2)
        let mid2 = midPoint(firstPoint: currentPoint, secondPoint: previousPoint1)

        UIGraphicsBeginImageContext(self.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        if let image = self.image {
            image.draw(in: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        }

        context.move(to: mid1)
        context.addQuadCurve(to: mid2, control: previousPoint1)

        context.setLineCap(.round)
        context.setLineWidth(2.0)
        context.setStrokeColor(red: 1.0, green: 0, blue: 0, alpha: 1.0)
        context.strokePath()

        self.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    func midPoint(firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
        return CGPoint(x: (firstPoint.x + secondPoint.x) / 2.0, y: (firstPoint.y + secondPoint.y) / 2.0)
    }
}
