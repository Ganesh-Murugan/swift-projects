//
//  ViewController.swift
//  CollegeList
//
//  Created by zoho on 02/07/22.
//

import UIKit
//nw_protocol_get_quic_image_block_invoke dlopen libquic failed

class ViewController: UIViewController {
    var storage = CoreDataManager()
    
    let countryTableView = UITableView()
    var apiHandler = APIHandler()
    var countriesList = [String](){
        didSet {
            print("Didset")
//            self.countriesList = self.countriesList.uniqueAndSort
//            DispatchQueue.main.async {
//                self.countryTableView.reloadInputViews() }
            }
    }
    
    var isSearching: Bool {
        !searchController.searchBar.text.unwrap.isEmpty
    }
    
    var searchList = [String]()
    var spinner = SpinnerViewController()
    let searchController = UISearchController()
    var refreshControl = UIRefreshControl()
    
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
        countryTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    @objc private func loadData() {
        storage.checkDataChanges(countriesList) { results in
//            self?.countriesList.append(contentsOf: results.uniqueAndSort)
            print("result in vc", results.count)
            DispatchQueue.main.async {
//                self?.countryTableView.reloadData()
                for (index, row) in results.uniqueAndSort.enumerated() {
                    self.countriesList.insert(row, at: index)
                    self.countryTableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .right)
                }
                
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    //    private func fetchApi(){
    //        view.startLoadingIndicator(with: .large, color: .blue)
    //        apiHandler.fetchCountryData() { [weak self] countries in
    //            for country in countries {
    //                self?.countriesList.append(country.countryName.unwrap)
    //            }
    ////
    //            DispatchQueue.main.async {
    //                self?.countryTableView.reloadData()
    //                self?.view.stopLoadingIndicator()
    //                self?.countryTableView.separatorStyle = .singleLine
    //            }
    //        }
    //    }
    
    private func getCountries() {
        view.startLoadingIndicator(with: .large, color: .blue)
        storage.fetchCoreData() { [weak self] results in
            self?.countriesList = results
            print("result in vc", results.count)
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCountryAndCollege))
        getCountries()
    }
    
    @objc private func addCountryAndCollege(){
        storage.addNewCollege(CountriesAndCollegesModel(collegeName: "AB university", countryName: "B")) { [weak self] country in
            self?.countriesList.insert(country, at: 0)
            DispatchQueue.main.async {
                self?.countryTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? searchList.count : countriesList.count
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("removing ", indexPath.row)
        storage.remove(countriesList[indexPath.row])
        self.countriesList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .right)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.countryCellIdentifier, for: indexPath) as! CountryTableViewCell
        
        let list = isSearching ? searchList : countriesList
        cell.addCellView(list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedCountry =  (isSearching ? searchList[indexPath.row] : countriesList[indexPath.row])
        let vc = CollegeViewController()
        storage.fetchCountry(selectedCountry) { countriesAndColleges in
            var colleges = [String]()
            countriesAndColleges.forEach({colleges.append($0.collegeName.unwrap)})
            self.navigationController?.pushViewController(vc, animated: true)
            vc.colleges = colleges
            
        }
       
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        if isSearching {
            searchList = countriesList.filter({$0.localizedCaseInsensitiveContains(searchText)})
        }
        countryTableView.reloadData()
    }
}
