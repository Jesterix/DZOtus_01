//
//  FeedVC.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 12/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataProvider = TableDataProvider(nibName: nil, bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider.showDelegate = self
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }
}


extension FeedVC: ShowVCProtocol {
    func showVC(data: String) {
        let vc = SessionSummaryViewController(nibName: nil, bundle: nil)
        vc.labelText = data
        show(vc, sender: self)
    }    
}
