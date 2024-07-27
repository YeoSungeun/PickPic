//
//  ViewType.swift
//  PickPic
//
//  Created by 여성은 on 7/27/24.
//

import Foundation

enum ViewType {
    case setting
    case edit
    
    var navTitle: String {
        switch self {
        case .setting:
            "PROFILE SETTING"
        case .edit:
            "EDIT PROFILE"
        }
    }
}
