//
//  SearchResult.swift
//  PickPic
//
//  Created by 여성은 on 7/23/24.
//

import Foundation

struct SearchResult: Decodable {
    let total: Int
    let total_pages: Int
    var results: [Photo]

}
