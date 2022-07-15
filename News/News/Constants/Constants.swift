//
//  Constants.swift
//  News
//
//  Created by zoho on 13/07/22.
//

import Foundation

struct Constants{
    struct Identifiers {
        static let articleTableViewController = "articleViewController"
        static let newsTableViewCellIdentifier = "newsTableViewCellIdentifier"
        static let articleTableViewCellIdentifier = "articleTableViewCellIdentifier"
        static let newsToArticleSegueIdentifier = "newsToArticleSegueIdentifier"
        static let headerTableViewCellIdentifier = "headerTableViewCellIdentifier"
        static let imageTableViewCellIdentifier = "imageTableViewCellIdentifier"
        static let contentTableViewCellIdentifier = "contentTableViewCellIdentifier"
    }
    struct Urls {
        static let articleUrl = "https://newsapi.org/v2/everything/?q=tesla&apiKey=2dc3524462524b9492456a138fad193b"
    }
    struct StoryBoards {
        static let main = "Main"
    }
}
