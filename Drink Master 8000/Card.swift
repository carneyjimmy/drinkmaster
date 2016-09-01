//
//  Card.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/7/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import Foundation


class Card{
    
    var name: String?
    var num: String?
    var cvc: Int?
    
    init(name: String, num: String, cvc: Int){
        self.name = name
        self.num = num
        self.cvc = cvc
    }
    
}