//
//  PhotoDetail.swift
//  PickPic
//
//  Created by 여성은 on 7/26/24.
//

import Foundation

struct PhotoDetail: Decodable {
    let id: String
    let downloads, views: Statistics
}

struct Statistics: Decodable {
    let total: Int
    let historical: Historical
}

struct Historical: Decodable {
    let values: [Value]
}

struct Value: Codable {
    let date: String
    let value: Int
}


