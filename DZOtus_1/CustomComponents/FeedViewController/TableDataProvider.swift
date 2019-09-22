//
//  TableDataProvider.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 12/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//


import UIKit

class TableDataProvider {
    
    var data: [String] = []

    func getData() {
        for i in 1...20 {
            data.append("Item \(i)")
        }
    }
    
}
