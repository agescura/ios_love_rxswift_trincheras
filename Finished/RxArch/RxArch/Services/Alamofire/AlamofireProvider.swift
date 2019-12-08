//
//  AlamofireProvider.swift
//  RxArch
//
//  Created by Albert Gil Escura on 17-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import Foundation
import RxSwift

protocol AlamofireProviderProtocol {
    func todos() -> Observable<[Todo]>
}

class AlamofireProvider: AlamofireProviderProtocol {

    // MARK: Service
    
    private let service: AlamofireServiceProtocol
    
    // MARK: Init
    
    init(service: AlamofireServiceProtocol) {
        self.service = service
    }
    
    // MARK: Public Methods
    
    func todos() -> Observable<[Todo]> {
        return service
            .todos()
            .map { $0.map(Todo.init) }
            .catchErrorJustReturn([])
    }
}
