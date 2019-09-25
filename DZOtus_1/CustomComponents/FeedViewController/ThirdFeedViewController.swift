//
//  ThirdFeedVC.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 07/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class ThirdFeedViewController: UIViewController {

    var shouldPopToRoot = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if shouldPopToRoot {
            if let controllers = navigationController?.viewControllers {
                let newControllers = controllers.filter { !($0 is SecondFeedViewController) }
                navigationController?.setViewControllers(newControllers, animated: true)
            }
        }
    }
    
    

}
