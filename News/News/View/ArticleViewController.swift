//
//  Article2ViewController.swift
//  News
//
//  Created by zoho on 14/07/22.
//

import UIKit

class ArticleViewController: UIViewController {

    var article: Article?
    @IBOutlet weak var articleTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func setupView() {
        title = "Article"
        articleTableView.delegate = self
        articleTableView.dataSource = self
    }

}

extension ArticleViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.headerTableViewCellIdentifier) as! HeaderTableViewCell
            cell.configure(article)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.imageTableViewCellIdentifier) as! ImageTableViewCell
            cell.configure((article?.urlToImage).unwrap)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.contentTableViewCellIdentifier) as! ContentTableViewCell
            cell.configure(article)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    
}
