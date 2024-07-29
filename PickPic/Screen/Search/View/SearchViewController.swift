//
//  SearchViewController.swift
//  PickPic
//
//  Created by 여성은 on 7/22/24.
//

import UIKit
import Alamofire
import SnapKit

final class SearchViewController: BaseViewController {
    private lazy var searchBar = {
        let view = UISearchBar()
        view.placeholder = "키워드 검색"
        view.delegate = self
        return view
    }()
    private let sortView = UIView()
    private lazy var sortButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
        return view
    }()
    private let startView = UIView()
    private let startLabel = {
        let view = UILabel()
        view.font = Constant.Font.bold14
        view.text = "사진을 검색해보세요."
        view.textAlignment = .center
        return view
    }()
    private let resultView = UIView()
    private lazy var resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setLayout())
    private let noResultView = UIView()
    private let noResultLabel = {
        let view = UILabel()
        view.font = Constant.Font.bold14
        view.text = "검색 결과가 없습니다."
        view.textAlignment = .center
        return view
    }()
    
    private var list: SearchResult = SearchResult(total: 0, total_pages: 0, results: []) {
        didSet {
            if list.results.count == 0 {
                startView.isHidden = true
                sortButton.isHidden = true
                resultView.isHidden = true
                noResultView.isHidden = false
            } else {
                startView.isHidden = true
                sortButton.isHidden = false
                resultView.isHidden = false
                noResultView.isHidden = true
            }
        }
    }
    private var imageView = UIImageView()
    private var query = ""
    private var page = 1
    private var sort = SearchSort.relevant
    
    private var repository = LikedItemRepository()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultCollectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        repository.getFileURL()
    }
    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(sortView)
        sortView.addSubview(sortButton)
        view.addSubview(startView)
        startView.addSubview(startLabel)
        view.addSubview(resultView)
        resultView.addSubview(resultCollectionView)
        view.addSubview(noResultView)
        noResultView.addSubview(noResultLabel)
    }
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        sortView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        sortButton.snp.makeConstraints { make in
            make.centerY.equalTo(sortView.snp.centerY)
            make.trailing.equalTo(sortView.snp.trailing).inset(8)
            make.height.equalTo(36)
        }
        startView.snp.makeConstraints { make in
            make.top.equalTo(sortView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        startLabel.snp.makeConstraints { make in
            make.center.equalTo(startView.snp.center)
        }
        resultView.snp.makeConstraints { make in
            make.top.equalTo(sortView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        resultCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(resultView.safeAreaLayoutGuide)
        }
        noResultView.snp.makeConstraints { make in
            make.top.equalTo(sortView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        noResultLabel.snp.makeConstraints { make in
            make.center.equalTo(noResultView.snp.center)
        }
    }
    override func configureView() {
        super.configureView()
        navigationItem.title = "SEARCH PHOTO"
        sortButton.configuration = .sortButtonStyle(title: SearchSort.relevant.sortString)
        sortButton.layer.shadowColor = Constant.Color.gray.cgColor
        sortButton.layer.shadowOpacity = 0.5
        sortButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        sortButton.layer.masksToBounds = false
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        resultCollectionView.prefetchDataSource = self
        resultCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
        startView.isHidden = false
        sortButton.isHidden = true
        resultView.isHidden = true
        noResultView.isHidden = true
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
    private func searchRequest(query: String, sort: SearchSort) {
        NetworkManager.shared.apiRequest(api: .search(query: query, page: page, sort: sort), model: SearchResult.self) { value, error in
            if let error = error {
                self.showAlert(title: "데이터를 불러오는데 실패했습니다.", message: "", ok: "확인") {
                    print("error")
                }
            }
            guard let value = value else {
                print("error nil, value nil")
                return
            }
            if self.page == 1 {
                self.list = value
            } else {
                self.list.results.append(contentsOf: value.results)
            }
            self.resultCollectionView.reloadData()
            
            if self.page == 1 {
                guard value.total != 0 else { return }
                self.resultCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    @objc private func sortButtonClicked(){
        if let sort = sortButton.configuration?.title{
            print(sort)
            if sort == SearchSort.latest.sortString{
                sortButton.configuration = .sortButtonStyle(title: SearchSort.relevant.sortString)
                searchRequest(query: query, sort: .relevant)
                self.sort = .relevant
                self.page = 1
            } else if sort == SearchSort.relevant.sortString {
                sortButton.configuration = .sortButtonStyle(title: SearchSort.latest.sortString)
                searchRequest(query: query, sort: .latest)
                self.sort = .latest
                self.page = 1
            }
        }
    }
    
    @objc private func likeButtonClicked(sender: UIButton) {
        let photo = list.results[sender.tag]
        let likedItem = LikedItem(id: photo.id, image: photo.urls.small, width: photo.width, height: photo.height, regDate: Date(), createdDate: photo.created_at, photographerName: photo.user.name, photographerProfile: photo.user.profile_image?.small)
        if repository.isLiked(id: photo.id) {
            FileService.removeImageFromDocument(filename: "\(photo.id)")
            repository.deleteItem(id: photo.id)
        } else {
            FileService.saveImageToDocument(image: photo.urls.small, filename: "\(photo.id)")
            repository.createItem(likedItem)
        }
        resultCollectionView.reloadItems(at: [IndexPath(item: sender.tag, section: 0)])
    }
}
 
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        page = 1
        searchRequest(query: text, sort: .relevant)
        sortButton.configuration = .sortButtonStyle(title: SearchSort.relevant.sortString)
        query = text
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text.isEmpty {
            startView.isHidden = false
            sortButton.isHidden = true
            resultView.isHidden = true
            noResultView.isHidden = true
        }
    }

}
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.results.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell()}
        let data = list.results[indexPath.item]
        cell.configureCell(data: data)
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath)
        let vc = DetailViewController()
        vc.viewModel.inputPhoto.value = list.results[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        for indexPath in indexPaths {
            if list.results.count - 4 == indexPath.item && list.total_pages > page {
                page += 1
                searchRequest(query: query, sort: sort)
            }
        }
    }
}
