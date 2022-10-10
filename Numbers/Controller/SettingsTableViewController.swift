//
//  SettingsTableViewController.swift
//  Numbers
//
//  Created by Sergii Miroshnichenko on 04.10.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet var timeForGameLabel: UILabel!
    @IBOutlet var switchTimer: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changeTimerState(_ sender: UISwitch) {
        Settings.shared.currentSettins.timerState = sender.isOn
    }
    
    @IBAction func resetSettings(_ sender: UIButton) {
        Settings.shared.resetSettings()
        loadSettings()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "selectTimeVC":
                if let vc = segue.destination as? SelectTimeViewController {
                    vc.data = (10...120).filter { $0 % 10 == 0 }
                }
            default:
                break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadSettings()
        switchTimer.isOn = Settings.shared.currentSettins.timerState
    }
    
    func loadSettings() {
        timeForGameLabel.text = "\(Settings.shared.currentSettins.timeForGame) sec"
        switchTimer.isOn = Settings.shared.currentSettins.timerState
    }

}
