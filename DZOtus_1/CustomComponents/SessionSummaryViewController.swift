//
//  SessionSummaryViewController.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 12/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class SessionSummaryViewController: UIViewController {

    var labelText : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        view.backgroundColor = .white
        let label = UILabel(frame: self.view.frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.labelText
        view.addSubview(label)
        
        let verticalConstraint = label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let horizontalConstraint = label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        view.addConstraints([verticalConstraint,horizontalConstraint])
    }
    
}
