//
//  ItemVariation.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/6/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import Foundation


class ItemVariation{
    
    var id: Int?
    var name: String?
    var price: Double?
    var selected: Bool
    
    init(id: Int, name: String, price: Double){
        self.id = id
        self.name = name
        self.price = price
        self.selected = false
    }
    
}