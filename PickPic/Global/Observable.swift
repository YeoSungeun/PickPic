//
//  Observable.swift
//  PickPic
//
//  Created by 여성은 on 7/26/24.
//

import Foundation

final class Observable<T> {
    var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
    }
    func bindLater(closure: @escaping (T) -> Void) {
        self.closure = closure
    }
}
