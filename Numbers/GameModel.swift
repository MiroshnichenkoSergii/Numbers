//
//  GameModel.swift
//  Numbers
//
//  Created by Sergii Miroshnichenko on 03.10.2022.
//

import Foundation
import UIKit

enum StatusGame {
    case start
    case win
    case lose
}

struct Item {
    var title: String
    var isFound: Bool = false
    var isError: Bool = false
}

class GameModel {
    var items = [Item]()
    var nextItem: Item?
    var status: StatusGame = .start {
        didSet {
            if status != .start {
                stopGame()
            }
        }
    }
    private let data = Array(1...99)
    private var countItems: Int
    private var timeForGame: Int
    private var secondsGame: Int {
        didSet {
            if secondsGame == 0 {
                status = .lose
            }
            updateTimer(status, secondsGame)
        }
    }
    private var timer: Timer?
    private var updateTimer: ((StatusGame, Int) -> Void)
    
    init(count: Int, time: Int, updateTimer: @escaping (_ status: StatusGame, _ seconds: Int) -> Void) {
        self.countItems = count
        self.secondsGame = time
        self.updateTimer = updateTimer
        self.timeForGame = time
        setupGame()
    }
    
    func setupGame() {
        var digits = data.shuffled()
        
        items.removeAll()
        
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
        
        updateTimer(status, secondsGame)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in self?.secondsGame -= 1 })
    }
    
    func check(index: Int) {
        guard status == .start else { return }
        
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: { (item) -> Bool in
                item.isFound == false
            })
        } else {
            items[index].isError = true
        }
        
        if nextItem == nil {
            status = .win
        }
    }
    
    func newGame() {
        status = .start
        self.secondsGame = self.timeForGame
        setupGame()
    }
    
    private func stopGame() {
        timer?.invalidate()
    }
}

extension Int {
    func secondsToString() -> String {
        let min = self / 60
        let sec = self % 60
        return String(format: "%d:%02d", min, sec)
    }
}
