//
//  GameViewController.swift
//  Numbers
//
//  Created by Sergii Miroshnichenko on 03.10.2022.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet var gameStatusLabel: UILabel!
    @IBOutlet var nextDigit: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    lazy var game = GameModel(count: buttons.count)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        game.check(index: buttonIndex)
        updateUI()
    }
    
    func setupScreen() {
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].isHidden = false
        }
        
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI() {
        for index in game.items.indices {
            buttons[index].isHidden = game.items[index].isFound
        }
        nextDigit.text = game.nextItem?.title
        
        if game.statusGame == .win {
            gameStatusLabel.text = "You WIN!"
            gameStatusLabel.textColor = .green
        }
    }
}
