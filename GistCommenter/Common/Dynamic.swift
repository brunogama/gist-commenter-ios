//
//  Dynamic.swift
//  BrewOrama
//
//  Created Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

internal class Dynamic<T> {
    typealias Listener = (T) -> Void

    private(set) var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(self.value)
    }
}
