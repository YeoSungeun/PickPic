//
//  DetailViewController.swift
//  PickPic
//
//  Created by 여성은 on 7/22/24.
//

import UIKit

final class DetailViewController: BaseViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let topInfoView = TopInfoView()
    private let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let statisticsView = StatisticsView()
    let viewModel = DetailViewModel()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topInfoView.photographerProfileImageView.layoutIfNeeded()
        topInfoView.photographerProfileImageView.layer.cornerRadius = topInfoView.photographerProfileImageView.frame.height / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidLoad() {
        viewModel.inputScreenWidth.value = UIScreen.main.bounds.width
        super.viewDidLoad()
        print(#function,"detailviewcontroller ")
        bindData()
    }
    override func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topInfoView)
        contentView.addSubview(imageView)
        contentView.addSubview(statisticsView)
    }
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
        topInfoView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(topInfoView.snp.bottom)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(viewModel.outputConstraintHeight.value)
        }
        statisticsView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.bottom.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        
    }
    override func configureView() {
        super.configureView()
        super.setNavBackButton()
        imageView.backgroundColor = Constant.Color.lightGray

        topInfoView.likedButton.addTarget(self, action: #selector(likedButtonClicked), for: .touchUpInside)
    }
    @objc func likedButtonClicked() {
        viewModel.inputLikedButtonClicked.value = ()
    }
    func bindData() {
        viewModel.outputAlert.bindLater { [weak self] _ in
            self?.showAlert(title: "데이터를 불러오는데 실패했습니다.", message: "", ok: "확인", handler: {
                self?.navigationController?.popViewController(animated: true)
            })
        }
        viewModel.outputConstraintHeight.bind { [weak self] _ in
            print("========height", self?.viewModel.outputConstraintHeight.value)
            self?.configureHierarchy()
        }
        viewModel.outputUserProfileImage.bind { [weak self] value in
            guard let url = URL(string: value ?? "") else { return }
            self?.topInfoView.photographerProfileImageView.kf.setImage(with: url)
        }
        viewModel.outputUserName.bind { [weak self] value in
            self?.topInfoView.photographerNameLabel.text = value
        }
        viewModel.outputCreatedAt.bind { [weak self] value in
            self?.topInfoView.createDateLabel.text = value
        }
        viewModel.outputPhotoUrl.bind { [weak self] value in
            guard let url = URL(string: value) else { return }
            self?.imageView.kf.setImage(with: url)
        }
        viewModel.outputSize.bind { [weak self] (width, height) in
            self?.statisticsView.sizeView.content.text = "\(width) x \(height)"
        }
        viewModel.outputViews.bind { [weak self] value in
            self?.statisticsView.viewsView.content.text = value.formatted()
        }
        viewModel.outputDownloads.bind { [weak self] value in
            self?.statisticsView.downloadView.content.text = value.formatted()
        }
        viewModel.outputIsLiked.bind { [weak self] value in
            let image = value ? UIImage(named: "like") : UIImage(named: "like_inactive")?.withTintColor(Constant.Color.gray.withAlphaComponent(0.5))
            self?.topInfoView.likedButton.setImage(image, for: .normal)
            
        }
    }
}
extension DetailViewModel {

}

