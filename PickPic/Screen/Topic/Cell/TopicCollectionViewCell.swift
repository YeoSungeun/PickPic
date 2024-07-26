//
//  TopicCollectionViewCell.swift
//  PickPic
//
//  Created by 여성은 on 7/26/24.
//

import UIKit
import Kingfisher


class TopicCollectionViewCell: BaseCollectionViewCell {
    
    private let mainImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .green
        return view
    }()
    private let likesView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = Constant.Color.darkGray.withAlphaComponent(0.8)
        return view
    }()
    private let likesImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = Constant.Color.yellow
        return view
    }()
    private let likesLabel = {
        let view = UILabel()
        view.textColor = Constant.Color.white
        view.font = Constant.Font.regular13
        return view
    }()
    override func configureHierarchy() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(likesView)
        likesView.addSubview(likesImageView)
        likesView.addSubview(likesLabel)
    }
    override func configureLayout() {
        mainImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        likesView.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView.snp.leading).offset(12)
            make.bottom.equalTo(mainImageView.snp.bottom).inset(12)
            make.height.equalTo(24)
        }
        likesImageView.snp.makeConstraints { make in
            make.centerY.equalTo(likesView.snp.centerY)
            make.height.width.equalTo(12)
            make.leading.equalTo(likesView.snp.leading).offset(12)
        }
        likesLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likesView.snp.centerY)
            make.leading.equalTo(likesImageView.snp.trailing).offset(4)
            make.trailing.equalTo(likesView.snp.trailing).inset(12)
        }
        
    }
    override func configureView() {
        backgroundColor = .lightGray
    }
    
    func configureUI(data: Photo) {
        guard let url = URL(string: data.urls.small) else { return }
        mainImageView.kf.setImage(with: url)
        likesLabel.text = data.likesString
    }
}

