//
//  Constant.swift
//  PickPic
//
//  Created by 여성은 on 7/24/24.
//

import UIKit

enum Constant {
    enum Color {
        static let blue = UIColor(rgb: 0x186FF2)
        static let warning = UIColor(rgb: 0xF04452)
        static let black = UIColor(rgb: 0x000000)
        static let darkGray = UIColor(rgb: 0x4D5652)
        static let gray = UIColor(rgb: 0x8C8C8C)
        static let lightGray = UIColor(rgb: 0xF2F2F2)
        static let white = UIColor(rgb: 0xFFFFFF)
    }
    enum Font {
        static let bold16 = UIFont.boldSystemFont(ofSize: 16)
        static let bold15 = UIFont.boldSystemFont(ofSize: 15)
        static let bold14 = UIFont.boldSystemFont(ofSize: 14)
        static let bold13 = UIFont.boldSystemFont(ofSize: 13)
        
        static let regular15 = UIFont.systemFont(ofSize: 15)
        static let regular14 = UIFont.systemFont(ofSize: 14)
        static let regular13 = UIFont.systemFont(ofSize: 13)
        
        static let logo = UIFont(name: "Rockwell Bold", size: 40)

    }
}
