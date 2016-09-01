//
//  Tip.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/7/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import Foundation


struct Tip{
    
    var percent: Int?
    var value: Double?
    
    init(percent: Int, value: Double){
        self.percent = percent
        self.value = value
    }
    
}