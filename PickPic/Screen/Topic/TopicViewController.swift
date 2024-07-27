//
//  TopicViewController.swift
//  PickPic
//
//  Created by 여성은 on 7/22/24.
//

import UIKit
import SnapKit

final class TopicViewController: BaseViewController {
    static let headerElementKind = "header-element-kind"
    private enum TopicId: Int, CaseIterable {
        case goldenHour = 0
        case businessWork
        case architectureInterior
        
        var id: String {
            switch self {
            case .goldenHour:
                "golden-hour"
            case .businessWork:
                "business-work"
            case .architectureInterior:
                "architecture-interior"
            }
        }
        var description: String {
            switch self {
            case .goldenHour:
                "골든 아워"
            case .businessWork:
                "비즈니스 및 업무"
            case .architectureInterior:
                "건축 및 인테리어"
            }
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.delegate = self
        return collectionView
    }()
    private var dataSource: UICollectionViewDiffableDataSource<TopicId, Photo>!
    private var list: [[Photo]] = [[],[],[]]
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function,"TopicViewController")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
        navigationItem.largeTitleDisplayMode = .always
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function,"TopicViewController")
        fetchData()
        configureDataSource()
        updateSnapshot()

    }
    override func configureHierarchy() {
        print(#function,"TopicViewController")
        view.addSubview(collectionView)
    }
    override func configureLayout() {
        print(#function,"TopicViewController")
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        super.configureView()
        print(#function,"TopicViewController")
        navigationItem.title = "OUR TOPIC"
        
        let profileButton = UIBarButtonItem(customView: TestView())
        navigationItem.rightBarButtonItem = profileButton
        guard let view = profileButton.customView as? TestView else { return }
        view.button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc func buttonClicked() {
        print("클릭ㅃ!")
    }
    private func fetchData() {
        NetworkManager.shared.apiRequest(api: .topic(topicId: TopicId.goldenHour.id), model: [Photo].self) { value, error in
            if error != nil {
                print("error")
            }
            guard let value = value else {
                print("error nil, value nil")
                return
            }
            self.list[TopicId.goldenHour.rawValue] = value
            self.updateSnapshot()
        }
        NetworkManager.shared.apiRequest(api: .topic(topicId: TopicId.businessWork.id), model: [Photo].self) { value, error in
            if error != nil {
                print("error")
            }
            guard let value = value else {
                print("error nil, value nil")
                return
            }
            self.list[TopicId.businessWork.rawValue] = value
            self.updateSnapshot()
        }
        NetworkManager.shared.apiRequest(api: .topic(topicId: TopicId.architectureInterior.id), model: [Photo].self) { value, error in
            if error != nil {
                print("error")
            }
            guard let value = value else {
                print("error nil, value nil")
                return
            }
            self.list[TopicId.architectureInterior.rawValue] = value
            self.updateSnapshot()
        }
    }
}
extension TopicViewController {
    func  createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            guard let sectionKind = TopicId(rawValue: sectionIndex) else { fatalError("unknown section kind") }
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.4))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)), elementKind: TopicViewController.headerElementKind, alignment: .top)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 0)
            section.interGroupSpacing = 8
            section.boundarySupplementaryItems = [sectionHeader]
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        }, configuration: config)
        return layout
    }
    
    private func topicCellRegistration() -> UICollectionView.CellRegistration<TopicCollectionViewCell, Photo> {
        return UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            cell.backgroundColor = .clear
        }
    }
    private func configureDataSource() {
        
        let cellRegistration = topicCellRegistration()
        
        dataSource = UICollectionViewDiffableDataSource<TopicId, Photo>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
            print("indexPath", indexPath)
            print("itemIdentifier", itemIdentifier)
            cell.configureUI(data: itemIdentifier)
            
            return cell
        })
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView> (elementKind: TopicViewController.headerElementKind) { supplementaryView, elementKind, indexPath in
            supplementaryView.label.text = TopicId.allCases[indexPath.section].description
        }
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
    }
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<TopicId, Photo>()
        snapshot.appendSections(TopicId.allCases)
        snapshot.appendItems(list[TopicId.goldenHour.rawValue], toSection: .goldenHour)
        snapshot.appendItems(list[TopicId.businessWork.rawValue], toSection: .businessWork)
        snapshot.appendItems(list[TopicId.architectureInterior.rawValue], toSection: .architectureInterior)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
extension TopicViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath)
        let vc = DetailViewController()
        vc.viewModel.inputPhoto.value = list[indexPath.section][ indexPath.item]
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.pushViewController(vc, animated: true)
    }
}
