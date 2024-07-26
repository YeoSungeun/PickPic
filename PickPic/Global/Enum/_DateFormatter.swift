//
//  _DateFormatter.swift
//  PickPic
//
//  Created by 여성은 on 7/27/24.
//

import Foundation

enum _DateFormatter: String {
    static let standard = DateFormatter()

    case dateWithTime = "yyyy-MM-dd HH:mm:ss"
    case date = "yyyy-MM-dd"
    case weekend = "E"
}
