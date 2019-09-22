//
//  BenchmarkDataSource.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 16/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class BenchmarkDataSource: UIViewController {
    
    var benchmarkCollectionView: UICollectionView?
    //hardcoded number of cells for demonstration only
    let numberOfCells = 15
    
    var timerManagers: [TimerManager] = []
    let formatter = DateComponentsFormatter()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension BenchmarkDataSource: UICollectionViewDataSource {
    
    //some builder for stackview
    func fillStackViewWithSomeViews() -> [UIView] {
        var stackViewContent: [UIView] = []
        let numberOfViews = 3
        let colors = [UIColor.green, UIColor.blue, UIColor.orange]
        let label = UILabel()
        label.text = "StackView"
        stackViewContent.append(label)
        for i in 1...numberOfViews {
            let viewInStack = UIView()
            viewInStack.backgroundColor = colors[i-1]
            stackViewContent.append(viewInStack)
        }
        return stackViewContent
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timerManagers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StackPlusTimerCell", for: indexPath) as? StackAndTimerCollectionViewCell else { return UICollectionViewCell() }
        
        cell.timerLabel.text = formatter.string(from: timerManagers[indexPath.row].currentTime)
        
        let stackView = UIStackView(arrangedSubviews: fillStackViewWithSomeViews())
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(stackView)
        stackView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: cell.timerLabel.bottomAnchor).isActive = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if timerManagers[indexPath.row].timerIsOn {
            timerManagers[indexPath.row].stopTimer()
        } else {
            timerManagers[indexPath.row].startTimer()
        }
    }
    
    
}

extension BenchmarkDataSource: UICollectionViewDelegate {
    
}

extension BenchmarkDataSource: TimerManagerDelegate {
    func timerChanged() {
        benchmarkCollectionView?.reloadData()
    }
}
