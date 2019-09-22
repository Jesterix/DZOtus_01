//
//  ComponentView.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 29/08/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class ComponentView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        if let nib = Bundle.main.loadNibNamed("ComponentView", owner: nil, options: nil),
            let view = nib[0] as? UIView {
            
            addSubview(view)
            
        }
    }
}
