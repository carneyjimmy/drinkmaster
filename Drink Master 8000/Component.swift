//
//  Component.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/6/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import Foundation

class Component{
    
    var id: Int
    var item: Item?
    var category: Category?
    var options: [ComponentOption]?
    var quantity: Double?
    var units: String?
    var onlyItem: Bool
    
    func getPrice() -> Double{
        if let q = quantity{
            return item!.ozPrice * q
        }
        else {
            if let opt = options{
                for o in opt{
                    if o.selected{
                        return o.price!
                    }
                }
            }
        }
        return 0.0
    }
    
    init(id: Int, item: Item?, category: Category?, quantity: Double?, units: String?, onlyItem: Bool){
        self.id = id
        self.item = item
        self.category = category
        self.quantity = quantity
        self.units = units
        self.onlyItem = onlyItem
    }
    
    init(id: Int, item: Item?, category: Category?, options: [ComponentOption]?, onlyItem: Bool){
        self.id = id
        self.item = item
        self.category = category
        self.options = options
        self.onlyItem = onlyItem
    }
    
}