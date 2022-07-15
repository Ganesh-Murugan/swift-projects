//
//  Extension.swift
//  CollegeList
//
//  Created by zoho on 02/07/22.
//

import Foundation
import UIKit

enum Custom<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
}

enum CustomError: Error{
    case invalidUrl, invalidData
}

extension UIView {
    
    func startLoadingIndicator(with style: UIActivityIndicatorView.Style, color: UIColor) {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.center = center
        spinner.tag = 1
        spinner.color = color
        spinner.hidesWhenStopped = true
        isUserInteractionEnabled = false
        spinner.startAnimating()
        self.addSubview(spinner)
    }
    
    func stopLoadingIndicator() {
        if let spinner = viewWithTag(1) {
            spinner.removeFromSuperview()
        }
        isUserInteractionEnabled = true
    }
}

extension URLSession {
    
    func request<T: Decodable>(for urlString: String,
                               expecting: T.Type,
                               completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        let task = dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                
                let object = try decoder.decode(expecting, from: data)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
//
//extension Optional where Wrapped == String {
//    var unwrap: String {
//        self ?? ""
//    }
//}
//
//extension Optional where Wrapped == Int {
//    var unwrap: Int {
//        self ?? 0
//    }
//}

protocol Default {
    static var defaultValue: Self { get }
}

extension Optional where Wrapped: Default {

    var unwrap: Wrapped {
        switch self {
        case .none:
            return Wrapped.defaultValue
        case .some(let wrapped):
            return wrapped
        }
    }
}

extension Int: Default {
    static var defaultValue: Int {
        0
    }
}

extension String: Default {
    static var defaultValue: String {
        ""
    }
    
    func customTrim() -> String {
        var result = self
        let openingBracket = self.firstIndex(of: "(")
        let closingBracket = self.firstIndex(of: ")")
        if let openingBracket = openingBracket, let closingBracket = closingBracket {
            let endIndex = self.index(after: closingBracket)
            result = String(self.prefix(upTo: openingBracket) + self.suffix(from: endIndex))
        }
        return result
    }
}
