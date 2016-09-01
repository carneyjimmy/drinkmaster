//
//  Bar.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/3/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import Foundation


struct Bar{
    
    var id: Int
    var name: String?
    var distance: Double?
    var wait: Int
    
    init(id: Int, name: String, distance: Double, wait: Int){
        self.id = id
        self.name = name
        self.distance = distance
        self.wait = wait
    }
    
}