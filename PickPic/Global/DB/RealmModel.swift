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
    
    convenience init(id: String, image: String, width: Int, height: Int, regDate: Date) {
        self.init()
        self.id = id
        self.image = image
        self.width = width
        self.height = height
        self.regDate = regDate
    }
}

class UserInfo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var isSignUp : Bool
    @Persisted var nickname : String?

}

