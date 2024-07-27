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

extension UIButton {
    func setEnabledOkaybutton(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(Constant.Color.white, for: .normal)
        self.backgroundColor = Constant.Color.blue
        titleLabel?.font = Constant.Font.bold16
        self.isEnabled = true
    }
    func setDisabledOkaybutton(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(Constant.Color.white, for: .normal)
        self.backgroundColor = Constant.Color.gray
        titleLabel?.font = Constant.Font.bold16
        self.isEnabled = false
    }
}
