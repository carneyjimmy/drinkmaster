//
//  Item.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/6/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import Foundation

class Item{
    
    var id: Int
    var categories: [Category]
    var name: String
    var ozPrice: Double
    
    init(id: Int, categories: [Category], name: String, ozPrice: Double){
        self.id = id
        self.categories = categories
        self.name = name
        self.ozPrice = ozPrice
    }

}