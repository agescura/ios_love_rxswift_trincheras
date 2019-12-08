//
//  ReachabilityService.swift
//  RxArch
//
//  Created by Albert Gil Escura on 18-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import Foundation
import RxSwift
import Reachability
import RxReachability

protocol ReachabilityServiceProtocol {
    var status: Observable<Reachability.Connection> { get set }
}

class ReachabilityService: ReachabilityServiceProtocol {
    
    // MARK: Private Property
    
    private let reachability = Reachability()!
    
    // MARK: Init
    
    init() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    // MARK: Public Property
    
    lazy var status: Observable<Reachability.Connection> = {
        return reachability.rx.status
            .startWith(reachability.connection)
            .distinctUntilChanged()
    }()
}
