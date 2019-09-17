//
//  BenchmarkVC.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 07/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class BenchmarkVC: UIViewController {

    var dataProvider = BenchmarkDataSource(nibName: nil, bundle: nil)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // committed behaviors cause they are not needed in next homework
//        addBehaviors(behaviors: [DateTimerBehavior()])
        
        collectionView.delegate = dataProvider
        collectionView.dataSource = dataProvider
        dataProvider.benchmarkCollectionView = collectionView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for timer in dataProvider.timerManagers {
            timer.stopTimer()
            timer.currentTime = 0
        }
        dataProvider.benchmarkCollectionView?.reloadData()

    }

}
