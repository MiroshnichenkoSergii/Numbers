//
//  RecordViewController.swift
//  Numbers
//
//  Created by Sergii Miroshnichenko on 05.10.2022.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet var recordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
        
        if record != 0 {
            recordLabel.text = "The record is: \(record)"
        } else {
            recordLabel.text = "Record isn't set yet"
        }
        
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}
