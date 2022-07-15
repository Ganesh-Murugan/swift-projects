////
////  CollegeViewController.swift
////  CollegeList
////
////  Created by zoho on 06/07/22.
////
//
import UIKit

class CollegeViewController: UIViewController {
    
    var colleges: [Colleges] = []
    var apiHandler = APIHandler()
    var collegeTableView = UITableView()
    var selectedCountry: String?
//    var refreshControl = UIRefreshControl()
    
    private func setupView() {
        collegeTableView.frame = view.bounds
        view.addSubview(collegeTableView)
        collegeTableView.alwaysBounceVertical = true
//        collegeTableView.refreshControl = refreshControl
//        refreshControl.addTarget(self, action: #selector(refreshColleges(_:)), for: .valueChanged)

        title = "Colleges"
        view.backgroundColor = .white
        collegeTableView.separatorStyle = .none
        collegeTableView.delegate = self
        collegeTableView.dataSource = self
        collegeTableView.register(CollegeTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.collegeCellIdentifier)
    }
    
    func fetchApi(){
        view.startLoadingIndicator(with: .large, color: .red)
        apiHandler.fetchquery(selectedCountry) { [weak self] colleges in
            self?.colleges = colleges
            DispatchQueue.main.async {
                self?.collegeTableView.reloadData()
                self?.view.stopLoadingIndicator()
                self?.collegeTableView.separatorStyle = .singleLine
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchApi()
    }
//    @objc func refreshColleges(_ sender: Any){
//        apiHandler.fetchquery(selectedCountry) { [weak self] colleges in
//            self?.colleges = colleges
//            DispatchQueue.main.async {
//                self?.collegeTableView.reloadData()
////                self?.refreshControl.endRefreshing()
//
//            }
//        }
//
//    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if colleges.isEmpty {
//            view.startLoadingIndicator(with: .large, color: .red) }
//    }
}

extension CollegeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        colleges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.collegeCellIdentifier, for: indexPath) as! CollegeTableViewCell
        cell.addCellView(colleges[indexPath.row])
        return cell
    }
}
