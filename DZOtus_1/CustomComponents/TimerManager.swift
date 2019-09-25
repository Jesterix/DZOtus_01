//
//  TimerManager.swift
//  DZOtus_1
//
//  Created by Georgy Khaydenko on 17/09/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import Foundation

protocol TimerManagerDelegate {
    func timerChanged()
}

class TimerManager {
    
    var timer: Timer?
    var currentTime: TimeInterval = 0
    var timerIsOn = false
    var delegate: TimerManagerDelegate?
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onFire), userInfo: nil, repeats: true)
        timer?.tolerance = 0.2
        timerIsOn = true
    }
    
    @objc func onFire(){
        currentTime += 1
        delegate?.timerChanged()
    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
        timerIsOn = false
    }
    
}
