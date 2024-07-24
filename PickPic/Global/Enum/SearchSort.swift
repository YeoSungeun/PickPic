//
//  Sort.swift
//  PickPic
//
//  Created by 여성은 on 7/24/24.
//

import Foundation

enum SearchSort: String {
    case latest
    case relevant
    
    var sortString: String {
        switch self {
        case .latest:
            return "최신순"
        case .relevant:
            return "관련순"
        }
    }
}
