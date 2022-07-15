////
////  LoaderViewController.swift
////  News
////
////  Created by zoho on 14/07/22.
////
//
//import UIKit
//
//class LoaderViewController: UIViewController {
//    var alert: UIAlertController?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    func startLoading() -> UIAlertController  {
//        alert = UIAlertController(title: nil, message: "loading...", preferredStyle: .alert)
//        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 20, y: 10, width: 50, height: 40))
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.style = .large
//        activityIndicator.color = .black
//        activityIndicator.startAnimating()
//        guard let alert = alert else {
//            return UIAlertController()
//        }
//        alert.view.addSubview(activityIndicator)
////        self.alert = alert
////        alert.show(Self, sender: self)
//        return alert
//        
//    }
//
//    func stopLoader(_ alert: UIAlertController){
//            alert.dismiss(animated: true)
//    }
//}
