//
//  Category.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/8/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import Foundation

class Category{
    
    var id: Int
    var name: String?
    var primary: Bool
    
    init(id: Int, name: String, primary: Bool){
        
        self.id = id
        self.name = name
        self.primary = primary
        
    }
    
}