//
//  ComponentOption.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/8/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import Foundation


class ComponentOption{
    
    var id: Int?
    var name: String?
    var price: Double?
    var isDefault: Bool
    var selected: Bool
    
    init(id: Int, name: String, price: Double, isDefault: Bool){
        self.id = id
        self.name = name
        self.price = price
        self.isDefault = isDefault
        if (isDefault){
            self.selected = true
        }
        else {
            self.selected = false
        }
    }
    
}