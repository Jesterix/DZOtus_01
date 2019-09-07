//
//  BenchmarkVC.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 07/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class BenchmarkVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addBehaviors(behaviors: [DateTimerBehavior()])
    }
    


}
