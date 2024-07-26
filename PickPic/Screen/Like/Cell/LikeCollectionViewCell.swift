//
//  LikeCollectionViewCell.swift
//  PickPic
//
//  Created by 여성은 on 7/25/24.
//

import UIKit
import SnapKit
import Kingfisher

final class LikeCollectionViewCell: BaseCollectionViewCell {
    private let photoImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    let likeButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "like_circle_inactive"), for: .normal)
        return view
    }()
    private let repository = LikedItemRepository()
    
    override func configureHierarchy() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(likeButton)
    }
    override func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(photoImageView.snp.trailing).inset(12)
            make.bottom.equalTo(photoImageView.snp.bottom).inset(12)
            make.height.width.equalTo(24)
        }
    }
    override func configureView() {
        contentView.backgroundColor = Constant.Color.lightGray
    }
    func configureCell(data: LikedItem) {
        
//        guard let url = URL(string: data.image) else { return }
//        photoImageView.kf.setImage(with: url)
        photoImageView.image = FileService.loadImageToDocument(filename: "\(data.id)")
        if repository.isLiked(id: data.id) {
            likeButton.setImage(UIImage(named: "like_circle"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "like_circle_inactive"), for: .normal)
        }
    }
}
