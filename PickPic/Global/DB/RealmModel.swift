//
//  RealmModel.swift
//  PickPic
//
//  Created by 여성은 on 7/25/24.
//

import Foundation
import RealmSwift

class LikedItem: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var image : String
    @Persisted var width : Int
    @Persisted var height : Int
    @Persisted var regDate : Date
    @Persisted var createdDate: String
    @Persisted var photographerName: String
    @Persisted var photographerProfile: String?
    
    
    convenience init(id: String, image: String, width: Int, height: Int, regDate: Date, createdDate: String, photographerName: String, photographerProfile: String?) {
        self.init()
        self.id = id
        self.image = image
        self.width = width
        self.height = height
        self.regDate = regDate
        self.createdDate = createdDate
        self.photographerName = photographerName
        self.photographerProfile = photographerProfile
    }
}

class UserInfo: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var nickname : String?
    @Persisted var profileImageName: String?
    @Persisted var E: Bool
    @Persisted var S: Bool
    @Persisted var T: Bool
    @Persisted var J: Bool
    @Persisted var I: Bool
    @Persisted var N: Bool
    @Persisted var F: Bool
    @Persisted var P: Bool
    
    convenience init(id: String, nickname: String? = nil, profileImageName: String? = nil, E: Bool, S: Bool, T: Bool, J: Bool, I: Bool, N: Bool, F: Bool, P: Bool) {
        self.init()
        self.id = "userID"
        self.nickname = nickname
        self.profileImageName = profileImageName
        self.E = false
        self.S = false
        self.T = false
        self.J = false
        self.I = false
        self.N = false
        self.F = false
        self.P = false
    }
}

