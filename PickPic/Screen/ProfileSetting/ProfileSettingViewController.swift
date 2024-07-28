//
//  ProfileSettingViewController.swift
//  PickPic
//
//  Created by 여성은 on 7/27/24.
//

import UIKit

class ProfileSettingViewController: BaseViewController {
   
    private lazy var profileImageView = {
        let view = ProfileImageView(title: "", type: .setting)
        view.imageButton.addTarget(self, action: #selector(profileImageClicked), for: .touchUpInside)
        return view
    }()
    private lazy var nicknameTextField = {
        let view = UITextField()
        view.placeholder = "닉네임을 입력해주세요 :)"
        view.font = Constant.Font.regular14
        view.delegate = self
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
    private lazy var withdrawButton = {
        let view = UIButton()
        view.setTitle("회원탈퇴", for: .normal)
        view.setTitleColor(Constant.Color.blue, for: .normal)
        view.addTarget(self, action: #selector(withdrawButtonClicked), for: .touchUpInside)
        return view
    }()
    private lazy var saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
    
    let viewModel = ProfileSettingViewModel()
    
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
        bindData()
    }
    override func configureHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(underlineView)
        view.addSubview(titleView)
        titleView.addSubview(titleLabel)
        view.addSubview(mbtiCollectionView)
        view.addSubview(validStatusLabel)
        view.addSubview(doneButton)
        view.addSubview(withdrawButton)
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
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(50)
        }

        mbtiCollectionView.snp.makeConstraints { make in
            make.top.equalTo(underlineView.snp.bottom).offset(50)
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo((UIScreen.main.bounds.width*3)/4.0)
        }

        titleView.snp.makeConstraints { make in
            make.top.equalTo(underlineView.snp.bottom).offset(50)
            make.leading.bottom.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(mbtiCollectionView.snp.leading)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(titleView.safeAreaLayoutGuide).offset(24)
        }
        validStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(underlineView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(36)
            make.height.equalTo(40)
        }
        withdrawButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        
    }
    override func configureView() {
        super.configureView()
        super.setNavBackButton()
    }
    @objc func profileImageClicked() {
        viewModel.inputProfileClicked.value = ()
    }
    @objc func doneButtonClicked() {
        viewModel.inputDoneButtonClicked.value = ()
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelgate = windowScene?.delegate as? SceneDelegate
        let vc = MainTabBarController()
        sceneDelgate?.window?.rootViewController = vc
        sceneDelgate?.window?.makeKeyAndVisible()
    }
    @objc func saveButtonClicked() {
        viewModel.inputSaveButtonsClicked.value = ()
        navigationController?.popViewController(animated: true)
    }
    @objc func withdrawButtonClicked() {
        viewModel.inputWithdraButtonClicked.value = ()
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelgate = windowScene?.delegate as? SceneDelegate
        let vc = OnboardingViewController()
        let nav = UINavigationController(rootViewController: vc)
        sceneDelgate?.window?.rootViewController = nav
        sceneDelgate?.window?.makeKeyAndVisible()
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
extension ProfileSettingViewController {
    
   

    func bindData() {
        viewModel.outputViewType.bind {[weak self] viewtype in
            if viewtype == .setting {
                self?.doneButton.isHidden = false
                self?.withdrawButton.isHidden = true
                self?.navigationItem.rightBarButtonItem = nil
            } else if viewtype == .edit {
                self?.doneButton.isHidden = true
                self?.withdrawButton.isHidden = false
                self?.navigationItem.rightBarButtonItem = self?.saveButton
            }
        }
        viewModel.outputProfileName.bind { [weak self] value in
            self?.profileImageView.configureButton(title: value, type: .setting)
        }
        // TODO: 되나??
        viewModel.outputVC.bindLater { [weak self] value in
            guard let vc = value else { return }
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        viewModel.outputNickName.bind { [weak self] value in
            // edit일 때 가져온는 닉네임!
            // textfield.text로 값 보내주면 textFieldDidChangeSelection실행되는지 확인
            guard let value = value, !value.isEmpty else {
                self?.validStatusLabel.isHidden = true
                return
            }
            self?.validStatusLabel.isHidden = false
            self?.nicknameTextField.text = value
            
        }
        viewModel.outputNicknameValid.bind { [weak self] value in
            if value {
                self?.validStatusLabel.textColor = Constant.Color.blue
            } else {
                self?.validStatusLabel.textColor = Constant.Color.warning
            }
        }
        viewModel.outputNicknameValidComent.bind { [weak self] value in
            self?.validStatusLabel.text = value
        }
        viewModel.outputList.bind { [weak self] _ in
            print("=====outputList======")
            self?.mbtiCollectionView.reloadData()
        }
        viewModel.outputDoneButtonStatus.bind { value in
            print("==========outputDoneButtonStatus============",value)
            if value {
                self.doneButton.setEnabledOkaybutton(title: "완료")
                self.saveButton.isEnabled = true
            } else {
                self.doneButton.setDisabledOkaybutton(title: "완료")
                self.saveButton.isEnabled = false
            }
        }
    }
}
extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        viewModel.inputNickname.value = nicknameTextField.text
    }
}

extension ProfileSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputList.value?.count ?? 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MBTICollectionViewCell.id, for: indexPath) as? MBTICollectionViewCell else { return UICollectionViewCell() }
        guard let list = viewModel.outputList.value else { return UICollectionViewCell()}
        let data = list[indexPath.row]
        cell.configureCell(data: data)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputMBTIButtonIndex.value = indexPath.item
    }
    
}

#if DEBUG
@available (iOS 17, *)
#Preview {
    ProfileSettingViewController()
}
#endif
