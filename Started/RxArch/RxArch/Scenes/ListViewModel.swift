//
//  ListViewModel.swift
//  RxArch
//
//  Created by Albert Gil Escura on 17-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ListViewModelProtocol {
    var todos: Driver<[Todo]> { get set }
    var title: Driver<String> { get set }
}

final class ListViewModel: ListViewModelProtocol {
    
    // MARK: Private properties
    
    private let type: TodoType
    private let useCase: UseCaseProtocol
    
    // MARK: Init
    
    init(type: TodoType, useCase: UseCaseProtocol) {
        self.useCase = useCase
        self.type = type
    }
    
    lazy var todos = self.useCase
            .todos(with: type)
            .asDriver(onErrorJustReturn: [])
    
    lazy var title = todos
        .map { $0.count > 0 ? "Hay \($0.count) Todos" : "Ojo, no tienes conexión" }
}
