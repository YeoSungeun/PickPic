//
//  SearchCollectionViewCell.swift
//  PickPic
//
//  Created by 여성은 on 7/24/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchCollectionViewCell: BaseCollectionViewCell {
    let photoImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
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
    let likeButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "like_circle_inactive"), for: .normal)
        return view
    }()
    let repository = LikedItemRepository()
    
    override func configureHierarchy() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(likesView)
        likesView.addSubview(likesImageView)
        likesView.addSubview(likesLabel)
        contentView.addSubview(likeButton)
    }
    override func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        likesView.snp.makeConstraints { make in
            make.leading.equalTo(photoImageView.snp.leading).offset(12)
            make.bottom.equalTo(photoImageView.snp.bottom).inset(12)
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
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(photoImageView.snp.trailing).inset(12)
            make.bottom.equalTo(photoImageView.snp.bottom).inset(12)
            make.height.width.equalTo(24)
        }
    }
    override func configureView() {
    }
    func configureCell(data: Photo) {
        guard let url = URL(string: data.urls.small) else { return }
        photoImageView.kf.setImage(with: url)
        
        likesLabel.text = data.likesString
        // TODO: 여기서 좋아요 판별해서 버튼 이미지 세팅해주기!
        if repository.isLiked(id: data.id) {
            likeButton.setImage(UIImage(named: "like_circle"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "like_circle_inactive"), for: .normal)
        }
    }
}



#if DEBUG
@available (iOS 17, *)
#Preview {
    SearchCollectionViewCell()
}
#endif
