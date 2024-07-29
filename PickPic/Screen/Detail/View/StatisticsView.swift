//
//  StatisticsView.swift
//  PickPic
//
//  Created by 여성은 on 7/26/24.
//

import UIKit
import SnapKit

final class StatisticsDetailView: UIView {
    let title = {
        let view = UILabel()
        view.font = Constant.Font.bold14
        return view
    }()
    let content = {
        let view = UILabel()
        view.font = Constant.Font.regular14
        view.textAlignment = .right
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        addSubview(content)
        title.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.safeAreaLayoutGuide)
        }
        content.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        self.backgroundColor = .systemBackground
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class StatisticsView: BaseView {
    let contentsView = UIView()
    let infoLabel = {
        let view = UILabel()
        view.text = "정보"
        view.font = Constant.Font.bold16
        return view
    }()
    let stackView = UIStackView()
    let sizeView = {
        let view = StatisticsDetailView()
        view.title.text = "크기"
        return view
    }()
    let viewsView = {
        let view = StatisticsDetailView()
        view.title.text = "조회수"
        return view
    }()
    let downloadView = {
        let view = StatisticsDetailView()
        view.title.text = "다운로드"
        return view
    }()
    override func configureHierarchy() {
        addSubview(contentsView)
        contentsView.addSubview(infoLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(sizeView)
        stackView.addArrangedSubview(viewsView)
        stackView.addArrangedSubview(downloadView)
    }
    override func configureLayout() {
        contentsView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(120)
        }
        infoLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(contentsView.safeAreaLayoutGuide)
        }
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(contentsView.snp.trailing)
            make.verticalEdges.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        super.configureView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
    }
}



