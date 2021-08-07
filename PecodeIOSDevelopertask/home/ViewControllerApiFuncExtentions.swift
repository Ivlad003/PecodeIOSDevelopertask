//
//  ViewControllerApiFuncExtentions.swift
//  ViewControllerApiFuncExtentions
//
//  Created by kosmodev on 06.08.2021.
//

import Foundation

extension ViewController{
    func getNews(q: String = "apple") {
        sendRequest("https://newsapi.org/v2/everything", parameters: [
            "q": "apple",
            "from": "2021-08-05",
            "sortBy":"publishedAt",
            "pageSize": "10",
            "page": String(nextPage),
            "apiKey": "cd844480954845d59ae6db768267d719"]) { responseObject, error in
                guard let responseObject = responseObject, error == nil else {
                    print(error ?? "Unknown error")
                    return
                }
                DispatchQueue.main.async {
                    if self.newsModel != nil, let articles = responseObject.articles {
                        self.newsModel?.articles?.append(contentsOf: articles)
                    } else {
                        self.newsModel = responseObject
                    }
                    self.currentCount = self.newsModel?.articles?.count ?? 0
                    self.table.reloadData()
                    self.nextPage += 1
                    self.spinner?.isHidden = true
                }
            }
    }
    
    func sendRequest(_ url: String, parameters: [String: String], completion: @escaping (NewsModel?, Error?) -> Void) {
        var components = URLComponents(string: url)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,                              // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                200 ..< 300 ~= response.statusCode,           // is statusCode 2XX
                error == nil                                  // was there no error
            else {
                completion(nil, error)
                return
            }
            
            let json: Any?
            
            json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try! decoder.decode(NewsModel.self, from: data)
            
            completion(result, nil)
        }
        task.resume()
    }
}
