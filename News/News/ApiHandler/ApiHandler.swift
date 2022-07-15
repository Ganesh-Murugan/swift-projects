//
//  ApiHandler.swift
//  News
//
//  Created by zoho on 13/07/22.
//

import Foundation
import UIKit

class ApiHandler {
    func fetchArticles(completion: @escaping ([Article])->Void){
        let urlString = Constants.Urls.articleUrl
        URLSession.shared.request(for: urlString, expecting: ResponseData.self) { apiResponese in
            switch apiResponese {
            case .success(let responseData):
                guard let articles = responseData.articles else {
                    return
                }
                completion(articles)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
