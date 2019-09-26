//
//  StackAndTimerCollectionViewCell.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 16/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class StackAndTimerCollectionViewCell: UICollectionViewCell {
    
    var timerLabel: UILabel?
    var pieChart = PieChartView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
        
    func setup(){
        timerLabel = UILabel()
        guard let label = timerLabel else { return }
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        pieChartSetup()
        
        let stackView = self.createStackView()
        self.addSubview(stackView)
        stackView.bottomAnchor.constraint(equalTo: pieChart.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        
        layoutIfNeeded()
    }
    
    func pieChartSetup(){
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pieChart)
        pieChart.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pieChart.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        pieChart.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pieChart.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    // MARK: - a builder for stackview
    func fillStackViewWithSomeViews() -> [UIView] {
        var stackViewContent: [UIView] = []
        let colors = [UIColor.green, UIColor.red]
        let numberOfViews = colors.count
        let label = UILabel()
        label.text = "Timer"
        stackViewContent.append(label)
        let anotherLabel = UILabel()
        anotherLabel.text = "on/off"
        stackViewContent.append(anotherLabel)
        for i in 1...numberOfViews {
            let viewInStack = UIView()
            viewInStack.backgroundColor = colors[i-1]
            stackViewContent.append(viewInStack)
        }
        return stackViewContent
    }
    
    func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: self.fillStackViewWithSomeViews())
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}

