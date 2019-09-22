//
//  BenchmarkDataSource.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 16/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class BenchmarkDataSource {
    
    var benchmarkCollectionView: UICollectionView?
    //hardcoded number of cells for demonstration only
    let numberOfCells = 15
    
    var timerManagers: [TimerManager] = []
    let formatter = DateComponentsFormatter()
    
    
    func setup(){
        //setting up data source
        for i in 0...numberOfCells - 1 {
            let timer = TimerManager()
            timer.delegate = self
            timer.index = i
            timerManagers.append(timer)
        }
        
        //setting up time formatter
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [.pad]
        formatter.allowedUnits = [.hour,.minute,.second]
    }
    
}


extension BenchmarkDataSource: TimerManagerDelegate {
    func timerChanged(atIndex: Int) {
        benchmarkCollectionView?.reloadItems(at: [IndexPath(row: atIndex, section: 0)])
    }
    
}
