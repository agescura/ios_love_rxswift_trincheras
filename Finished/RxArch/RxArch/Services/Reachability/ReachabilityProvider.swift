//
//  ReachabilityProvider.swift
//  RxArch
//
//  Created by Albert Gil Escura on 18-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import Foundation
import RxSwift


protocol ReachabilityProviderProtocol {
    var status: Observable<Connection> { get set }
}

class ReachabilityProvider: ReachabilityProviderProtocol {
    
    // MARK: Service
    
    let service: ReachabilityServiceProtocol
    
    // MARK: Init
    
    init(service: ReachabilityServiceProtocol) {
        self.service = service
    }
    
    // MARK: Public Property
    
    lazy var status = service.status
        .map(Connection.init)
}
