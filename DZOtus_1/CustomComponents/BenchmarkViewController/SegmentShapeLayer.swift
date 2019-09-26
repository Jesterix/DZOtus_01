//
//  SegmentShapeLayer.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 26/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class SegmentShapeLayer: CAShapeLayer {

    var isAnimating = false
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init()
        setup()
    }
    
    func setup(){
        self.bounds = bounds
        self.fillColor = .none
        self.lineCap = .butt
        self.anchorPoint = .zero
    }
    
}

extension SegmentShapeLayer: CAAnimationDelegate {

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.isAnimating = false
        removeAnimation(forKey: "animate")
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        self.isAnimating = true
    }
}
