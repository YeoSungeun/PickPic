//
//  TopInfoView.swift
//  PickPic
//
//  Created by 여성은 on 7/26/24.
//

import UIKit
import SnapKit


final class TopInfoView: BaseView {
    let photographerProfileImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    let photographerNameLabel = {
        let view = UILabel()
        view.font = Constant.Font.regular13
        return view
    }()
    let createDateLabel = {
        let view = UILabel()
        view.font = Constant.Font.bold13
        return view
    }()
    let likedButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "like"), for: .normal)
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(photographerProfileImageView)
        addSubview(photographerNameLabel)
        addSubview(createDateLabel)
        addSubview(likedButton)
    }
    override func configureLayout() {
        photographerProfileImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.width.equalTo(photographerProfileImageView.snp.height)
        }
        photographerNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(photographerProfileImageView.snp.trailing).offset(8)
            make.bottom.equalTo(self.snp.centerY).offset(-1)
        }
        createDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(photographerProfileImageView.snp.trailing).offset(8)
            make.top.equalTo(self.snp.centerY).offset(1)
        }
        likedButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide).inset(12)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
    }
    override func configureView() {
        photographerProfileImageView.image = UIImage(systemName: "star")
        photographerProfileImageView.backgroundColor = .red
        photographerNameLabel.text = "작가이름"
        createDateLabel.text = "2022년 8월 20일 게시됨"
    }
}

#if DEBUG
@available (iOS 17, *)
#Preview {
    TopInfoView()
}
#endif
