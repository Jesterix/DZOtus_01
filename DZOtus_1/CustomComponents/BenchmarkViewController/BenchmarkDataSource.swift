//
//  BenchmarkDataSource.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 16/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class BenchmarkTimer {
    var isOn = false
    var currentTime: TimeInterval = 0
}

class BenchmarkDataSource {
    
    var benchmarkCollectionView: UICollectionView?
    //hardcoded numbers for demonstration only
    let numberOfCells = 15
    let pieChartColors: [UIColor] = [UIColor.green, UIColor.red]    
    
    var timers: [BenchmarkTimer] = []
    var pieChartSegmentsForTimers: [[Segment]] = []
    var timerManager = TimerManager()
    let formatter = DateComponentsFormatter()
    
    
    func setup(){
        //setting up data source
        for _ in 0...numberOfCells - 1 {
            let timer = BenchmarkTimer()
            timers.append(timer)
            pieChartSegmentsForTimers.append(calculatePieChartData(timer: timer))
        }
        
        //starting timer
        timerManager.delegate = self
        timerManager.startTimer()
        
        //setting up time formatter
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [.pad]
        formatter.allowedUnits = [.hour,.minute,.second]
    }
    
    func calculatePieChartData(timer: BenchmarkTimer) -> [Segment]{
        var timerIsOnSegmentWeight: CGFloat = 1
        var timerIsOffSegmentWeight: CGFloat = 100
        
        if timerManager.currentTime != 0 {
            timerIsOnSegmentWeight = CGFloat(timer.currentTime / timerManager.currentTime * 100)
            timerIsOffSegmentWeight = CGFloat((timerManager.currentTime - timer.currentTime) / timerManager.currentTime * 100)
        }
        
        let timerIsOnSegment = Segment(color: pieChartColors[0], text: String(Int(timerIsOnSegmentWeight)), weight: timerIsOnSegmentWeight)
        let timerIsOffSegment = Segment(color: pieChartColors[1], text: String(Int(timerIsOffSegmentWeight)), weight: timerIsOffSegmentWeight)
        return [timerIsOnSegment, timerIsOffSegment]
    }
    
    func refreshPieCharts() {
        pieChartSegmentsForTimers = []
        for timer in timers {
            pieChartSegmentsForTimers.append(calculatePieChartData(timer: timer))
        }
    }
}


extension BenchmarkDataSource: TimerManagerDelegate {
    func timerChanged() {
        //figure out where to update timer label
        var indexPathsToReload: [IndexPath] = []
        for i in 0...timers.count - 1 {
            if timers[i].isOn {
                timers[i].currentTime += 1
                indexPathsToReload.append(IndexPath(row: i, section: 0))
            }
        }
        //figure out where animation is running to prevent animation from being stopped due to updating of cell
        var indexPathsWithoutAnimationRunning: [IndexPath] = []
        for indexPath in indexPathsToReload {
            if let cell = benchmarkCollectionView?.cellForItem(at: indexPath) as? StackAndTimerCollectionViewCell {
                var animationIsOn = false
                for segment in cell.pieChart.layers {
                    if segment.isAnimating {
                       animationIsOn = true
                    }
                }
                if !animationIsOn {
                    indexPathsWithoutAnimationRunning.append(indexPath)
                }
            }
        }
        //reload needed cells
        if indexPathsWithoutAnimationRunning.count != 0 {
            benchmarkCollectionView?.reloadItems(at: indexPathsWithoutAnimationRunning)
        }
    }
    
}
