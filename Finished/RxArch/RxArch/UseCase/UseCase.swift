//
//  UseCase.swift
//  RxArch
//
//  Created by Albert Gil Escura on 17-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import Foundation
import RxSwift

protocol UseCaseProtocol {
    func todos(with type: TodoType) -> Observable<[Todo]>
}

class UseCase: UseCaseProtocol {
    
    // MARK: Providers
    
    private let alamofire: AlamofireProvider
    private let realm: RealmProvider
    private let reachability: ReachabilityProviderProtocol
    
    
    // MARK: Init
    
    init(alamofire: AlamofireProvider, realm: RealmProvider, reachability: ReachabilityProviderProtocol) {
        self.realm = realm
        self.alamofire = alamofire
        self.reachability = reachability
    }
    
    // MARK: Public Methods
    
    func todos(with type: TodoType) -> Observable<[Todo]> {
        switch type {
        case .internet:
            return reachability.status
                .flatMap { [unowned self] status -> Observable<[Todo]> in
                    switch status {
                    case .none:
                        return .just([])
                    default:
                        return self.alamofire.todos()
                            .flatMap { [unowned self] in self.save($0) }
                    }
                }
        case .completed:
            return realm.todos()
                .map { $0.filter { $0.completed } }
        case .incompleted:
            return realm.todos()
                .map { $0.filter { !$0.completed } }
        }
    }
    
    // MARK: Private Methods
    
    private func realmTodos() -> Observable<[Todo]> {
        return realm.todos()
    }
    
    private func save(_ todos: [Todo]) -> Observable<[Todo]> {
        return realm.save(todos: todos)
    }
}
