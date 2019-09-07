//
//  CustomButton.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 29/08/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {

    @IBInspectable var bgColor : UIColor? {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    @IBInspectable var cornerRad : CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRad
        }
    }
    

}
