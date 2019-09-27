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

    var segments: [Segment] = [] {
        didSet {
            createPie()
        }
    }
    
    var layers: [SegmentShapeLayer] = []
    var keyFrameAnimations: [CAKeyframeAnimation] = []
    
    private lazy var textAttributes: [NSAttributedString.Key: Any] = [
        .font               : UIFont.systemFont(ofSize: 14),
        .foregroundColor    : UIColor.black
    ]
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        createPie()
    }
    
    
    func createPie() {
        // new
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let radius = min(bounds.width, bounds.height) * 0.5
        var startAngle = -CGFloat.pi * 0.5
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let fullCircleWeight = segments.reduce(0){$0 + $1.weight}
        
        for segment in segments {
            self.createSegment(cirleCenter: centerPoint, radius: radius, startAngle: &startAngle, color: segment.color, text: segment.text, angle: (segment.weight / fullCircleWeight) * 2 * .pi)
        }

    }
    
    
    func setupDesignOfShapeLayer(withColor: UIColor, radius: CGFloat) -> SegmentShapeLayer {
        let shapeLayer = SegmentShapeLayer()
        shapeLayer.strokeColor = withColor.cgColor
        shapeLayer.lineWidth = radius
        return shapeLayer
    }

    
    func createSegment(cirleCenter: CGPoint, radius: CGFloat, startAngle: inout CGFloat, color: UIColor, text: String, angle: CGFloat){
        
        //init layer
        let segmentShapeLayer = setupDesignOfShapeLayer(withColor: color, radius: radius)
        layer.addSublayer(segmentShapeLayer)
        self.layers.append(segmentShapeLayer)
        
        //draw segment with line
        let path = UIBezierPath()
        let animationEndAngle = angle
        path.addArc(withCenter: cirleCenter, radius: radius / 2, startAngle: startAngle, endAngle: startAngle + animationEndAngle, clockwise: true)
        segmentShapeLayer.path = path.cgPath
        
        //adding text
        let textLayer = CATextLayer()
        let textPositionOffset: CGFloat = 0.6
        let segmentCenter = cirleCenter.projected(by: radius * textPositionOffset, angle: startAngle + (angle * 0.5))
        let textRect = CGRect(centeredOn: segmentCenter, size: text.size(withAttributes: textAttributes))
        textLayer.frame = textRect
        textLayer.string = NSAttributedString(string: text, attributes: textAttributes)
        layer.addSublayer(textLayer)
        
        startAngle += angle
    }
    
    
    func startAnimation() {
        
        let arcAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        arcAnimation.duration = 0.5
        arcAnimation.fromValue = 0
        arcAnimation.toValue = 1
        
        for i in 0...layers.count - 1 {
            layers[i].add(arcAnimation, forKey: "animate")
            arcAnimation.delegate = layers[i]
        }
    }
    
    func stopAnimation() {
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
