//
//  RealmTodo.swift
//  RxArch
//
//  Created by Albert Gil Escura on 17-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmTodo: Object {
    @objc dynamic var id = 0
    @objc dynamic var userId = 0
    @objc dynamic var title = ""
    @objc dynamic var completed = false
    
    convenience init(model: Todo) {
        self.init()
        
        self.id = model.id
        self.userId = model.userId
        self.title = model.title
        self.completed = model.completed
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
