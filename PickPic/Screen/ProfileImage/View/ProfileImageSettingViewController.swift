//
//  ProfileImageSettingViewController.swift
//  PickPic
//
//  Created by 여성은 on 7/27/24.
//

import UIKit

final class ProfileImageSettingViewController: BaseViewController {
    var viewType: ViewType?
    var profileName = "profile_0"
    var getProfileName: ((String) -> Void)?
    
    private let selectedProfileView = {
        let view = ProfileImageView(title: "", type: .setting)
        return view
    }()
    private lazy var settingCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setLayout())
        view.delegate = self
        view.dataSource = self
        view.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
        return view
    }()
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        selectedProfileView.imageButton.layoutIfNeeded()
        selectedProfileView.imageButton.layer.cornerRadius = selectedProfileView.imageButton.frame.height / 2
        selectedProfileView.cameraView.layoutIfNeeded()
        selectedProfileView.cameraView.layer.cornerRadius = selectedProfileView.cameraView.frame.height / 2
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewType = .setting
    }
    override func configureHierarchy() {
        view.addSubview(selectedProfileView)
        view.addSubview(settingCollectionView)
    }
    override func configureLayout() {
        selectedProfileView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(120)
            make.width.equalTo(100)
        }
        settingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(selectedProfileView.snp.bottom).offset(50)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        super.configureView()
        super.setNavBackButton()
        navigationItem.title = viewType?.navTitle
        selectedProfileView.configureButton(title: profileName, type: .setting)
    }
    override func backButtonClicked() {
        super.backButtonClicked()
        getProfileName?(profileName)
    }
    private func setLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 70
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right:20)
        return layout
    }
  
}

extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileImage.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as? ProfileImageCollectionViewCell else { return UICollectionViewCell() }
        cell.selectedProfileName = profileName
        cell.configureCell(data: ProfileImage.allCases[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        profileName = ProfileImage.allCases[indexPath.item].rawValue
        selectedProfileView.configureButton(title: profileName, type: .setting)
        collectionView.reloadData()
    }
    
    
}

