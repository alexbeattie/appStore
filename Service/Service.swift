//
//  Service.swift
//  appStore
//
//  Created by Alex Beattie on 4/23/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service() // singleton
    
    func fetchApps(completion: @escaping ([Result], Error?) -> () ) {
        print("fetching itunes apps from Service layer")
        let urlString = "http://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }
      
        //fetch data
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch apps", err)
                completion([], nil)
                return
            }
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from:data)
                completion(searchResult.results, nil)
                
            } catch let jsonErr {
                print("failed to decode", jsonErr)
                completion([], jsonErr)
            }
            
            
            }.resume()

    }
}
