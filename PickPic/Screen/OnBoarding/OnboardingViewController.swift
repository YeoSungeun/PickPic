//
//  OnboardingViewController.swift
//  PickPic
//
//  Created by 여성은 on 7/25/24.
//

import UIKit
import SnapKit

final class OnboardingViewController: BaseViewController {
    private let logoImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: "launch")
        return view
    }()
    private let onboardingImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: "launchImage")
        return view
    }()
    private let nameLabel = {
        let view = UILabel()
        view.text = "여성은"
        view.textAlignment = .center
        view.font = Constant.Font.name
        return view
    }()
    private let startButton = {
        var view = UIButton()
        view.setEnabledOkaybutton(title: "시작하기")
        return view
       
    }()
    override func configureHierarchy() {
        view.addSubview(logoImageView)
        view.addSubview(onboardingImageView)
        view.addSubview(nameLabel)
        view.addSubview(startButton)
    }
    override func configureLayout() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(logoImageView.snp.width).multipliedBy(241/884)
        }
        onboardingImageView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(onboardingImageView.snp.width).multipliedBy(375/335)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(onboardingImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(50)
        }
    }
}
#if DEBUG
@available (iOS 17, *)
#Preview {
    OnboardingViewController()
}
#endif
