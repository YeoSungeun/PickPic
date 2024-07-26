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
            print(self.value,"Observable value did Set")
            closure?(value)
        }
    }
    
    init(_ value: T) {
        print(value,"Observable init")
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        print(self.value,"Observable closure")
        closure(value)
        self.closure = closure
    }
    func bindLater(closure: @escaping (T) -> Void) {
        self.closure = closure
    }
}
