//
//  String+Extension.swift
//  PickPic
//
//  Created by 여성은 on 7/27/24.
//

import UIKit

extension String {
    func creadtedDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else { return ""}
        dateFormatter.dateFormat = "yyyy년 M월 dd일 게시됨"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
