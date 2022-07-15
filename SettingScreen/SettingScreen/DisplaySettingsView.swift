////
////  AppSettingsViewController.swift
////  SettingScreen
////
////  Created by zoho on 17/06/22.
////
//
//import UIKit
//
//class DisplaySettingsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var appSettingView = UITableView()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        appSettingView.delegate = self
//        appSettingView.dataSource = self
//        appSettingView.register(SliderCell.self, forCellReuseIdentifier: "slidercell")
//    }
//
//}
//
//extension DisplaySettingsView {
//     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        displaySettings.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //super.getTableContent(appSettings, indexPath)
//        UITableViewCell()
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("hi")
//    }
//    
//}
