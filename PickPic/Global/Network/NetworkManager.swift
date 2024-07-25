//
//  NetworkManager.swift
//  PickPic
//
//  Created by 여성은 on 7/23/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    func apiRequest<T: Decodable>(api: PhotoRequest, model: T.Type, completionHandler: @escaping (T?,Error?) -> Void) {
        guard let url = api.endpoint else { return }
        AF.request(url,
                   parameters: api.parameter).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
   

}
