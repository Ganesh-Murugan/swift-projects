//
//  ViewController.swift
//  SettingsScreen
//
//  Created by zoho on 16/06/22.
//

import UIKit

class ViewController: UIViewController {

    var content = [Settings]()
    var header = String()
    private let settingView = UITableView()
    
    private func setupTableView() {
        settingView.frame = view.bounds
        settingView.clipsToBounds = true
        settingView.delegate = self
        settingView.dataSource = self
        settingView.register(SwitchCell.self, forCellReuseIdentifier: "switchCell")
        settingView.register(IconCell.self, forCellReuseIdentifier: "iconCell")
        settingView.register(SliderCell.self, forCellReuseIdentifier: "sliderCell")
        settingView.register(DescriptiveCell.self, forCellReuseIdentifier: "descriptiveCell")
    }
    
    @objc func doSomething() {
        print("pause activities")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(doSomething), name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.removeObserver(notificationCenter)
        print("viewDidLoad")
        setupTableView()
        view.addSubview(settingView)
        
        self.title = header
        
    }
    
//    override func viewDidLayoutSubviews() {
//        print("viewDidLayoutSubviews")
//    }
//    override func viewWillLayoutSubviews() {
//        print("viewWillLayoutSubviews")
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        print("viewWillAppear")
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        print("viewDidAppear")
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        print("viewWillDisappear")
//    }
//    override func viewDidDisappear(_ animated: Bool) {
//        print("viewDidDisappear")
//    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        content.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = settings[indexPath.row].settingType
        switch type {
        case .toggle(_):
            return 100
        case .navigate:
            return 80
        case .slider:
            return 180
        case .about:
            return 80
        }
    }
    
    private func addCell(tableView: UITableView, indexPath: IndexPath, id: String) -> Cell {
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! Cell
        cell.addCell(content[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = content[indexPath.row].settingType
        
        switch type {
        case .navigate:
            return addCell(tableView: tableView, indexPath: indexPath, id: "iconCell") as! IconCell
        case .toggle(let toggled):
            let cell = addCell(tableView: tableView, indexPath: indexPath, id: "switchCell") as! SwitchCell
            cell.toggle.setOn(toggled, animated: true)
            return cell
        case .slider(let value):
            let cell = addCell(tableView: tableView, indexPath: indexPath, id: "sliderCell") as! SliderCell
            cell.slider.setValue(value, animated: true)
            return cell
        case .about:
            return addCell(tableView: tableView, indexPath: indexPath, id: "descriptiveCell") as! DescriptiveCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var type = content[indexPath.row].settingType
        switch type {
        case .toggle(_):
            if let cell = settingView.cellForRow(at: indexPath) as? SwitchCell {
                type = .toggle(!cell.toggle.isOn)
                cell.toggled(!cell.toggle.isOn)
            }
            print(type)
        case .slider(_):
            if let cell = settingView.cellForRow(at: indexPath) as? SliderCell {
                type = .slider(cell.slider.value)
            }
            print(type)
        case .about:
            print(indexPath)
            
        case .navigate(let navigateTo):
            navigation(navigateTo)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func navigation(_ navigateTo: Navigate) {
        let viewController = ViewController()
        switch navigateTo {
        case .displaySettings:
            viewController.content = displaySettings
            viewController.header = "Display Settings"
        case .about:
            viewController.content = about
            viewController.header = "About"
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}



//var footerView: UIView = {
//    let view = UIView()
//    view.frame = CGRect(x: 250, y: 400, width: 100, height: 100)
//    view.backgroundColor = .blue
//    return view
//}()
//private func checkBounds() {
//    let testView = UIView(frame: CGRect(x: self.footerView.frame.origin.x,
//                                        y: self.footerView.frame.origin.y,
//                                        width: self.footerView.frame.size.width,
//                                        height: self.footerView.frame.size.height))
//    testView.layer.borderColor = UIColor.green.cgColor
//    testView.layer.borderWidth = 2
//    settingView.addSubview(testView)
//    settingView.addSubview(footerView)
//    print(testView.bounds)
//    print(footerView.bounds)
//    footerView.layer.borderColor = UIColor.red.cgColor
//    footerView.layer.borderWidth = 2
//    footerView.transform = CGAffineTransform(rotationAngle: 10)
//    print(testView.bounds)
//    print(footerView.bounds)
//}
