//
//  APIClient.swift
//  Drink Master 8000
//
//  Created by Andrew Camel on 11/8/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import Foundation

let server = "http://web001.dromolabs.com:10000"
let testEmail = "jared@geed.com"
let testPassword = "geed"
var token = "";
// a98947449cb7836a3ef0da3161526dc9532b5b3a

func getToken(email: String, password: String, newUser: Bool) {
    var fullURL = server + "/users/login/"
    if newUser {
        fullURL = server + "/users/"
    }
    
    let request = NSMutableURLRequest(URL: NSURL(string: fullURL)!)
    let userInfo: [String:String] = [
        "email": email,
        "password": password
    ]
    do {
        let jsonData = try NSJSONSerialization.dataWithJSONObject(userInfo, options: NSJSONWritingOptions.PrettyPrinted)
        request.HTTPBody = jsonData
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            let json = JSON(data: data!)
            token = json["token"].stringValue;
            getDrinks()
            getFavorites()
            getOrders()
        }
        task.resume()
    } catch {
        print("JSON encoding error")
    }
}

func getDrinks() {
    drinks = []
    items = []
    
    let request = NSMutableURLRequest(URL: NSURL(string: server + "/bars/1/")!)
    request.HTTPMethod = "GET"
    request.setValue("Token " + token, forHTTPHeaderField: "Authorization")
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        let json = JSON(data: data!)
        for (_, menuSection):(String, JSON) in json["menu_sections"] {
            _getDrinksInMenuSection(menuSection["id"].intValue)
        }
    }

    task.resume()
}

func addFavorite(drinkObj: Drink){
    let drink = serializeDrink(drinkObj)
    
    let request = NSMutableURLRequest(URL: NSURL(string: server + "/favorites/")!)
    request.HTTPMethod = "POST"
    request.setValue("Token " + token, forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try NSJSONSerialization.dataWithJSONObject(drink, options: NSJSONWritingOptions.PrettyPrinted)
        request.HTTPBody = jsonData
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            let json = JSON(data: data!)
            getFavorites()
        }
        task.resume()

    }
    catch{
        print(error)
    }
}

func removeFavorite(id: Int){
    let request = NSMutableURLRequest(URL: NSURL(string: server + "/favorites/" + String(id) + "/")!)
    request.HTTPMethod = "DELETE"
    request.setValue("Token " + token, forHTTPHeaderField: "Authorization")
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        let _ = JSON(data: data!)
        getFavorites()
    }
    task.resume()
    
}

func serializeDrink(drinkObj: Drink) -> [String: AnyObject]{
    var itemVariation: [String: Int] = [
        "id": 0
    ]
    var components: [[String:AnyObject]] = []
    if drinkObj.variations != nil && drinkObj.variations!.count != 0 {
        for variation in drinkObj.variations! {
            if variation.selected {
                itemVariation["id"] = variation.id!
            }
        }
    } else {
        print(drinkObj.components!.count)
        for componentObj in drinkObj.components! {
            if componentObj.quantity != nil {
                let component: [String: AnyObject] = [
                    "id": componentObj.id,
                    "quantity": componentObj.quantity!
                ]
                components.append(component)
            } else {
                for componentOptionObj in componentObj.options! {
                    if componentOptionObj.selected {
                        let componentOption: [String: AnyObject] = [
                            "id": componentOptionObj.id!
                        ]
                        let component: [String: AnyObject] = [
                            "id": componentObj.id,
                            "component_option": componentOption
                        ]
                        components.append(component)
                        break
                    }
                }
            }
        }
    }
    var drink: [String: AnyObject] = [
        "id": drinkObj.id,
        "quantity": drinkObj.quantity
    ]
    if itemVariation["id"] != 0 {
        drink["item_variation"] = itemVariation
    } else {
        let cocktail: [String: Int] = [
            "id": drinkObj.id,
        ]
        drink["cocktail"] = cocktail
        drink["components"] = components
    }
    return drink
}

func createOrder(drinkObjs: [Drink], tip: Double) {
    var drinksOutput: [[String:AnyObject]] = []
    for drinkObj in drinkObjs {
        let drink = serializeDrink(drinkObj)
        drinksOutput.append(drink)
    }
    let  userOutput: [String:Int] = [
        "id": 1
    ]
    let finalOutput: [String:AnyObject] = [
        "user": userOutput,
        "drinks": drinksOutput,
        "tip": tip
    ]
    do {
        let orderJSON = try NSJSONSerialization.dataWithJSONObject(finalOutput, options: NSJSONWritingOptions(rawValue: 0))
        _postOrder(orderJSON)
    } catch {
        print("JSON encoding error")
    }
}

