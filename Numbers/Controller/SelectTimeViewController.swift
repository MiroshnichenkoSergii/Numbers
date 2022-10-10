//
//  SelectTimeViewController.swift
//  Numbers
//
//  Created by Sergii Miroshnichenko on 04.10.2022.
//

import UIKit

class SelectTimeViewController: UIViewController {
    
    var data = [Int]()
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension SelectTimeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        cell.textLabel?.text = String(data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        Settings.shared.currentSettins.timeForGame = data[indexPath.row]
        navigationController?.popViewController(animated: true)
    }
}
