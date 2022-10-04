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
}

class GameModel {
    var items = [Item]()
    var nextItem: Item?
    var statusGame: StatusGame = .start
    private let data = Array(1...99)
    private var countItems: Int
    
    init(count: Int) {
        self.countItems = count
        setupGame()
    }
    
    func setupGame() {
        var digits = data.shuffled()
        
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
    }
    
    func check(index: Int) {
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: { (item) -> Bool in
                item.isFound == false
            })
        }
        
        if nextItem == nil {
            statusGame = .win
        }
    }
}

struct Item {
    var title: String
    var isFound: Bool = false
}

