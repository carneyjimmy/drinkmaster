//
//  Copyer.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 12/7/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import Foundation

protocol Copying {
    init(original: Self)
}

extension Copying {
    func copy() -> Self {
        return Self.init(original: self)
    }
}