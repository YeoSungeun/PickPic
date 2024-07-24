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
    private let sortButton = {
        let view = UIButton()
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
    
    private var list: [Photo] = [] {
        didSet {
            if list.count == 0 {
                startView.isHidden = true
                resultView.isHidden = true
                noResultView.isHidden = false
            } else {
                startView.isHidden = true
                resultView.isHidden = false
                noResultView.isHidden = true
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            make.height.equalTo(40)
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
        sortButton.configuration = .sortButtonStyle(title: SearchSort.latest.sortString)
        sortButton.layer.shadowColor = Constant.Color.gray.cgColor
        sortButton.layer.shadowOpacity = 0.5
        sortButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        sortButton.layer.masksToBounds = false
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        resultCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
        startView.isHidden = false
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
    private func searchRequest(query: String) {
        NetworkManager.shared.apiRequest(api: .search(query: query), model: SearchResult.self) { value, error in
            if let error = error {
                print("error")
            }
            guard let value = value else {
                print("error nil, value nil")
                return
            }
            self.list = value.results
            self.resultCollectionView.reloadData()
        }
    }
}
 
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        searchRequest(query: text)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text.isEmpty {
            startView.isHidden = false
            resultView.isHidden = true
            noResultView.isHidden = true
        }
    }

}
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell()}
        let data = list[indexPath.item]
        cell.configureCell(data: data)
        return cell
    }
    
    
}
