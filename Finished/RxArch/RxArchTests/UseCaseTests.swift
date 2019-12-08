//
//  UseCaseTests.swift
//  RxArchTests
//
//  Created by Albert Gil Escura on 22-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import XCTest
@testable import RxArch
import RxTest
import RxSwift

class UseCaseTests: XCTestCase {

    // MARK: - System Under Test
    
    var sut: UseCase!
    
    // MARK: RxTest
    
    let scheduler = TestScheduler(initialClock: 0)
    let bag = DisposeBag()
    
    // MARK: Mocks
    
    var mockAlamofire: AlamofireProvider!
    var mockRealm: RealmProvider!
    var mockReachability: ReachabilityProvider!
    
    override func setUp() {
        mockAlamofire = MockAlamofire(scheduler: scheduler)
        mockRealm = MockRealm(scheduler: scheduler)
        mockReachability = MockReachability(scheduler: scheduler)
        
        sut = UseCase(alamofire: mockAlamofire, realm: mockRealm, reachability: mockReachability)
    }
    
    override func tearDown() {}
    
    // MARK: Tests
    
    func test_whenTodosCalled_useCaseTodosEmitted() {
        let type = scheduler.createObserver([Todo].self)
        
        sut.todos(with: .internet)
            .bind(to: type)
            .disposed(by: bag)
        
        scheduler.start()
        
        let expectation: [Recorded<Event<[Todo]>>] = [
            .next(10, []),
            .next(40, [
                Todo(id: 0, userId: 0, title: "title", completed: true),
                Todo(id: 1, userId: 0, title: "title", completed: false)])
        ]
        
        XCTAssertEqual("\(type.events)", "\(expectation)")
    }
    
    // MARK: Mocks
    
    class MockAlamofire: AlamofireProvider {
        var scheduler: TestScheduler!
        
        init(scheduler: TestScheduler) {
            super.init(service: AlamofireService())
            self.scheduler = scheduler
        }
        
        override func todos() -> Observable<[Todo]> {
            return scheduler.createColdObservable([
                .next(10, [
                    Todo(id: 0, userId: 0, title: "title", completed: true),
                    Todo(id: 1, userId: 0, title: "title", completed: false)])
                ])
                .asObservable()
        }
    }
    
    class MockRealm: RealmProvider {
        var scheduler: TestScheduler!
        
        init(scheduler: TestScheduler) {
            super.init(service: RealmService())
            self.scheduler = scheduler
        }
        
        override func save(todos: [Todo]) -> Observable<[Todo]> {
            return scheduler.createColdObservable([
                .next(10, [
                    Todo(id: 0, userId: 0, title: "title", completed: true),
                    Todo(id: 1, userId: 0, title: "title", completed: false)])
                ])
                .asObservable()
        }
    }
    
    class MockReachability: ReachabilityProvider {
        var scheduler: TestScheduler!
        
        init(scheduler: TestScheduler) {
            super.init(service: ReachabilityService())
            self.scheduler = scheduler
        }
        
        override var status: Observable<Connection> {
            get {
                return scheduler.createColdObservable([
                    .next(10, .none),
                    .next(20, .wifi)
                    ])
                    .asObservable()
            } set {}
        }
    }

}
