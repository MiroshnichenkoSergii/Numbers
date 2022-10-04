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
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var newGameButton: UIButton!
    
    lazy var game = GameModel(count: buttons.count, time: 10) { [weak self] (status, time) in
        self?.timerLabel.text = time.secondsToString()
        self?.updateInfoGame(with: status)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        game.check(index: buttonIndex)
        updateUI()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    func setupScreen() {
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
        
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI() {
        for index in game.items.indices {
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                } completion: { [weak self] _ in
                    self?.buttons[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }

            }
        }
        nextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status: StatusGame) {
        switch status {
            case .start:
                gameStatusLabel.text = "Game is started"
                gameStatusLabel.textColor = .black
                newGameButton.isHidden = true
            case .win:
                gameStatusLabel.text = "You WIN!"
                gameStatusLabel.textColor = .green
                newGameButton.isHidden = false
            case .lose:
                gameStatusLabel.text = "Game Over"
                gameStatusLabel.textColor = .red
                newGameButton.isHidden = false
        }
    }
}
