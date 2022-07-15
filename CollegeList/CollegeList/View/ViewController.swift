//
//  ViewController.swift
//  CollegeList
//
//  Created by zoho on 02/07/22.
//

import UIKit
//nw_protocol_get_quic_image_block_invoke dlopen libquic failed

class ViewController: UIViewController {
    
    let countryTableView = UITableView()
    var apiHandler = APIHandler()
    var countriesList = [Countries]()
    var isSearching: Bool {
        !searchController.searchBar.text.unwrap.isEmpty
    }
    
    var searchList = [Countries]()
//    var spinner = SpinnerViewController()
    let searchController = UISearchController()
    
    private func setUpSearchController() {
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    private func setupTableView() {
        countryTableView.frame = view.bounds
        title = "Countries"
        view.addSubview(countryTableView)
        countryTableView.separatorStyle = .none
        view.backgroundColor = .white
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.countryCellIdentifier)
    }
    
    private func fetchApi(){
        view.startLoadingIndicator(with: .large, color: .blue)
        apiHandler.fetchCountryData() { [weak self] countries in
            self?.countriesList = countries
            DispatchQueue.main.async {
                self?.countryTableView.reloadData()
                self?.view.stopLoadingIndicator()
                self?.countryTableView.separatorStyle = .singleLine
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUpSearchController()
        fetchApi()
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //        if countriesList.isEmpty { self.view.startLoadingIndicator(with: .large, color: .blue) }
    //    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? searchList.count : countriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.countryCellIdentifier, for: indexPath) as! CountryTableViewCell
        
        let list = isSearching ? searchList : countriesList
        cell.addCellView(list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry =  (isSearching ? searchList[indexPath.row] : countriesList[indexPath.row]).country
        let vc = CollegeViewController()
        vc.selectedCountry = selectedCountry?.customTrim()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        if isSearching {
            searchList = countriesList.filter({$0.country.unwrap.contains(searchText)})
        }
        countryTableView.reloadData()
    }
}
