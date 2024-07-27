//
//  BaseView.swift
//  PickPic
//
//  Created by 여성은 on 7/23/24.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("BaseView", #function)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() { print("BaseView", #function) }
    func configureLayout() { print("BaseView", #function) }
    func configureView() { print("BaseView", #function) }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
