//
//  ProfileVC.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 07/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var isBlackBackground: Bool {
        if self.view.backgroundColor == UIColor.black {
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addBehaviors(behaviors: [HideNavigationBarBehavior(),
                                 StatusBarDarkBehavior()])
    }
  
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isBlackBackground {
            return .lightContent
        }
        return .default
    }
    
}
