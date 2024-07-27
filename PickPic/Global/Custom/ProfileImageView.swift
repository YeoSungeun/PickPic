//
//  ProfileImageView.swift
//  PickPic
//
//  Created by 여성은 on 7/27/24.
//

import UIKit
import SnapKit

final class ProfileImageView: BaseView {
    private let profileView = {
        let view = UIView()
        return view
    }()
    let imageButton = {
        let view = UIButton()
        view.clipsToBounds = true
        return view
    }()
    let cameraView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    private let cameraImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "camera.fill")
        return view
    }()
    
    init(title: String, type: ProfileImageType) {
        super.init(frame: .zero)
        print(#function,"titleInit")
        configureButton(title: title, type: type)
    }
    override func configureHierarchy() {
        addSubview(profileView)
        profileView.addSubview(imageButton)
        profileView.addSubview(cameraView)
        cameraView.addSubview(cameraImageView)
    }
    override func configureLayout() {
        profileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageButton.snp.makeConstraints { make in
            make.edges.equalTo(profileView.safeAreaLayoutGuide)
            make.height.equalTo(imageButton.snp.width)
        }
        cameraView.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileView.safeAreaLayoutGuide).inset(2)
            make.width.equalTo(profileView.snp.width).multipliedBy(0.25)
            make.height.equalTo(cameraView.snp.width)
        }
        cameraImageView.snp.makeConstraints { make in
            make.edges.equalTo(cameraView.safeAreaLayoutGuide).inset(2)
        }
        
    }
    override func configureView() {
        super.configureView()
        cameraView.backgroundColor = Constant.Color.blue
        cameraImageView.tintColor = Constant.Color.white
    }
    func configureButton(title: String, type: ProfileImageType) {
        imageButton.setImage(UIImage(named: title), for: .normal)
        switch type {
        case .setting:
            cameraView.isHidden = false
            imageButton.layer.borderWidth = 3
            imageButton.layer.borderColor = Constant.Color.blue.cgColor
            self.alpha = 1
        case .selected:
            cameraView.isHidden = true
            imageButton.layer.borderWidth = 3
            imageButton.layer.borderColor = Constant.Color.blue.cgColor
            self.alpha = 1
        case .unselected:
            cameraView.isHidden = true
            imageButton.layer.borderWidth = 1
            imageButton.layer.borderColor = Constant.Color.gray.cgColor
            self.alpha = 0.5
        }
    }
}

#if DEBUG
@available (iOS 17, *)
#Preview {
    ProfileImageView(title: "profile_0", type: .unselected)
}
#endif
