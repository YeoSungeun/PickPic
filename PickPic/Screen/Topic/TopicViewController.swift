//
//  TopicViewController.swift
//  PickPic
//
//  Created by 여성은 on 7/22/24.
//

import UIKit

class TopicViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function,"TopicViewController")
//        NetworkManager.shared.apiRequest(api: .topic(topicId: "golden-hour"), model: [Photo].self) { data, error in
//            if let error = error {
//                print(error)
//            } else {
//                guard let data = data else {
//                    return
//                }
//                print(data)
//            }
//        }
    }
    override func configureHierarchy() {
        super.configureHierarchy()
        print(#function,"TopicViewController")
    }
    override func configureLayout() {
        super.configureLayout()
        print(#function,"TopicViewController")
    }
    override func configureView() {
        super.configureView()
        print(#function,"TopicViewController")
    }
}
