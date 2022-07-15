//
//  ViewController.swift
//  CustomCellExample
//
//  Created by zoho on 16/06/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.tableFooterView = UIView()
        settingsTableView.register(UINib(nibName: "IconCell", bundle: nil), forCellReuseIdentifier: "labelWithIconCell")
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = settings[indexPath.row].settingType
        switch type {
        case .navigate:
            let cell = settingsTableView.dequeueReusableCell(withIdentifier: "labelWithIconCell", for: indexPath) as! IconCell
            cell.addCell(settings[indexPath.row])
            return cell
        case .toggle(let toggled):
            let cell = settingsTableView.dequeueReusableCell(withIdentifier: "plainCell", for: indexPath) as! SwitchCell
            cell.toggle.setOn(toggled, animated: true)
            cell.addCell(settings[indexPath.row])
            return cell
        }
    }
}
