//
//  LikeViewController.swift
//  PickPic
//
//  Created by 여성은 on 7/22/24.
//

import UIKit
import SnapKit

final class LikeViewController: BaseViewController {
    private let sortView = UIView()
    private lazy var sortButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
        return view
    }()
    private let likeView = UIView()
    private lazy var likeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setLayout())
    private let noLikeView = UIView()
    private let noLikeLabel = {
        let view = UILabel()
        view.font = Constant.Font.bold14
        view.text = "저장된 사진이 없어요."
        view.textAlignment = .center
        return view
    }()
    private var list: [LikedItem] = [] {
        didSet {
            print("리스트 디드셋~!!!!!!!!!!")
            if list.count == 0 {
                likeView.isHidden = true
                noLikeView.isHidden = false
            } else {
                likeView.isHidden = false
                noLikeView.isHidden = true
            }
            likeCollectionView.reloadData()
        }
    }
    private var sort: LikedSort = .latest
    
    private let repository = LikedItemRepository()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function, sort)
        if sort == .latest {
            list = repository.getDataDesc()
        } else if sort == .oldest {
            list = repository.getDateAsc()
        }
        likeCollectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
//        list = repository.getDataDesc()
//        likeCollectionView.reloadData()
    }
    override func configureHierarchy() {
        print(#function)
        view.addSubview(likeView)
        likeView.addSubview(sortView)
        sortView.addSubview(sortButton)
        likeView.addSubview(likeCollectionView)
        view.addSubview(noLikeView)
        noLikeView.addSubview(noLikeLabel)
    }
    override func configureLayout() {
        print(#function)
        likeView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        sortView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(likeView.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        sortButton.snp.makeConstraints { make in
            make.centerY.equalTo(sortView.snp.centerY)
            make.trailing.equalTo(sortView.snp.trailing).inset(8)
            make.height.equalTo(36)
        }
        likeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sortView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(likeView.safeAreaLayoutGuide)
        }
        noLikeView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        noLikeLabel.snp.makeConstraints { make in
            make.center.equalTo(noLikeView.snp.center)
        }
    }
    override func configureView() {
        print(#function)
       
        super.configureView()
        print(#function)
        navigationItem.title = "MY POLALOID"
        sortButton.configuration = .sortButtonStyle(title: LikedSort.latest.sortString)
        sortButton.layer.shadowColor = Constant.Color.gray.cgColor
        sortButton.layer.shadowOpacity = 0.5
        sortButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        sortButton.layer.masksToBounds = false
        likeCollectionView.delegate = self
        likeCollectionView.dataSource = self
        likeCollectionView.register(LikeCollectionViewCell.self, forCellWithReuseIdentifier: LikeCollectionViewCell.id)
        print(list, list.count)
        if list.count != 0 {
            likeView.isHidden = false
            noLikeView.isHidden = true
        } else {
            likeView.isHidden = false
            noLikeView.isHidden = true
        }
        
    }
    private func setLayout() -> UICollectionViewLayout {
        let width = UIScreen.main.bounds.width - 24
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: width/2, height: (width/2)*(4/3))
        
        return layout
    }
    @objc private func sortButtonClicked(){
        if let sort = sortButton.configuration?.title{
            print(sort)
            if sort == LikedSort.latest.sortString{
                sortButton.configuration = .sortButtonStyle(title: LikedSort.oldest.sortString)
                list = repository.getDateAsc()
                self.sort = .oldest
            } else if sort == LikedSort.oldest.sortString {
                sortButton.configuration = .sortButtonStyle(title: LikedSort.latest.sortString)
                list = repository.getDataDesc()
                self.sort = .latest
            }
        }
    }
    @objc private func likeButtonClicked(sender: UIButton) {
        let photo = list[sender.tag]
        FileService.removeImageFromDocument(filename: photo.id)
        repository.deleteItem(id: photo.id)
        list.remove(at: sender.tag)
        likeCollectionView.reloadData()
        print(list)
        print(list.count)
    }
}

extension LikeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeCollectionViewCell.id, for: indexPath) as? LikeCollectionViewCell else { return UICollectionViewCell()}
        let data = list[indexPath.item]
        cell.configureCell(data: data)
//        cell.photoImageView.image = loadImageToDocument(filename: "\(data.id)")
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath)
        let vc = DetailViewController()
        vc.viewModel.inputLikedItem.value = list[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}
