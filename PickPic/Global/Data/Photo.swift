//
//  Photo.swift
//  PickPic
//
//  Created by 여성은 on 7/23/24.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let color: String
    let urls: ImageSize
    let likes: Int
    let user: User
}

struct ImageSize: Decodable  {
    let raw: String
    let regular: String
    let small: String
}

struct User: Decodable  {
    let id: String
    let name: String
    let profile_image: ProfileImageSize?
}

struct ProfileImageSize: Decodable  {
    let small, medium, large: String
}
