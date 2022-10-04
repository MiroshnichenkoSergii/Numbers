//
//  GameViewController.swift
//  Numbers
//
//  Created by Sergii Miroshnichenko on 03.10.2022.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet var gameStatusLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        sender.isHidden = true
        print("The number of button is: \(String(describing: sender.titleLabel!.text!)) \ntag - \(sender.tag)")
    }
}
