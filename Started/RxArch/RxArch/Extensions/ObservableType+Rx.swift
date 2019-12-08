//
//  ObservableType+Rx.swift
//  RxArch
//
//  Created by Albert Gil Escura on 17-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {
    func mapArray<T: Codable>(type: T.Type) -> Observable<[T]> {
        return flatMap { data -> Observable<[T]> in
            let responseTuple = data as? Data
            
            guard let jsonData = responseTuple else {
                throw NSError(
                    domain: "",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Could not decode object"]
                )
            }
            
            let decoder = JSONDecoder()
            let objects = try decoder.decode([T].self, from: jsonData)
            
            return Observable.just(objects)
        }
    }
}

