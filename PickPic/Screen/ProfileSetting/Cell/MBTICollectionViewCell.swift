//
//  MBTICollectionViewCell.swift
//  PickPic
//
//  Created by 여성은 on 7/27/24.
//

import UIKit

class MBTICollectionViewCell: BaseCollectionViewCell {
    let mbtiLabel = {
        let view = UILabel()
        view.clipsToBounds = true
        view.textAlignment = .center
        view.font = Constant.Font.regular16
        view.backgroundColor = .clear
        return view
    }()
    let mbtiButton = {
        let view = UIButton()
        view.backgroundColor = .blue
        view.layer.borderColor = Constant.Color.gray.cgColor
        return view
    }()
    override func configureHierarchy() {
        addSubview(mbtiButton)
        addSubview(mbtiLabel)
    }
    override func configureLayout() {
        mbtiButton.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }  
        mbtiLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        super.configureView()
    }
    func configureCell( ) {
        
    }

}

#if DEBUG
@available (iOS 17, *)
#Preview {
    MBTICollectionViewCell()
}
#endif
