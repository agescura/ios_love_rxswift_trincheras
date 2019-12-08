//
//  RxArchTests.swift
//  RxArchTests
//
//  Created by Albert Gil Escura on 18-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import XCTest
@testable import RxArch
import RxTest
import RxSwift

class ListViewModelTests: XCTestCase {
    
    // MARK: - System Under Test
    
    var sut: ListViewModel!

    // MARK: RxTest
    
    let scheduler = TestScheduler(initialClock: 0)
    let bag = DisposeBag()
    
    // MARK: Mocks
    
    var mockUseCase: MockUseCase!
    
    override func setUp() {
        mockUseCase = MockUseCase(scheduler: scheduler)
        
        sut = ListViewModel(type: .completed, useCase: mockUseCase)
    }
    
    override func tearDown() {}
    
    // MARK: Tests
    
    func test_todosHas1Value_titleShowHay1Todos() {
        let type = scheduler.createObserver(String.self)
        
        sut.title
            .drive(type)
            .disposed(by: bag)
        
        scheduler.start()
        
        XCTAssertEqual(type.events, [
            .next(10, "Hay 2 Todos"),
            .next(20, "Ojo, no tienes conexión"),
            .next(30, "Ojo, no tienes conexión"),
            .completed(30)
            ])
    }
    
    func test_realmTodosHasValues_todosCompletedEmitted() {
        let type = scheduler.createObserver([Todo].self)
        
        sut.todos
            .drive(type)
            .disposed(by: bag)
        
        scheduler.start()
        
        let expectation: [Recorded<Event<[Todo]>>] = [
            .next(10, [Todo(id: 0, userId: 0, title: "title", completed: true),
                       Todo(id: 1, userId: 0, title: "title", completed: false)]),
            .next(20, []),
            .next(30, []),
            .completed(30)
        ]
        
        XCTAssertEqual("\(type.events)", "\(expectation)")
    }
    
    // MARK: Mocks
    
    class MockUseCase: UseCase {
        
        var scheduler: TestScheduler!
        
        init(scheduler: TestScheduler) {
            super.init(alamofire: AlamofireProvider(service: AlamofireService()),
                       realm: RealmProvider(service: RealmService()),
                       reachability: ReachabilityProvider(service: ReachabilityService()))
            self.scheduler = scheduler
        }
        
        override func todos(with type: TodoType) -> Observable<[Todo]> {
            return scheduler.createColdObservable([
                .next(10, [
                    Todo(id: 0, userId: 0, title: "title", completed: true),
                    Todo(id: 1, userId: 0, title: "title", completed: false),
                    ]),
                .next(20, []),
                .error(30, Failure.unkown)
                ])
                .asObservable()
        }
    }
}
