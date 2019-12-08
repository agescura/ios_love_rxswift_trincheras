//
//  Todo.swift
//  RxArch
//
//  Created by Albert Gil Escura on 17-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import Foundation

struct Todo {
    let id: Int
    let userId: Int
    let title: String
    let completed: Bool
    
    init(id: Int, userId: Int, title: String, completed: Bool) {
        self.id = id
        self.userId = userId
        self.title = title
        self.completed = completed
    }
    
    init(alamofire: AlamofireTodo) {
        self.id = alamofire.id
        self.userId = alamofire.userId
        self.title = alamofire.title
        self.completed = alamofire.completed
    }
    
    init(realm: RealmTodo) {
        self.id = realm.id
        self.userId = realm.userId
        self.title = realm.title
        self.completed = realm.completed
    }
}
