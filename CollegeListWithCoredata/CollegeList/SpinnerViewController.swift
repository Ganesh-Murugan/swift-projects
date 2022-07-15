//
//  SpinnerViewController.swift
//  CollegeList
//
//  Created by zoho on 09/07/22.
//

import UIKit

class SpinnerViewController: UIView {
    
    var spinner = UIActivityIndicatorView()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUpSpinner()
//    }
//
//    private func setUpSpinner(){
//        spinner.center = view.center
//        view.addSubview(spinner)
//    }
    
    func showLoading(with style: UIActivityIndicatorView.Style, color: UIColor) {
        spinner.style = style
        spinner.tag = 1
        spinner.color = color
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
    }
    func stopLoading() {
        spinner.stopAnimating()
    }
}
