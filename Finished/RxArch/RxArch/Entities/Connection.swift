//
//  Connection.swift
//  RxArch
//
//  Created by Albert Gil Escura on 18-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import Foundation
import Reachability

enum Connection {
    case none
    case wifi
    case cellular
    
    init(status: Reachability.Connection) {
        switch status {
        case .cellular:
            self = .cellular
        case .wifi:
            self = .wifi
        case .none:
            self = .none
        }
    }
}
