//
//  RealmProvider.swift
//  RxArch
//
//  Created by Albert Gil Escura on 17-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import Foundation
import RxSwift

protocol RealmProviderProtocol {
    func todos() -> Observable<[Todo]>
    func save(todos: [Todo]) -> Observable<[Todo]>
}

class RealmProvider: RealmProviderProtocol {
    
    // MARK: Service
    
    private let service: RealmServiceProtocol
    
    // MARK: Init
    
    init(service: RealmServiceProtocol) {
        self.service = service
    }
    
    // MARK: Public Methods
    
    func todos() -> Observable<[Todo]> {
        return service
            .todos()
            .map { $0.map(Todo.init) }
            .catchErrorJustReturn([])
    }
    
    func save(todos: [Todo]) -> Observable<[Todo]> {
        return service
            .save(todos: todos.map { RealmTodo(model: $0) } )
            .map { $0.map(Todo.init) }
    }
}
