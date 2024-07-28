//
//  UserInfoRepository.swift
//  PickPic
//
//  Created by 여성은 on 7/27/24.
//

import Foundation
import RealmSwift

final class UserInfoRepository {
    private let realm = try! Realm()
    
    func getFileURL() {
        guard let fileURL = realm.configuration.fileURL else { return }
        print(fileURL)
    }
    func createUserInfo(_ data: UserInfo) {
        do {try realm.write {
            realm.add(data)
        }
        }catch {
            print("realm error")
        }
    }
    func modifyProfile(nickname: String?, profileImageName: String?, E: Bool, S: Bool, T: Bool, J: Bool, I: Bool, N: Bool, F: Bool, P: Bool) {
        do {
            try realm.write {
                realm.create(UserInfo.self,
                             value: ["id": "userID",
                                     "nickname": nickname ?? "", "profileImageName": profileImageName ?? "",
                                     "E": E, "S": S, "T": T, "J": J, "I": I, "N": N, "F": F, "P": P],
                             update: .modified)
            }
        } catch {
            print("realm modify error")
        }
    }
    func withDrawUser() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func isUser() -> Bool {
        let list = realm.objects(UserInfo.self)
        if list.count == 0 {
            return false
        } else {
            return true
        }
    }
    func fetchMBTIStatusList() -> [Bool] {
        var list: [Bool] = []
        guard let userInfo = fetchUserInfo() else { return []}
        let info = [userInfo.E, userInfo.S, userInfo.T, userInfo.J, userInfo.I, userInfo.N, userInfo.F, userInfo.P]
        list.append(contentsOf: info)
        return list
    }
    func fetchUserInfo() -> UserInfo? {
        let value = realm.objects(UserInfo.self)
        guard value.count != 0, !value.isEmpty else { return nil}
        return value[0]
    }
    
}
