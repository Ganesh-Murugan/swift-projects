//
//  APIHandler.swift
//  CollegeList
//
//  Created by zoho on 06/07/22.
//

import Foundation

class APIHandler {
    
    func fetchquery(_ country: String?, completion: @escaping (([Colleges])->Void)) {
        var url = Constants.Urls.collegesUrl
        guard let country = country?.replacingOccurrences(of: " ", with: "%20") else {
            return
        }
        url += "?country=\(country)"
        print(url)
        URLSession.shared.request(for: url, expecting: [Colleges].self) { result in
            switch result {
            case .success(let responseData):
                completion(responseData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCountryData(completion: @escaping ([Countries])->Void) {
        let url = Constants.Urls.countriesUrl
        URLSession.shared.request(for: url, expecting: CountryApiResponse.self) { result in
            switch result {
            case .success(let responseData):
                guard let countries = responseData.data?.values else {
                    return
                }
                completion(Array(countries))
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
