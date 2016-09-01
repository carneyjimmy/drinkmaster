//
//  OrderInfo.swift
//  Drink Master 8000
//
//  Created by Tess Putinsky on 11/5/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import Foundation

struct OrderInfo{
    
    var date: String?
    var name: String?
    var total: Double?
    
    init(date: String, name: String, total: Double){
        
        self.date = date
        self.name = name
        self.total = total
        
    }
    
}