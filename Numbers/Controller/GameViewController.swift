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
    
    lazy var game = GameModel(count: buttons.count) { [weak self] (status, time) in
        self?.timerLabel.text = time.secondsToString()
        self?.updateInfoGame(with: status)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        game.stopGame()
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
                if game.isNewRecord {
                    showAlert()
                } else {
                    showAlertActionSheet()
                }
            case .lose:
                gameStatusLabel.text = "Game Over"
                gameStatusLabel.textColor = .red
                newGameButton.isHidden = false
                showAlertActionSheet()
        }
    }
    
    private func showAlert() {
        let ac = UIAlertController(title: "Congratulations!", message: "You set the new record!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(ac, animated: true)
    }
    
    private func showAlertActionSheet() {
        let ac = UIAlertController(title: "What you want next?", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Start new game", style: .default){ [weak self] _ in
            self?.game.newGame()
            self?.setupScreen()
        })
        ac.addAction(UIAlertAction(title: "Show record", style: .default) { [weak self] _ in
            self?.performSegue(withIdentifier: "recordVC", sender: nil)
        })
        ac.addAction(UIAlertAction(title: "Go to menu", style: .destructive) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let popover = ac.popoverPresentationController {
            
            // - arrow direction to status label
            popover.sourceView = gameStatusLabel
            popover.permittedArrowDirections = UIPopoverArrowDirection.up
            
            // - to show alert in the midle of screen
//            popover.sourceView = self.view
//            popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
//            popover.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        }
        
        present(ac, animated: true)
    }
}
