//
//  BaseViewController.swift
//  PickPic
//
//  Created by 여성은 on 7/23/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function,"Base")
        configureHierarchy()
        configureLayout()
        configureView()
    }
    func configureHierarchy() {
        print(#function,"Base")
    }
    func configureLayout() {
        print(#function,"Base")
        
    }
    func configureView() {
        print(#function,"Base")
        view.backgroundColor = .systemBackground
    }
    func setNavBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
        backButton.tintColor = Constant.Color.black
        navigationItem.leftBarButtonItem = backButton
    }
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
