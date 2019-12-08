//
//  RealmService.swift
//  RxArch
//
//  Created by Albert Gil Escura on 17-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

protocol RealmServiceProtocol {
    @discardableResult
    func save(todos: [RealmTodo]) -> Observable<[RealmTodo]>
    @discardableResult
    func todos() -> Observable<[RealmTodo]>
}

class RealmService: RealmServiceProtocol {
    
    // MARK: Public Methods
    
    @discardableResult
    func save(todos: [RealmTodo]) -> Observable<[RealmTodo]> {
        let result = withRealm("creating todos") { realm -> Observable<[RealmTodo]> in
            try realm.write {
                realm.add(todos, update: .all)
            }
            return .just(todos)
        }
        return result ?? .just([])
    }
    
    @discardableResult
    func todos() -> Observable<[RealmTodo]> {
        let result = withRealm("getting todos") { realm -> Observable<[RealmTodo]> in
            return Observable
                .collection(from: realm.objects(RealmTodo.self)).map { $0.toArray() }
                .observeOn(MainScheduler.instance)
        }
        return result ?? .just([])
    }
    
    // MARK: Private Methods
    
    fileprivate func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
        do {
            var config = Realm.Configuration()
            config.deleteRealmIfMigrationNeeded = true
            
            let realm = try Realm(configuration: config)
            return try action(realm)
        } catch {
            return nil
        }
    }
}
