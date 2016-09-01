//
//  Order.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/9/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import Foundation

class Order{
    
    var status: OrderStatus
    var drinks: [Drink]
    var firstStatus: Bool
    var sub_total: Double
    var tax: Double
    var tip: Double
    var total: Double
    var time_created: NSDate
    var estimated_pickup_time: NSDate
    var placeInLine: Int
    var minRemaining: Int
    var timePerOrder: Int
    var barName: String
    
    init(status: OrderStatus, drinks: [Drink], firstStatus:Bool, sub_total: Double, tax: Double, tip: Double, total: Double, time_created: NSDate, estimated_pickup_time: NSDate, placeInLine: Int, minRemaining: Int){
        self.status = status
        self.drinks = drinks
        self.firstStatus = firstStatus
        self.sub_total = sub_total
        self.tax = tax
        self.tip = tip
        self.total = total
        self.time_created = time_created
        self.estimated_pickup_time = estimated_pickup_time
        self.minRemaining = minRemaining
        self.placeInLine = placeInLine
        if (placeInLine == 0 || minRemaining == 0) {
            self.timePerOrder = 2
        } else {
            self.timePerOrder = minRemaining / placeInLine
        }
        
        self.barName = "Kings"
    }
    
}



enum OrderStatus: String{
    case Preparing = "Preparing"
    case Ready = "Ready for Pickup"
    case Complete = "Complete"
}