func getFavorites() {
    favorites = []
    let request = NSMutableURLRequest(URL: NSURL(string: server + "/bars/1/")!)
    request.HTTPMethod = "GET"
    request.setValue("Token " + token, forHTTPHeaderField: "Authorization")
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        let json = JSON(data: data!)
        _parseFavorites(json["favorites"])
    }
    task.resume()
}

func getOrders() {
    let request = NSMutableURLRequest(URL: NSURL(string: server + "/bars/1/orders/")!)
    request.HTTPMethod = "GET"
    request.setValue("Token " + token, forHTTPHeaderField: "Authorization")
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        let json = JSON(data: data!)
        orders = _parseOrders(json)
    }
    task.resume()
}

func _postOrder(orderJSON: NSData) {
    let request = NSMutableURLRequest(URL: NSURL(string: server + "/bars/1/orders/")!)
    request.HTTPMethod = "POST"
    request.HTTPBody = orderJSON
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Token " + token, forHTTPHeaderField: "Authorization")
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data: NSData?, response:NSURLResponse?,
        error: NSError?) -> Void in
        let json = JSON(data: data!)
        estimated_pickup_time = json["estimated_pickup_time"].stringValue
        orderTime = json["minutes_remaining"].intValue
        placeInLine = json["orders_in_front"].intValue
        print("Order submitted successfully")
    }
    task.resume()
}

func _getDrinksInMenuSection(menuSectionId: Int) {
    let url = server + "/bars/1/drinks/?menu_section_id=" + String(menuSectionId)
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithURL(NSURL(string: url)!, completionHandler: { (data: NSData?, response:NSURLResponse?,
        error: NSError?) -> Void in
        let json = JSON(data: data!)
        _parseDrinks(json)
        
    })
    task.resume()
}

func _parseDrinks(json: JSON) {
    var itemsRef = [Int: Item]()
    
    for (_, drinkData):(String, JSON) in json {
        // Menu Sections
        var menuSectionsD: [MenuSection] = []
        for (_, menuSectionData):(String, JSON) in drinkData["menu_sections"] {
            let menuSection = MenuSection(id: menuSectionData["id"].intValue, name: menuSectionData["name"].stringValue)
            menuSectionsD.append(menuSection)
        }
        
        // Components
        if let _ = drinkData["components"].array {
            var componentsD: [Component] = []
            for (_, componentData):(String, JSON) in drinkData["components"] {
                // Component Category
                let category = Category(id: componentData["id"].intValue, name: componentData["name"].stringValue, primary: componentData["primary"].boolValue)
                
                // Item Categories
                var categoriesD: [Category] = []
                for (_, categoryData):(String, JSON) in componentData["item"]["categories"] {
                    let itemCategory = Category(id: categoryData["id"].intValue, name: categoryData["name"].stringValue, primary: categoryData["primary"].boolValue)
                    categoriesD.append(itemCategory)
                }
                
                // Item
                var ozPrice = 0.0
                if (componentData["item"]["oz_price"].double != nil) {
                    ozPrice = componentData["item"]["oz_price"].doubleValue
                }
                let item = Item(id: componentData["item"]["id"].intValue, categories: categoriesD, name: componentData["item"]["name"].stringValue, ozPrice: ozPrice)
                itemsRef[item.id] = item
                
                var itemsCount = 0;
                if let _ = componentData["component_options"].array {
                    itemsCount = (componentData["component_options"].array?.count)!;
                }
                if itemsCount != 0 {
                    // Component Options
                    var componentOptionsD: [ComponentOption] = []
                    for (_, componentOptionsData):(String, JSON) in componentData["component_options"] {
                        let componentOption = ComponentOption(id: componentOptionsData["id"].intValue, name: componentOptionsData["name"].stringValue, price: componentOptionsData["price"].doubleValue, isDefault: componentOptionsData["default"].boolValue)
                        componentOptionsD.append(componentOption)
                    }
                    // TODO: store multiple categories (not just [0])
                    let component = Component(id: componentData["id"].intValue, item: item, category: category, options: componentOptionsD, onlyItem: componentData["onlyItem"].boolValue)
                    componentsD.append(component)
                } else {
                    // Quantity & Units
                    let component = Component(id: componentData["id"].intValue, item: item, category: category, quantity: componentData["quantity"].doubleValue, units: componentData["units"].stringValue, onlyItem: componentData["onlyItem"].boolValue)
                    componentsD.append(component)
                }
                
            }
            let drink = Drink(id: drinkData["id"].intValue, name: drinkData["name"].stringValue, menuSection: menuSectionsD[0], components: componentsD)
            drinks.append(drink)
        } else {
            // Item Variations
            var itemVariationsD: [ItemVariation] = []
            for (_, itemVariationData):(String, JSON) in drinkData["item_variations"] {
                let itemVariation = ItemVariation(id: itemVariationData["id"].intValue, name: itemVariationData["name"].stringValue, price: itemVariationData["price"].doubleValue)
                itemVariationsD.append(itemVariation)
            }
            let drink = Drink(id: drinkData["id"].intValue, name: drinkData["name"].stringValue, menuSection: menuSectionsD[0], variations: itemVariationsD)
            drinks.append(drink)
        }
    }
    items.appendContentsOf(itemsRef.values)
}

