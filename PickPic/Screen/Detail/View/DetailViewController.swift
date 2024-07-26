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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topInfoView.photographerProfileImageView.layoutIfNeeded()
        topInfoView.photographerProfileImageView.layer.cornerRadius = topInfoView.photographerProfileImageView.frame.height / 2
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
            make.width.equalTo(view.snp.width)
            make.height.equalTo(800)
        }
        statisticsView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.bottom.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        
    }
    override func configureView() {
        topInfoView.backgroundColor = .yellow
        imageView.backgroundColor = .green
    }
}

#if DEBUG
@available (iOS 17, *)
#Preview {
    DetailViewController()
}
#endif
