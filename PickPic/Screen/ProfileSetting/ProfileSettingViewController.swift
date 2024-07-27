//
//  ProfileSettingViewController.swift
//  PickPic
//
//  Created by 여성은 on 7/27/24.
//

import UIKit

class ProfileSettingViewController: BaseViewController {
    private let profileImageView = {
        let view = ProfileImageView(title: "", type: .setting)
        return view
    }()
    private let nicknameTextField = {
        let view = UITextField()
        view.placeholder = "닉네임을 입력해주세요 :)"
        view.font = Constant.Font.regular14
        return view
    }()
    private let underlineView = {
        let view = UIView()
        view.backgroundColor = Constant.Color.lightGray
        return view
    }()
    private let validStatusLabel = {
        let view = UILabel()
        view.font = Constant.Font.regular13
        return view
    }()
    private let titleView = {
        let view = UIView()
        return view
    }()
    private let titleLabel = {
        let view = UILabel()
        view.text = "MBTI"
        view.font = Constant.Font.bold15
        view.textAlignment = .left
        return view
    }()
    private lazy var mbtiCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setLayout())
        view.delegate = self
        view.dataSource = self
        view.register(MBTICollectionViewCell.self, forCellWithReuseIdentifier: MBTICollectionViewCell.id)
        return view
    }()
    private lazy var doneButton = {
        let view = UIButton()
        view.setDisabledOkaybutton(title: "완료")
        view.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        return view
    }()
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileImageView.imageButton.layoutIfNeeded()
        profileImageView.imageButton.layer.cornerRadius = profileImageView.imageButton.frame.height / 2
        profileImageView.cameraView.layoutIfNeeded()
        profileImageView.cameraView.layer.cornerRadius = profileImageView.cameraView.frame.height / 2
        doneButton.layoutIfNeeded()
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func configureHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(underlineView)
        view.addSubview(validStatusLabel)
        view.addSubview(titleView)
        titleView.addSubview(titleLabel)
        view.addSubview(mbtiCollectionView)
        view.addSubview(doneButton)
    }
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(120)
            make.width.equalTo(100)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(36)
        }
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(1)
        }
        validStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(underlineView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(36)
            make.height.equalTo(40)
        } 
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(50)
        }
        mbtiCollectionView.snp.makeConstraints { make in
            make.top.equalTo(underlineView.snp.bottom).offset(50)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo((UIScreen.main.bounds.width*3)/4.0)
            make.bottom.equalTo(doneButton.snp.top)
        }
        titleView.snp.makeConstraints { make in
            make.top.equalTo(underlineView.snp.bottom).offset(50)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(mbtiCollectionView.snp.leading)
            make.bottom.equalTo(doneButton.snp.top)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(titleView.safeAreaLayoutGuide).offset(24)
        }
       
    }
    override func configureView() {
        super.configureView()
        super.setNavBackButton()
        mbtiCollectionView.backgroundColor = .yellow
        titleView.backgroundColor = .blue
    }
    @objc func doneButtonClicked() {
        // input 완료버튼트리거
    }
    private func setLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width*3/4.0) - 32
        layout.itemSize = CGSize(width: width/4 - 1, height: width/4 - 1)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:20)
        return layout
    }

}

extension ProfileSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // output mbti list
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MBTICollectionViewCell.id, for: indexPath) as? MBTICollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
}

#if DEBUG
@available (iOS 17, *)
#Preview {
    ProfileSettingViewController()
}
#endif