func _parseFavorites(json: JSON) {
    var itemsRef = [Int: Item]()
    
    if (json.count == 0){
        return
    }
    
    for (_, drinkData):(String, JSON) in json {
        // Menu Sections
        var menuSectionsD: [MenuSection] = []
        for (_, menuSectionData):(String, JSON) in drinkData["menu_sections"] {
            let menuSection = MenuSection(id: menuSectionData["id"].intValue, name: menuSectionData["name"].stringValue)
            menuSectionsD.append(menuSection)
        }
        
        // Components
        if let _ = drinkData["components"].array {
            var componentsD: [Component] = []
            for (_, componentData):(String, JSON) in drinkData["components"] {
                // Component Category
                let category = Category(id: componentData["id"].intValue, name: componentData["name"].stringValue, primary: componentData["primary"].boolValue)
                
                // Item Categories
                var categoriesD: [Category] = []
                for (_, categoryData):(String, JSON) in componentData["item"]["categories"] {
                    let itemCategory = Category(id: categoryData["id"].intValue, name: categoryData["name"].stringValue, primary: categoryData["primary"].boolValue)
                    categoriesD.append(itemCategory)
                }
                
                // Item
                var ozPrice = 0.0
                if (componentData["item"]["oz_price"].double != nil) {
                    ozPrice = componentData["item"]["oz_price"].doubleValue
                }
                let item = Item(id: componentData["item"]["id"].intValue, categories: categoriesD, name: componentData["item"]["name"].stringValue, ozPrice: ozPrice)
                itemsRef[item.id] = item
                
                var itemsCount = 0;
                if let _ = componentData["component_options"].array {
                    itemsCount = (componentData["component_options"].array?.count)!;
                }
                if itemsCount != 0 {
                    // Component Options
                    var componentOptionsD: [ComponentOption] = []
                    for (_, componentOptionsData):(String, JSON) in componentData["component_options"] {
                        let componentOption = ComponentOption(id: componentOptionsData["id"].intValue, name: componentOptionsData["name"].stringValue, price: componentOptionsData["price"].doubleValue, isDefault: componentOptionsData["default"].boolValue)
                        componentOptionsD.append(componentOption)
                    }
                    // TODO: store multiple categories (not just [0])
                    let component = Component(id: componentData["id"].intValue, item: item, category: category, options: componentOptionsD, onlyItem: componentData["onlyItem"].boolValue)
                    componentsD.append(component)
                } else {
                    // Quantity & Units
                    let component = Component(id: componentData["id"].intValue, item: item, category: category, quantity: componentData["quantity"].doubleValue, units: componentData["units"].stringValue, onlyItem: componentData["onlyItem"].boolValue)
                    componentsD.append(component)
                }
                
            }
            let drink = Drink(id: drinkData["id"].intValue, name: drinkData["name"].stringValue, menuSection: MenuSection(id: 3, name: "Favorite"), components: componentsD)
            favorites.append(drink)
        } else {
            // Item Variations
            var itemVariationsD: [ItemVariation] = []
            for (_, itemVariationData):(String, JSON) in drinkData["item_variations"] {
                let itemVariation = ItemVariation(id: itemVariationData["id"].intValue, name: itemVariationData["name"].stringValue, price: itemVariationData["price"].doubleValue)
                itemVariationsD.append(itemVariation)
            }
            let drink = Drink(id: drinkData["id"].intValue, name: drinkData["name"].stringValue, menuSection: MenuSection(id: 3, name: "Favorite"), variations: itemVariationsD)
            drinks.append(drink)
        }
    }
    items.appendContentsOf(itemsRef.values)
}

