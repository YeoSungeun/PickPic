//
//  TitleSupplementaryView.swift
//  PickPic
//
//  Created by 여성은 on 7/26/24.
//
import UIKit
import SnapKit

class TitleSupplementaryView: UICollectionReusableView {
    static let reuseIdentifier = "title-supplementary-reuse-identifier"
    let label = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleSupplementaryView {
    func configure() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        label.font = Constant.Font.bold16
    }
}
