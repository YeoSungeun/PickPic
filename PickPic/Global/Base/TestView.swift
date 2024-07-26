//
//  TestView.swift
//  PickPic
//
//  Created by 여성은 on 7/26/24.
//

import UIKit

class TestView: BaseView {
    let button = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "person"), for: .normal)
        return view
    }()
    override func configureHierarchy() {
        addSubview(button)
    }
    override func configureLayout() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    override func configureView() {
        button.backgroundColor = .yellow
    }
}
