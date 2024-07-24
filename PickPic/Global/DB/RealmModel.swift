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
    @Persisted var regDate : Date
    
    convenience init(id: String, image: String, regDate: Date) {
        self.init()
        self.id = id
        self.image = image
        self.regDate = regDate
    }
}

