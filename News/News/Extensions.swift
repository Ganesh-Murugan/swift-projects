//
//  Extensions.swift
//  News
//
//  Created by zoho on 14/07/22.
//

import Foundation
import UIKit

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
        "0"
    }
}


extension UIImage {
    func resize(width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let format = imageRendererFormat
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}


extension URLSession {
    enum CustomError: Error{
        case invalidUrl, invalidData
    }
    func request<T: Decodable>(
        for urlString: String, expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        let task = dataTask(with: url) { (data, _, error) in
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

var cache: NSCache<NSString, AnyObject> = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImage(_ urlString: String) {
        if let image = cache.object(forKey: urlString as NSString) as? UIImage{
            self.image = image
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data)?.resize(width: 404, height: 300){
                    DispatchQueue.main.async {
                        self.image = image
                        cache.setObject(image, forKey: urlString as NSString)
                    }
                }
            }
            
        }
    }
}

extension UIViewController {
    func startLoading(_ message: String) -> UIAlertController {

        let alert = UIAlertController(title: nil, message: "loading...", preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 20, y: 10, width: 50, height: 40))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .black
        alert.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        return alert
    }

    func stopLoader(_ alert: UIAlertController){
        alert.dismiss(animated: true)
    }
}


extension UIAlertController {
    static var defaultAlert: UIAlertController {
        UIAlertController(title: nil, message: "Loading..", preferredStyle: .alert)
    }
}
