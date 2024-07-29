//
//  ProfileSettingViewModel.swift
//  PickPic
//
//  Created by 여성은 on 7/27/24.
//

import Foundation

final class ProfileSettingViewModel {
    private enum VaildationError: Error {
        case textCountCondition
        case isSpecialChar
        case isNumChar
        
        var errorText: String {
            switch self {
            case .textCountCondition:
                return "2글자 이상 10글자 미만으로 설정해주세요"
            case .isSpecialChar:
                return "닉네임에 @, #, $, % 는 포함할 수 없어요"
            case .isNumChar:
                return "닉네임에 숫자는 포함할 수 없어요"
            }
        }
    }
    
    var inputViewType: Observable<ViewType?> = Observable(nil)
    var inputMBTIStatus: Observable<[Bool]> = Observable([false, false, false, false])
    var inputProfileClicked: Observable<Void?> = Observable(nil)
    var inputNickname: Observable<String?> = Observable(nil)
    var inputMBTIButtonIndex: Observable<Int?> = Observable(nil)
    var inputDoneButtonClicked: Observable<Void?> = Observable(nil)
    var inputSaveButtonsClicked: Observable<Void?> = Observable(nil)
    var inputWithdraButtonClicked: Observable<Void?> = Observable(nil)
    var inputClosure: Observable<((String) -> Void)?> = Observable(nil)
    
    var outputViewType: Observable<ViewType?> = Observable(nil)
    var outputProfileName = Observable("profile_0")
    var outputVC: Observable<BaseViewController?> = Observable(nil)
    var outputNickName: Observable<String?>  = Observable("")
    var outputNicknameValidComent = Observable("")
    var outputNicknameValid = Observable(false)
    var outputList: Observable<[MBTIInfo]?> = Observable(nil)
    var outputMBTIStatus = Observable(false)
    var outputDoneButtonStatus = Observable(false)
    
    let repository = UserInfoRepository()
    let likeItemRepository = LikedItemRepository()
    
    init() {
        inputViewType.bind { [weak self] type in
            if type == .setting {
                self?.setSetting()
            } else if type == .edit {
                self?.setEdit()
                
            }
        }
        inputProfileClicked.bind { [weak self] _ in
            let vc = ProfileImageSettingViewController()
            vc.profileName = self?.outputProfileName.value ?? "profile_0"
            vc.getProfileName = { [weak self] value in
                self?.outputProfileName.value = value
            }
            self?.outputVC.value = vc
        }
        inputNickname.bind { [weak self] value in
            self?.getNicknameStatus(nickname: value)
            self?.outputNickName.value = value
            self?.getDoneButtonValid()
        }
        inputMBTIButtonIndex.bind { [weak self] value in
            guard let value else { return }
            self?.checkMBTIStatus(index: value)
        }
        inputMBTIStatus.bind { [weak self] value in
            if value[0] && value[1] && value[2] && value[3] {
                self?.outputMBTIStatus.value = true
            } else {
                self?.outputMBTIStatus.value = false
            }
            self?.getDoneButtonValid()
        }
        inputDoneButtonClicked.bind { [weak self] _ in
            self?.saveUserInfo()
        }
        inputSaveButtonsClicked.bind { [weak self] _ in
            self?.saveUserInfo()
            self?.inputClosure.value?(self?.outputProfileName.value ?? "profile_0")
        }
        inputWithdraButtonClicked.bindLater { [weak self] _ in
            self?.withdrawUser()
        }
        outputNicknameValid.bind { [weak self] value in
            self?.getDoneButtonValid()
        }
        outputMBTIStatus.bind { [weak self] value in
            self?.getDoneButtonValid()
        }
        
    }
}
// 초기설정
extension ProfileSettingViewModel {
    func setSetting() {
        outputViewType.value = .setting
        outputProfileName.value = ProfileImage.allCases[Int.random(in: 0...ProfileImage.allCases.count - 1)].rawValue
        outputNickName.value = nil
        makeMBTIInfoList()
        
    }
    func setEdit() {
        outputViewType.value = .edit
        guard let userInfo = repository.fetchUserInfo() else { return }
        outputProfileName.value = userInfo.profileImageName ?? ""
        inputNickname.value = userInfo.nickname
//        outputMBTIStatus.value = true
        inputMBTIStatus.value = [true, true, true, true]
        makeMBTIInfoList()
    }
}
// nickname
extension ProfileSettingViewModel {
    func getNicknameStatus(nickname: String?) {
        guard let nickname = nickname else { return }
        do {
            let result = try vaildNickname(text: nickname)
            outputNicknameValidComent.value = "사용할 수 있는 닉네임이에요"
            outputNicknameValid.value = true
        } catch  VaildationError.textCountCondition {
            outputNicknameValidComent.value = VaildationError.textCountCondition.errorText
            outputNicknameValid.value  = false
        } catch  VaildationError.isSpecialChar {
            outputNicknameValidComent.value = VaildationError.isSpecialChar.errorText
            outputNicknameValid.value  = false
        } catch  VaildationError.isNumChar {
            outputNicknameValidComent.value = VaildationError.isNumChar.errorText
            outputNicknameValid.value  = false
        } catch {
            print("ERROR")
        }
 
    }
    