func _parseOrders(json: JSON) -> [Order] {
    if (json.count == 0){
        return []
    }
    
    let dateFor: NSDateFormatter = NSDateFormatter()
    dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    var internalOrders = [Order]()
    for (_, orderData):(String, JSON) in json {
        
        let stringStatus = orderData["status"].stringValue
        var status = OrderStatus.Preparing
        if (stringStatus == "Ready for Pickup") {
            status = OrderStatus.Ready
        } else if (stringStatus == "Complete") {
            status = OrderStatus.Complete
        }
        let order = Order(
            status: status,
            drinks: _parseOrderDrinks(orderData["drinks"].arrayValue),
            firstStatus: false,
            sub_total: orderData["sub_total"].doubleValue,
            tax: orderData["tax"].doubleValue,
            tip: orderData["tip"].doubleValue,
            total: orderData["total"].doubleValue,
            time_created: dateFor.dateFromString(orderData["time_created"].stringValue)!,
            estimated_pickup_time: dateFor.dateFromString(orderData["estimated_pickup_time"].stringValue)!,
            placeInLine: orderData["orders_in_front"].intValue,
            minRemaining: orderData["minutes_remaining"].intValue
        )
        order.barName = orderData["bar"]["name"].stringValue
        internalOrders.append(order)
    }
    return internalOrders
}

func _parseOrderDrinks(json: [JSON]) -> [Drink] {
    var orderDrinks = [Drink]()
    let dummyCocktailMenuSection = MenuSection(id: -1, name: "Cocktails")
    let dummyBeerWineMenuSection = MenuSection(id: -2, name: "Beer/Wine")
    
    for drinkData in json {
        if drinkData["components"].arrayValue.count > 0 {
            var componentsD: [Component] = []
            for (_, componentData):(String, JSON) in drinkData["components"] {
                // Component Category
                let category = Category(id: componentData["id"].intValue, name: componentData["name"].stringValue, primary: componentData["primary"].boolValue)
                
                // Item Categories
                var categoriesD: [Category] = []
                for (_, categoryData):(String, JSON) in componentData["item"]["categories"] {
                    let itemCategory = Category(id: categoryData["id"].intValue, name: categoryData["name"].stringValue, primary: categoryData["primary"].boolValue)
                    categoriesD.append(itemCategory)
                }
                
                // Item
                var ozPrice = 0.0
                if (componentData["item"]["oz_price"].double != nil) {
                    ozPrice = componentData["item"]["oz_price"].doubleValue
                }
                let item = Item(id: componentData["item"]["id"].intValue, categories: categoriesD, name: componentData["item"]["name"].stringValue, ozPrice: ozPrice)
                
                if componentData["option"].stringValue.characters.count == 0 {
                    let component = Component(id: componentData["id"].intValue, item: item, category: category, quantity: componentData["quantity"].doubleValue, units: componentData["units"].stringValue, onlyItem: componentData["onlyItem"].boolValue)
                    componentsD.append(component)
                } else {
                    let componentOption = ComponentOption(id: -1, name: componentData["option"].stringValue, price: componentData["price"].doubleValue, isDefault: true)
                    let component = Component(id: componentData["id"].intValue, item: item, category: category, options: [componentOption], onlyItem: false)
                    componentsD.append(component)
                }
                
            }
            let drink = Drink(id: drinkData["id"].intValue, name: drinkData["name"].stringValue, menuSection: dummyCocktailMenuSection, components: componentsD)
            drink.quantity = Int(drinkData["quantity"].floatValue)
            orderDrinks.append(drink)
        } else {
            // Item Variations
            var itemVariationsD: [ItemVariation] = []
            let itemVariationData = drinkData["item_variation"]
            let itemVariation = ItemVariation(id: itemVariationData["id"].intValue, name: itemVariationData["name"].stringValue, price: itemVariationData["price"].doubleValue)
            itemVariation.selected = true
            itemVariationsD.append(itemVariation)
            let drink = Drink(id: drinkData["id"].intValue, name: drinkData["name"].stringValue, menuSection: dummyBeerWineMenuSection, variations: itemVariationsD)
            drink.quantity = Int(drinkData["quantity"].floatValue)
            orderDrinks.append(drink)
        }
    }
    return orderDrinks
}