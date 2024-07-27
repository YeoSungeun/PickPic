//
//  FileService.swift
//  PickPic
//
//  Created by 여성은 on 7/27/24.
//

import UIKit

class FileService {
    
    static func saveImageToDocument(image: String, filename: String) {
        var imageView = UIImageView()
        if let imageURL = URL(string: image) {
            imageView.kf.setImage(with: imageURL)
        }

        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        print("========documentDirectory===========", documentDirectory)
        
        //이미지를 저장할 경로(파일명) 지정
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        print("========fileURL===========", fileURL)
        //이미지 압축
        guard let data = imageView.image?.jpegData(compressionQuality: 0.5) else { return }
        
        //이미지 파일 저장
        do {
            try data.write(to: fileURL)
            print("===========file save sucess=========")
        } catch {
            print("===========file save error=========", error)
        }
    }
    
    static func loadImageToDocument(filename: String) -> UIImage? {
        
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        //이 경로에 실제로 파일이 존재하는 지 확인
        if #available(iOS 16.0, *) {
            if FileManager.default.fileExists(atPath: fileURL.path()) {
                return UIImage(contentsOfFile: fileURL.path())
            } else {
                return UIImage(systemName: "star.fill")
            }
        } else {
            // Fallback on earlier versions
            if FileManager.default.fileExists(atPath: fileURL.path) {
                return UIImage(contentsOfFile: fileURL.path)
            } else {
                return UIImage(systemName: "star.fill")
            }
        }
        
    }
    
    static func removeImageFromDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if #available(iOS 16.0, *) {
            if FileManager.default.fileExists(atPath: fileURL.path()) {
                
                do {
                    // 지워지는동안 다른 변수(가져오거나 변경)가 없도록 do try catch문을 사용
                    try FileManager.default.removeItem(atPath: fileURL.path())
                } catch {
                    print("file remove error", error)
                }
                
            } else {
                print("file no exist")
            }
        } else {
            // Fallback on earlier versions
            if FileManager.default.fileExists(atPath: fileURL.path) {
                
                do {
                    // 지워지는동안 다른 변수(가져오거나 변경)가 없도록 do try catch문을 사용
                    try FileManager.default.removeItem(atPath: fileURL.path)
                } catch {
                    print("file remove error", error)
                }
                
            } else {
                print("file no exist")
            }
        }
        
    }
}

