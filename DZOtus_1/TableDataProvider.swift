//
//  TableDataProvider.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 12/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

protocol ShowVCProtocol {
    func showVC(data: String)
}

import UIKit

class TableDataProvider : UIViewController {
    
    var data : [String] = []
    var showDelegate : ShowVCProtocol?

    func getData() {
        for i in 1...20 {
            data.append("Item \(i)")
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        getData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        getData()
    }
    
}

extension TableDataProvider : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Feed Cell")
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDelegate?.showVC(data: data[indexPath.row])
    }
}

extension TableDataProvider : UITableViewDelegate {
}

