//
//  SmoothCanvasView.swift
//  SmoothCanvas
//
//  Created by Benedek Varga on 2019. 03. 19..
//  Copyright © 2019. Benedek Varga. All rights reserved.
//

import UIKit

public struct PathSegment {
    var points: [CGPoint] = []
    let color: CGColor
    let width: CGFloat

    init(color: UIColor, width: CGFloat, points: [CGPoint]) {
        self.color = color.cgColor
        self.width = width
    }
}

open class SmoothCanvasView: UIView {
    public var lineWidth: CGFloat = 1.4
    public var lineColor: UIColor  = .black
    private(set) var writingPath = [PathSegment]()
    /// The value sets if user can write with fingers.
    public var isWritingByTouchEnabled = false
    /// This value sets and returns if the drawn line is an eraser.
    public var isEraser = false

    private var path: UIBezierPath?
    private var pathLayer: CAShapeLayer!
    private var drawWidth: CGFloat {
        return isEraser ? 5 : lineWidth
    }
    private var drawColor: CGColor {
        return isEraser ? lineColor.withAlphaComponent(0.6).cgColor : lineColor.cgColor
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if !isWritingByTouchEnabled {
            guard touch.type == .pencil || touch.type == .stylus else { return }
        }
        pathLayer = CAShapeLayer()
        pathLayer.lineJoin = CAShapeLayerLineJoin.round
        pathLayer.lineCap = CAShapeLayerLineCap.round
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = drawColor
        pathLayer.lineWidth = drawWidth
        self.layer.addSublayer(pathLayer)
        let pathSegment = PathSegment(color: lineColor, width: lineWidth, points: [touch.location(in: self)])
        writingPath.append(pathSegment)
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if !isWritingByTouchEnabled {
            guard touch.type == .pencil || touch.type == .stylus else { return }
        }

        guard var lastSection = writingPath.last else { return }
        lastSection.points.append(touch.location(in: self))
        writingPath.removeLast()
        writingPath.append(lastSection)
        pathLayer.path = lastSection.points.interpolateHermiteFor().cgPath
    }

    public func load(path: [PathSegment]) {
        clearCanvas()
        writingPath = path
        for p in writingPath {
            let layer = CAShapeLayer()
            layer.lineJoin = CAShapeLayerLineJoin.round
            layer.lineCap = CAShapeLayerLineCap.round
            layer.fillColor = UIColor.clear.cgColor
            layer.strokeColor = p.color
            layer.lineWidth = p.width
            self.layer.addSublayer(layer)
            layer.path = p.points.interpolateHermiteFor().cgPath
        }
    }

    public func clearCanvas() {
        writingPath = [PathSegment]()
        self.layer.sublayers?.removeAll()
    }
}


private extension Array where Iterator.Element == CGPoint {
    func interpolateHermiteFor(closed: Bool = false) -> UIBezierPath {
        guard self.count > 1 else { return UIBezierPath() }

        if self.count == 2 {
            let bezierPath = UIBezierPath()
            bezierPath.move(to: self[0])
            bezierPath.addLine(to: self[1])
            return bezierPath
        }

        let nCurves = closed ? self.count : self.count - 1

        let path = UIBezierPath()
        for i in 0..<nCurves {
            var curPt = self[i]
            var prevPt: CGPoint, nextPt: CGPoint, endPt: CGPoint
            if i == 0 {
                path.move(to: curPt)
            }

            var nexti = (i+1)%self.count
            var previ = (i-1 < 0 ? self.count-1 : i-1)

            prevPt = self[previ]
            nextPt = self[nexti]
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

            curPt = self[nexti]

            nexti = (nexti + 1) % self.count
            previ = i;

            prevPt = self[previ]
            nextPt = self[nexti]

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
