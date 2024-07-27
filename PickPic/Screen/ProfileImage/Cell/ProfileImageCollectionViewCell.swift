//
//  ProfileImageCollectionViewCell.swift
//  PickPic
//
//  Created by 여성은 on 7/27/24.
//

import UIKit

class ProfileImageCollectionViewCell: BaseCollectionViewCell {
    var selectedProfileName: String?
    
    private let profileImageView = {
        let view = ProfileImageView(title: "", type: .unselected)
        return view
    }()
    override func configureHierarchy() {
        addSubview(profileImageView)
    }
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        super.configureView()
        profileImageView.imageButton.layer.cornerRadius = contentView.frame.height / 2
    }
    func configureCell(data: ProfileImage) {
        if selectedProfileName == data.rawValue {
            profileImageView.configureButton(title: data.rawValue, type: .selected)
        } else {
            profileImageView.configureButton(title: data.rawValue, type: .unselected)
        }
    }
}
