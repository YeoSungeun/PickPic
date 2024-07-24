//
//  LikedItemRepository.swift
//  PickPic
//
//  Created by 여성은 on 7/25/24.
//

import UIKit
import RealmSwift

final class LikedItemRepository {
    private let realm = try! Realm()
    
    func getFileURL() {
        guard let fileURL = realm.configuration.fileURL else { return }
        print(fileURL)
    }
    func createItem(_ data: LikedItem) {
        try! realm.write {
            realm.add(data)
        }
    }
    func deleteItem(id: String) {
//        try! realm.write {
//            realm.delete(data)
//        }
        try! realm.write {
            realm.delete(realm.objects(LikedItem.self).filter("id=%@", id))
        }
    }
    func isLiked(id: String) -> Bool {
        let list = fetchAll()
        let likedList = list?.where({
            $0.id == id
        })
        if likedList?.count != 0 {
            return true
        } else {
            return false
        }
    }
    
    func fetchAll() -> Results<LikedItem>! {
        let value = realm.objects(LikedItem.self)
        return value
    }
    func fetchData(id: String) -> LikedItem? {
        guard let value = realm.object(ofType: LikedItem.self, forPrimaryKey: id) else { return nil }
        return value
    }
   

}

