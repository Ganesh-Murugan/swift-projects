//
//  ViewController.swift
//  News
//
//  Created by zoho on 13/07/22.
//

import UIKit

class NewsTableViewController: UIViewController {
    let apiHandler = ApiHandler()
    var articles = [Article]()
//    let loader = LoaderViewController()
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        newstableViewSetup()
        getArticles()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Identifiers.newsToArticleSegueIdentifier{
            let viewController = segue.destination as! ArticleViewController
            guard let indexPath = sender as? Int else {
                return
            }
            viewController.article = articles[indexPath]
        }
    }
    private func newstableViewSetup() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    private func getArticles(){
            let alert = self.startLoading("loading..")
            self.present(alert, animated: true)

        apiHandler.fetchArticles() { [weak self] articles in
            
            self?.articles = articles
            DispatchQueue.main.async {
                self?.newsTableView.reloadData()
                self?.stopLoader(alert)
            }
        }
    }
}

extension NewsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.newsTableViewCellIdentifier, for: indexPath) as! NewsTableViewCell
        cell.setupCell(self.articles[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: Constants.StoryBoards.main, bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Identifiers.articleTableViewController)
//        navigationController?.pushViewController(vc, animated: true)
        performSegue(withIdentifier: Constants.Identifiers.newsToArticleSegueIdentifier, sender: indexPath.row)
    }
    
}
