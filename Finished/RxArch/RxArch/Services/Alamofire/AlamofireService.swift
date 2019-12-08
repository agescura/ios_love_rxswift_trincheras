//
//  AlamofireService.swift
//  RxArch
//
//  Created by Albert Gil Escura on 17-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import UIKit
import Alamofire
import RxAlamofire
import RxSwift

protocol AlamofireServiceProtocol {
    func todos() -> Observable<[AlamofireTodo]>
}

class AlamofireService: AlamofireServiceProtocol {
    
    // MARK: Service
    
    private let manager = Alamofire.SessionManager.default
    
    // MARK: Public Methods
    
    func todos() -> Observable<[AlamofireTodo]> {
        return get("https://jsonplaceholder.typicode.com/todos")
            .mapArray(type: AlamofireTodo.self)
    }
    
    // MARK: Private methods
    
    fileprivate func get(_ path: String) -> Observable<Data> {
        return manager.rx
            .data(.get, path)
            .observeOn(MainScheduler.instance)
    }
}