    func vaildNickname(text: String) throws -> Bool {
        var numCharSet: CharacterSet = CharacterSet()
        numCharSet.insert(charactersIn: "0123456789")
        var specialCharSet: CharacterSet = CharacterSet()
        specialCharSet.insert(charactersIn: "@#$%")
        
        guard text.count >= 2 && text.count <= 9 else {
            print("글자 수")
            throw VaildationError.textCountCondition
        }
        guard text.rangeOfCharacter(from: specialCharSet) == nil else {
            print("특수문자")
            throw VaildationError.isSpecialChar
        }
        guard text.rangeOfCharacter(from: numCharSet) == nil else {
            print("숫자")
            throw VaildationError.isNumChar
        }
        return true
    }
}
// mbti
extension ProfileSettingViewModel {
    func makeMBTIInfoList() {
        let mbtiList = MBTI.allCases
        let mbtiStatusList = repository.fetchMBTIStatusList()
        var list: [MBTIInfo] = []
        for i in 0...mbtiList.count-1 {
            list.append(MBTIInfo(mbti: mbtiList[i], isClicked: mbtiStatusList[i]))
        }
        outputList.value = list
        print(list,"=========MBTIInfo 받기!!!!===========")
    }
    func checkMBTIStatus(index: Int) {
        let mbti = MBTI(rawValue: index)
        switch mbti {
        case .E:
            changeMBTIValue(clicked: index, unclicked: index+4, mbtiStatusIndex: 0)
        case .S:
            changeMBTIValue(clicked: index, unclicked: index+4, mbtiStatusIndex: 1)
        case .T:
            changeMBTIValue(clicked: index, unclicked: index+4, mbtiStatusIndex: 2)
        case .J:
            changeMBTIValue(clicked: index, unclicked: index+4, mbtiStatusIndex: 3)
        case .I:
            changeMBTIValue(clicked: index, unclicked: index-4, mbtiStatusIndex: 0)
        case .N:
            changeMBTIValue(clicked: index, unclicked: index-4, mbtiStatusIndex: 1)
        case .F:
            changeMBTIValue(clicked: index, unclicked: index-4, mbtiStatusIndex: 2)
        case .P:
            changeMBTIValue(clicked: index, unclicked: index-4, mbtiStatusIndex: 3)
        case nil:
            print("mbti error")
        }
    }
 
    func changeMBTIValue(clicked: Int, unclicked: Int, mbtiStatusIndex: Int) {
        print(#function)
        if (outputList.value?[clicked].isClicked) == outputList.value?[unclicked].isClicked {
            outputList.value?[clicked].isClicked = true
            outputList.value?[unclicked].isClicked = false
            inputMBTIStatus.value[mbtiStatusIndex] = true
        } else { // ox xo
            //xo
            if outputList.value?[unclicked].isClicked == true {
                outputList.value?[unclicked].isClicked = false
                outputList.value?[clicked].isClicked = true
                inputMBTIStatus.value[mbtiStatusIndex] = true
            } else { // ox
                outputList.value?[clicked].isClicked = false
                inputMBTIStatus.value[mbtiStatusIndex] = false
            }
        }
        print("=====AFTER!!!!changeMBTIValue=\(outputList.value?[clicked].isClicked)=\(outputList.value?[unclicked].isClicked)=\(inputMBTIStatus.value[mbtiStatusIndex])=\(outputMBTIStatus.value)")
        getDoneButtonValid()
    }
}
extension ProfileSettingViewModel {
    func getDoneButtonValid() {
        print(#function)
        print("Before==nickname",self.outputNicknameValid.value,"mbti",self.outputMBTIStatus.value, "done",self.outputDoneButtonStatus.value)
        if self.outputMBTIStatus.value && self.outputNicknameValid.value {
            self.outputDoneButtonStatus.value = true
        } else {
            self.outputDoneButtonStatus.value = false
        }
        print("After === nickname",self.outputNicknameValid.value,"mbti",self.outputMBTIStatus.value, "done",self.outputDoneButtonStatus.value)
    }

    func saveUserInfo() {
        guard let mbtiList = outputList.value else { return }
        print("======mbtiList=-=====", mbtiList)
        repository.modifyProfile(nickname: outputNickName.value, profileImageName: outputProfileName.value,
                                 E: mbtiList[0].isClicked, S: mbtiList[1].isClicked, T: mbtiList[2].isClicked, J: mbtiList[3].isClicked, I: mbtiList[4].isClicked, N: mbtiList[5].isClicked, F: mbtiList[6].isClicked, P: mbtiList[7].isClicked)
    }
    func withdrawUser() {
        let idList = likeItemRepository.getPhotosId()
        for id in idList {
            guard let id = id else { return }
            FileService.removeImageFromDocument(filename: id)
        }
        repository.withDrawUser()
        //????
//        let user = UserInfo(id: "userID", E: false, S: false, T: false, J: false, I: false, N: false, F: false, P: false)
//        repository.createUserInfo(user)
    }
}

