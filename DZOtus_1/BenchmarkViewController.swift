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
    private var isChess = false
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
        
        let reloadPieCharts = UIBarButtonItem(title: "PieCharts", style: .done, target: self, action: #selector(refreshPieCharts))
        let changeLayoutButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeLayout))
        navigationItem.rightBarButtonItems = [changeLayoutButton, reloadPieCharts]
        
        defaultLayout = collectionView.collectionViewLayout
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dataProvider.timerManager.stopTimer()
        for timer in dataProvider.timers {
            timer.currentTime = 0
            timer.isOn = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !dataProvider.timerManager.timerIsOn {
            dataProvider.timerManager.startTimer()
        }
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
    
    @objc func refreshPieCharts() {
        for i in 0...dataProvider.numberOfCells {
            if let cell = collectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? StackAndTimerCollectionViewCell {
                cell.pieChart.startAnimation()
            }
        }
        dataProvider.refreshPieCharts()
    }
}

extension BenchmarkViewController: CustomCollectionViewDelegate {
    func numberOfItemsInCollectionView() -> Int {
        return dataProvider.timers.count
    }
}

extension BenchmarkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.timers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StackPlusTimerCell", for: indexPath) as? StackAndTimerCollectionViewCell else { return UICollectionViewCell() }
        if let timerLabel = cell.timerLabel {
            timerLabel.text = dataProvider.formatter.string(from: dataProvider.timers[indexPath.row].currentTime)
        }
        
        //pie chart for displaying percent of timer's on time period
        let segments = dataProvider.pieChartSegmentsForTimers[indexPath.row]
        cell.pieChart.layer.sublayers?.removeAll()
        cell.pieChart.createPie(withSize: cell.pieChart.frame, segments: segments)
        cell.pieChart.layoutSubviews()
        return cell
    }
    
}


extension BenchmarkViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataProvider.timers[indexPath.row].isOn.toggle()
    }

}
