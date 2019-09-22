//
//  FeedVC.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 12/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataProvider = TableDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider.getData()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension FeedViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = SessionSummaryViewController(nibName: nil, bundle: nil)
            vc.labelText = dataProvider.data[indexPath.row]
            show(vc, sender: self)
        }
}

extension FeedViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.dataProvider.data.count
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Feed Cell")
            cell.textLabel?.text = dataProvider.data[indexPath.row]
            return cell
        }
    
}
