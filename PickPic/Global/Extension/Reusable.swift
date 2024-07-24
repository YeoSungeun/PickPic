//
//  Reusable.swift
//  PickPic
//
//  Created by 여성은 on 7/24/24.
//

import UIKit

protocol ReusableProtocol {
    static var id: String { get }
}

extension UIViewController: ReusableProtocol {
    static var id: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableProtocol {
    static var id: String {
        return String(describing: self)
    }
}
