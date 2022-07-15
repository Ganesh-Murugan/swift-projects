//
//  ViewController.swift
//  Practice
//
//  Created by zoho on 10/06/22.
//
import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    let searchController = UISearchController()
    
    var sectionTitle = sortedList.map({$0.firstLetter}).unique({$0 == $1})
    
    var searching: Bool{
        !(searchController.searchBar.text).unwrap.isEmpty
    }
    var contactDict: [String: [Contact]] = Dictionary(grouping: sortedList, by: {$0.firstLetter})
    var searchResult = sortedList
    
    @IBOutlet weak var contactTable: UITableView!
    
    @IBAction func didEditStart(){
        contactTable.isEditing.toggle()
    }

    func setSearchControllerProperties() {
        searchController.searchBar.placeholder = "Search.."
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        setSearchControllerProperties()
        contactTable.dataSource = self
        contactTable.delegate = self
    }
}

extension ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return searching ? 1 : sectionTitle.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searching ?  "Search Result" : sectionTitle[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searching ? searchResult.count :
            (contactDict[sectionTitle[section]]?.count).intUnwrap
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactTable.dequeueReusableCell(withIdentifier: "newIdentifier", for: indexPath) as! ContactCell
        let list = !searching ? contactDict[sectionTitle[indexPath.section]] : searchResult
        if let list = list {
            cell.add(list[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected one of the cell, \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        !searching
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        contactDict[sectionTitle[sourceIndexPath.section]]?.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        let rows = self.tableView(contactTable, numberOfRowsInSection: sourceIndexPath.section)
        if proposedDestinationIndexPath.section != sourceIndexPath.section{
            let rowInSourceSection = (sourceIndexPath.section > proposedDestinationIndexPath.section) ? 0 : rows - 1;
                  return IndexPath(row: rowInSourceSection, section: sourceIndexPath.section)
        }
        return proposedDestinationIndexPath
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removed = contactDict[sectionTitle[indexPath.section]]?.remove(at: indexPath.row)
            
            if contactDict[sectionTitle[indexPath.section]]?.isEmpty ?? true {
                contactDict.removeValue(forKey: (removed?.firstLetter).unwrap)
                sectionTitle.removeAll(where: {$0 == (removed?.firstLetter).unwrap})
                contactTable.deleteSections([indexPath.section], with: .fade)
            } else {
                contactTable.deleteRows(at: [indexPath], with: .fade)
            }
        } else {return}
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        var dictValues = [Contact]()
        for value in contactDict.values{
            value.forEach{dictValues.append($0)}
        }
        if !text.isEmpty {
            searchResult = dictValues.searchFilter(searchText: text)
        } else {
            searchResult.removeAll()
            searchResult = dictValues
        }
        contactTable.reloadData()
    }
}
