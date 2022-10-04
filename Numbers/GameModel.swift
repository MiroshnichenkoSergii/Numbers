//
//  GameModel.swift
//  Numbers
//
//  Created by Sergii Miroshnichenko on 03.10.2022.
//

import Foundation

class GameModel {
    private let data = Array(1...99)
    private var items = [Item]()
    private var countItems: Int
    
    init(count: Int) {
        self.countItems = count
    }
    
    func setupGame() {
        var digits = data.shuffled()
        
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
    }
}

struct Item {
    var title: String
    var isFound: Bool = false
}
