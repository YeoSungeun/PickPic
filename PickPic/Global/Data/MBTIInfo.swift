//
//  MBTIInfo.swift
//  PickPic
//
//  Created by 여성은 on 7/27/24.
//

import Foundation

struct MBTIInfo {
    let mbti: MBTI
    var isClicked: Bool
}

enum MBTI: Int, CaseIterable {
    case E
    case S
    case T
    case J
    case I
    case N
    case F
    case P
    
    var mbtiString: String {
        switch self {
        case .E:
            "E"
        case .S:
            "S"
        case .T:
            "T"
        case .J:
            "J"
        case .I:
            "I"
        case .N:
            "N"
        case .F:
            "F"
        case .P:
            "P"
        }
    }
}
