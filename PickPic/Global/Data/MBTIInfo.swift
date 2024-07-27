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

enum MBTI: CaseIterable {
    case E
    case S
    case T
    case J
    case I
    case N
    case F
    case P
}
