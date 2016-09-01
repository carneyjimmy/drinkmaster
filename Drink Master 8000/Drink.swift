//
//  Drink.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/3/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import Foundation


class Drink : Copying{
    
    var id: Int
    var name: String
    var menuSection: MenuSection
    var components: [Component]?
    var variations: [ItemVariation]?
    var quantity: Int
    
    func getPrice() -> Double{
        var currentPrice = 0.0
        if (menuSection.name! == "Cocktails" || menuSection.name! == "Favorite"){
            for c in self.components!{
                if let q = c.quantity{
                    currentPrice += q * c.item!.ozPrice
                }
                else {
                    for v in c.options!{
                        if (v.selected){
                            currentPrice += v.price!
                        }
                    }
                }
            }
        }
        else {
            for v in variations!{
                if v.selected{
                    currentPrice = v.price!
                }
            }
        }
        return currentPrice * Double(quantity)
    }
    
    init(id: Int, name: String, menuSection: MenuSection, components: [Component]?, variations: [ItemVariation]?){
        self.id = id
        self.name = name
        self.menuSection = menuSection
        self.components = components
        self.variations = variations
        self.quantity = 1
        
        if let vars = self.variations{
            if (vars.count > 0){
                vars[0].selected = true
            }
        }
    }
    
    convenience init(id: Int, name: String, menuSection: MenuSection, components: [Component]){
        self.init(id: id, name: name, menuSection: menuSection, components: components, variations: [])
    }
    
    convenience init(id: Int, name: String, menuSection: MenuSection, variations: [ItemVariation]){
        self.init(id: id, name: name, menuSection: menuSection, components: [], variations: variations)
    }
    
    convenience init(id: Int, name: String, menuSection: MenuSection){
        self.init(id: id, name: name, menuSection: menuSection, components: [], variations: [])
    }
    
    required init (original: Drink){
        
        //ID, Name, Menu Section
        self.id = original.id
        self.name = original.name
        self.menuSection = MenuSection(id: original.menuSection.id, name: original.menuSection.name!)
        
        //Components
        var comp : [Component] = []
        for c in original.components!{
            
            //Component Item
            let item = c.item!
            var ic : [Category] = []
            for icat in item.categories{
                ic.append(Category(id: icat.id, name: icat.name!, primary: icat.primary))
            }
            let i = Item(id: item.id, categories: ic, name: item.name, ozPrice: item.ozPrice)
            
            //Component Category
            let cat = c.category!
            let ca = Category(id: cat.id, name: cat.name!, primary: cat.primary)
            
            if let q = c.quantity{
                comp.append(Component(id: c.id, item: item, category: cat, quantity: q, units: c.units!, onlyItem: c.onlyItem))
            }
            else {
                //Component Options
                var o : [ComponentOption] = []
                for opt in c.options!{
                    o.append(ComponentOption(id: opt.id!, name: opt.name!, price: opt.price!, isDefault: opt.isDefault))
                }
                
                comp.append(Component(id: c.id, item: item, category: cat, options: o, onlyItem: c.onlyItem))
            }
            
        }
        
        //Variations
        var vs : [ItemVariation] = []
        for v in original.variations!{
            print(v.name!)
            vs.append(ItemVariation(id: v.id!, name: v.name!, price: v.price!))
        }
        
        //Tying it all together
        self.components = comp
        self.variations = vs
        self.quantity = 1
    }
    
}
