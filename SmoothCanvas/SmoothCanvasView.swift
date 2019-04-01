//
//  SmoothCanvasView.swift
//  SmoothCanvas
//
//  Created by Benedek Varga on 2019. 03. 19..
//  Copyright © 2019. Benedek Varga. All rights reserved.
//

import UIKit

class SmoothCanvasView: UIView {

    var points: [CGPoint]?
    var path: UIBezierPath?
    var pathLayer: CAShapeLayer!

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pathLayer = CAShapeLayer()
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.black.cgColor
        pathLayer.lineWidth = 3
        pathLayer.lineJoin = CAShapeLayerLineJoin.round
        pathLayer.lineCap = CAShapeLayerLineCap.round
        self.layer.addSublayer(pathLayer)

        if let touch = touches.first {
            points = [touch.location(in: self)]
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if let coalescedTouches = event?.coalescedTouches(for: touch) {
            points? += coalescedTouches.map { $0.location(in: self) }
        } else {
            points?.append(touch.location(in: self))
        }
        guard let points = points else { return }
        pathLayer.path = UIBezierPath.interpolateHermiteFor(points: points, closed: false).cgPath
        if let predictedTouches = event?.predictedTouches(for: touch) {
            let predictedPoints = predictedTouches.map { $0.location(in: self) }
            pathLayer.path = UIBezierPath.interpolateHermiteFor(points: points + predictedPoints, closed: false).cgPath
        } else {
            pathLayer.path = UIBezierPath.interpolateHermiteFor(points: points, closed: false).cgPath
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let pathPoints = points else { return }
        pathLayer.path = UIBezierPath.interpolateHermiteFor(points: pathPoints, closed: false).cgPath
        points?.removeAll()
    }
}


extension UIBezierPath {
    static func interpolateHermiteFor(points: [CGPoint], closed: Bool = false) -> UIBezierPath {
        guard points.count > 1 else { return UIBezierPath() }

        if points.count == 2 {
            let bezierPath = UIBezierPath()
            bezierPath.move(to: points[0])
            bezierPath.addLine(to: points[1])
            return bezierPath
        }

        let nCurves = closed ? points.count : points.count - 1

        let path = UIBezierPath()
        for i in 0..<nCurves {
            var curPt = points[i]
            var prevPt: CGPoint, nextPt: CGPoint, endPt: CGPoint
            if i == 0 {
                path.move(to: curPt)
            }

            var nexti = (i+1)%points.count
            var previ = (i-1 < 0 ? points.count-1 : i-1)

            prevPt = points[previ]
            nextPt = points[nexti]
            endPt = nextPt

            var mx: CGFloat
            var my: CGFloat
            if closed || i > 0 {
                mx  = (nextPt.x - curPt.x) * CGFloat(0.5)
                mx += (curPt.x - prevPt.x) * CGFloat(0.5)
                my  = (nextPt.y - curPt.y) * CGFloat(0.5)
                my += (curPt.y - prevPt.y) * CGFloat(0.5)
            }
            else {
                mx = (nextPt.x - curPt.x) * CGFloat(0.5)
                my = (nextPt.y - curPt.y) * CGFloat(0.5)
            }

            var ctrlPt1 = CGPoint.zero
            ctrlPt1.x = curPt.x + mx / CGFloat(3.0)
            ctrlPt1.y = curPt.y + my / CGFloat(3.0)

            curPt = points[nexti]

            nexti = (nexti + 1) % points.count
            previ = i;

            prevPt = points[previ]
            nextPt = points[nexti]

            if closed || i < nCurves-1 {
                mx  = (nextPt.x - curPt.x) * CGFloat(0.5)
                mx += (curPt.x - prevPt.x) * CGFloat(0.5)
                my  = (nextPt.y - curPt.y) * CGFloat(0.5)
                my += (curPt.y - prevPt.y) * CGFloat(0.5)
            }
            else {
                mx = (curPt.x - prevPt.x) * CGFloat(0.5)
                my = (curPt.y - prevPt.y) * CGFloat(0.5)
            }

            var ctrlPt2 = CGPoint.zero
            ctrlPt2.x = curPt.x - mx / CGFloat(3.0)
            ctrlPt2.y = curPt.y - my / CGFloat(3.0)

            path.addCurve(to: endPt, controlPoint1:ctrlPt1, controlPoint2:ctrlPt2)
        }

        if closed {
            path.close()
        }

        return path
    }
}
