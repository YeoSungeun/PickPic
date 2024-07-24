//
//  UIButton+Extension.swift
//  PickPic
//
//  Created by 여성은 on 7/24/24.
//

import UIKit

extension UIButton.Configuration {
    //TODO: extension에서 빼기?
    static func sortButtonStyle(title: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.attributedTitle?.font = Constant.Font.bold13
        configuration.titleAlignment = .center
        configuration.image = UIImage(named: "sort")
        configuration.imagePadding = CGFloat(4)
        configuration.baseBackgroundColor = Constant.Color.white
        configuration.baseForegroundColor = Constant.Color.black
        configuration.background.strokeColor = Constant.Color.lightGray
        configuration.cornerStyle = .capsule

        return configuration
    }
}
