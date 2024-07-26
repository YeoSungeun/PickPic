//
//  DetailViewModel.swift
//  PickPic
//
//  Created by 여성은 on 7/26/24.
//

import Foundation

final class DetailViewModel {
    enum PhotoType {
        case Photo
        case LikedItem
    }
    
    var inputPhoto: Observable<Photo?> = Observable(nil)
    var inputLikedItem: Observable<LikedItem?> = Observable(nil)
    var inputScreenWidth: Observable<CGFloat> = Observable(0)
    var inputLikedButtonClicked: Observable<Void?> = Observable(nil)
    
    var photoType: PhotoType = .Photo
    var outputID = Observable("")
    var outputPhotoUrl = Observable("")
    var outputCreatedAt = Observable("")
    var outputViews = Observable(0)
    var outputDownloads = Observable(0)
    var outputIsLiked = Observable(false)
    var outputSize = Observable((width: 0, height: 0))
    var outputConstraintHeight = Observable(0.0)
    var outputUserName = Observable("")
    var outputUserProfileImage: Observable<String?> = Observable(nil)
    var outputAlert: Observable<Void?> = Observable(nil)
    
    
    let repository = LikedItemRepository()
    
    init() {
        print("========DetailViewModel Init========")
        inputPhoto.bind { [weak self] value in
            self?.getDetailPhoto(data: value)
        }
        inputLikedItem.bind { [weak self] value in
            self?.getDetailLikedItem(data: value)
        }
        inputLikedButtonClicked.bind { [weak self] _ in
            self?.toggleLikedButton(id: self?.outputID.value ?? "")
        }
        inputScreenWidth.bind { [weak self] value in
            print(value,"inputScreenWidth!!!!!!")
            self?.calculateHeight(width: self?.outputSize.value.width ?? 0, height: self?.outputSize.value.height ?? 0)
        }
    }
    deinit {
        print("========DetailViewModel Deinit========")
    }
    func getDetailPhoto(data: Photo?) {
        guard let photo = data else { return }
        photoType = .Photo
        outputID.value = photo.id
        outputID.bind { [weak self] id in
            self?.getStatistics(id: id)
            self?.validIsLiked(id: id)
        }
        outputPhotoUrl.value = photo.urls.small
        //TODO: Dateformatter
        outputCreatedAt.value = photo.created_at
        print(outputCreatedAt.value, "outputcreate=============")
        outputSize.value = (photo.width, photo.height)
        outputSize.bind { [weak self] (width, height) in
            self?.calculateHeight(width: width, height: height)
        }
        outputUserName.value = photo.user.name
        outputUserProfileImage.value = photo.user.profile_image?.small
    }
    func getDetailLikedItem(data: LikedItem?) {
        guard let photo = data else { return }
        photoType = .Photo
        outputID.value = photo.id
        outputID.bind { [weak self] id in
            self?.getStatistics(id: id)
            self?.validIsLiked(id: id)
        }
        outputPhotoUrl.value = photo.image
        //TODO: Dateformatter
        outputCreatedAt.value = photo.createdDate
        print(outputCreatedAt.value, "outputcreate=============")
        outputSize.value = (photo.width, photo.height)
        outputSize.bind { [weak self] (width, height) in
            self?.calculateHeight(width: width, height: height)
        }
        outputUserName.value = photo.photographerName
        outputUserProfileImage.value = photo.photographerProfile
    }
    func getStatistics(id: String) {
        NetworkManager.shared.apiRequest(api: .detail(id: id), model: PhotoDetail.self) { value, error in
            if let error = error {
                self.outputAlert.value = ()
                return
            }
            guard let value = value else { return }
            self.outputViews.value = value.views.total
            self.outputDownloads.value = value.downloads.total
        }
    }
    func validIsLiked(id: String) {
        if repository.isLiked(id: id) {
            self.outputIsLiked.value = true
        } else {
            self.outputIsLiked.value = false
        }
    }
    func toggleLikedButton(id: String) {
        if repository.isLiked(id: id) {
            FileService.removeImageFromDocument(filename: "\(id)")
            repository.deleteItem(id: id)
            self.outputIsLiked.value = false
        } else {
            if photoType == .Photo {
                guard let data = inputPhoto.value else { return }
                let likedItem = LikedItem(id: data.id, image: data.urls.small, width: data.width, height: data.height, regDate: Date(), createdDate: data.created_at, photographerName: data.user.name, photographerProfile: data.user.profile_image?.small)
                FileService.saveImageToDocument(image: data.urls.small, filename: data.id)
                repository.createItem(likedItem)
            } else if photoType == .LikedItem {
                guard let data = inputLikedItem.value else { return }
                FileService.saveImageToDocument(image: data.image, filename: data.id)
                repository.createItem(data)
            }
            self.outputIsLiked.value = true
        }
    }
    func calculateHeight(width: Int, height: Int) {
        outputConstraintHeight.value = Double(inputScreenWidth.value) * Double(height) / Double(width)
        print(Double(inputScreenWidth.value), Double(height), outputConstraintHeight.value,"!!!!!!!!!")
    }
}
