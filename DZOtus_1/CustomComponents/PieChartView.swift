//
//  PieChartView.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 23/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

struct Segment {
    let color: UIColor
    let text: String
    let weight: CGFloat
}

class PieChartView: UIView {

    var layers: [CAShapeLayer] = []
    var keyFrameAnimations: [CAKeyframeAnimation] = []
    
    private lazy var textAttributes: [NSAttributedString.Key: Any] = [
        .font               : UIFont.systemFont(ofSize: 14),
        .foregroundColor    : UIColor.black
    ]
    

    func createPie(withSize: CGRect, segments: [Segment]){
        
        let radius = min(withSize.width, withSize.height) * 0.5
        var startAngle = -CGFloat.pi * 0.5
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let fullCircleWeight = segments.reduce(0){$0 + $1.weight}
        
        for segment in segments {
            self.createSegment(cirleCenter: centerPoint, radius: radius, startAngle: &startAngle, fillColor: segment.color, text: segment.text, angle: (segment.weight / fullCircleWeight) * 2 * .pi)
        }

    }
    
    
    func setupDesignOfShapeLayer(withColor: UIColor) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = bounds
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = withColor.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineCap = .round
        shapeLayer.anchorPoint = .zero
        return shapeLayer
    }
    
    
    func createSegment(cirleCenter: CGPoint, radius: CGFloat, startAngle: inout CGFloat, fillColor: UIColor, text: String, angle: CGFloat){
        
        //init layer
        let segmentShapeLayer = setupDesignOfShapeLayer(withColor: fillColor)
        layer.addSublayer(segmentShapeLayer)
        self.layers.append(segmentShapeLayer)
        
        
        //make keyframe values for animation
        var paths: [CGPath] = []
        let animationDuration: CFTimeInterval = 1
        let framesPerSecond = 60
        let numberOfFrames = Int(animationDuration * Double(framesPerSecond))
        for frame in 1...numberOfFrames {
            let path = UIBezierPath()
            let animationEndAngle = angle / CGFloat(numberOfFrames) * CGFloat(frame)
            path.addArc(withCenter: cirleCenter, radius: radius, startAngle: startAngle, endAngle: startAngle + animationEndAngle, clockwise: true)
            path.addLine(to: cirleCenter)
            path.close()
            paths.append(path.cgPath)
        }
        
        //adding text
        let textLayer = CATextLayer()
        let textPositionOffset: CGFloat = 0.6
        let segmentCenter = cirleCenter.projected(by: radius * textPositionOffset, angle: startAngle + (angle * 0.5))
        let textRect = CGRect(centeredOn: segmentCenter, size: text.size(withAttributes: textAttributes))
        textLayer.frame = textRect
        textLayer.string = NSAttributedString(string: text, attributes: textAttributes)
        layer.addSublayer(textLayer)
    
        //add keyFrame animation
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "path")
        keyFrameAnimation.values = paths
        keyFrameAnimation.duration = animationDuration
        keyFrameAnimation.repeatCount = 1
        keyFrameAnimations.append(keyFrameAnimation)
    
        //last frame
        segmentShapeLayer.path = paths.last
        
        startAngle += angle
    }
    
    
    func startAnimation() {
        for i in 0...layers.count - 1 {
            layers[i].add(keyFrameAnimations[i], forKey: "keyFrameAnimation")
        }
    }
    
    func stopAnimation() {
//        shapeLayer.removeAnimation(forKey: "drawingAnimation")
//        layer.removeAnimation(forKey: "rotationAnimation")
        layer.removeAllAnimations()
    }
}



extension CGPoint {
    init(center: CGPoint, radius: CGFloat, degrees: CGFloat) {
        self.init(
            x: cos(degrees) * radius + center.x,
            y: sin(degrees) * radius + center.y
        )
    }
    
    func projected(by value: CGFloat, angle: CGFloat) -> CGPoint {
        return CGPoint(
            x: x + value * cos(angle), y: y + value * sin(angle)
        )
    }
}

extension CGRect {
    init(centeredOn center: CGPoint, size: CGSize) {
        self.init(
            origin: CGPoint(
                x: center.x - size.width * 0.5, y: center.y - size.height * 0.5
            ),
            size: size
        )
    }
    var center: CGPoint {
        return CGPoint(
            x: width / 2 + origin.x,
            y: height / 2 + origin.y
        )
    }
}
