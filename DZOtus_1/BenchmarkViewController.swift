//
//  BenchmarkVC.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 07/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class BenchmarkViewController: UIViewController {
    
    private let chessLayout = ChessLayout()
    private var isChess = true
    private var defaultLayout : UICollectionViewLayout?
    
    var dataProvider = BenchmarkDataSource(nibName: nil, bundle: nil)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // committed behaviors cause they are not needed in next homework
//        addBehaviors(behaviors: [DateTimerBehavior()])
        
        collectionView.delegate = dataProvider
        collectionView.dataSource = dataProvider
        dataProvider.benchmarkCollectionView = collectionView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeLayout))
        
        defaultLayout = collectionView.collectionViewLayout
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for timer in dataProvider.timerManagers {
            timer.stopTimer()
            timer.currentTime = 0
        }
        dataProvider.benchmarkCollectionView?.reloadData()

    }

    
    @objc func changeLayout() {
        isChess.toggle()
        if isChess {
            chessLayout.delegate = self
            collectionView.setCollectionViewLayout(chessLayout, animated: true)
        } else {
            guard let layout = defaultLayout else { return }
            collectionView.setCollectionViewLayout(layout, animated: true)
        }
        
    }
    
}

extension BenchmarkViewController : CustomCollectionViewDelegate {
    func numberOfItemsInCollectionView() -> Int {
        return dataProvider.timerManagers.count
    }
}
