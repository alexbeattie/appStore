//
//  SearchResult.swift
//  appStore
//
//  Created by Alex Beattie on 4/23/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import Foundation
struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
    
}
struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
}
