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
    private var defaultLayout: UICollectionViewLayout?
    
    var dataProvider = BenchmarkDataSource()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // committed behaviors cause they are not needed in next homework
//        addBehaviors(behaviors: [DateTimerBehavior()])
        
        dataProvider.setup()
        dataProvider.benchmarkCollectionView = collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeLayout))
        
        defaultLayout = collectionView.collectionViewLayout
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for timer in dataProvider.timerManagers {
            timer.stopTimer()
            timer.currentTime = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
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

extension BenchmarkViewController: CustomCollectionViewDelegate {
    func numberOfItemsInCollectionView() -> Int {
        return dataProvider.timerManagers.count
    }
}

extension BenchmarkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.timerManagers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StackPlusTimerCell", for: indexPath) as? StackAndTimerCollectionViewCell else { return UICollectionViewCell() }
        if let timerLabel = cell.timerLabel {
            timerLabel.text = dataProvider.formatter.string(from: dataProvider.timerManagers[indexPath.row].currentTime)
        }
        return cell
    }
    
}


extension BenchmarkViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if dataProvider.timerManagers[indexPath.row].timerIsOn {
            dataProvider.timerManagers[indexPath.row].stopTimer()
        } else {
            dataProvider.timerManagers[indexPath.row].startTimer()
        }
    }

}
