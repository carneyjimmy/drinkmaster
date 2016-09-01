//
//  AllData.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/7/15.
//  Copyright © 2015 Dromo. All rights reserved.
//



var categories = [
    Category(id: 1, name: "Rum", primary: true),
    Category(id: 2, name: "Tequila", primary: true),
    Category(id: 3, name: "Gin", primary: true),
    Category(id: 4, name: "Whiskey", primary: true),
    Category(id: 5, name: "Vodka", primary: true),
    Category(id: 6, name: "Beer", primary: true),
    Category(id: 7, name: "Wine", primary: true)
]

var items = [
    Item(id: 1, categories: [categories[0]], name: "Don Q", ozPrice: 4.00),
    Item(id: 2, categories: [categories[0]], name: "Captain Morgan", ozPrice: 4.50),
    Item(id: 3, categories: [categories[1]], name: "Jose Cuervo", ozPrice: 5.50),
    Item(id: 4, categories: [categories[1]], name: "Sauza Silver", ozPrice: 4.00),
    
    Item(id: 5, categories: [categories[2]], name: "Hendrick's", ozPrice: 7.00),
    Item(id: 6, categories: [categories[2]], name: "Bombay Sapphire", ozPrice: 6.00),
    
    Item(id: 7, categories: [categories[3]], name: "Wild Turkey 101", ozPrice: 7.00),
    Item(id: 8, categories: [categories[3]], name: "Bulleit", ozPrice: 8.00),
    
    Item(id: 9, categories: [categories[4]], name: "Smirnoff", ozPrice: 5.00),
    Item(id: 10, categories: [categories[4]], name: "Grey Goose", ozPrice: 8.00)
]

var componentOptions = [
    ComponentOption(id: 1, name: "Just a Little", price: 0.50, isDefault: false),
    ComponentOption(id: 2, name: "Normal", price: 1.00, isDefault: true),
    ComponentOption(id: 3, name: "Extra", price: 1.50, isDefault: false)
]

var components = [
    Component(id: 1, item: items[1], category: categories[0], quantity: 1.5, units: "oz", onlyItem: false),
    Component(id: 1, item: items[1], category: categories[0], options: [componentOptions[0], componentOptions[1], componentOptions[2]], onlyItem: false)
]

var itemVariations = [
    ItemVariation(id: 0, name: "Bottle", price: 5.50),
    ItemVariation(id: 1, name: "Can", price: 4.00),
    ItemVariation(id: 2, name: "Pitcher", price: 13.00)
]

var menuSections = [
    MenuSection(id: 1, name: "Cocktails")
]

var drinks: [Drink] = [
    Drink(id: 1, name: "Rum and Coke", menuSection: menuSections[0], components: [components[0], components[1]])
]

var bars = [
    Bar(id: 1, name: "Three Kings", distance: 0.1, wait: 5),
    Bar(id: 1, name: "Blue Hill", distance: 0.2, wait: 7),
    Bar(id: 1, name: "Moonrise", distance: 0.4, wait: 16),
    Bar(id: 1, name: "Library Annex", distance: 4.5, wait: 4),
    Bar(id: 1, name: "Taste", distance: 5.4, wait: 8),
    Bar(id: 1, name: "Howl of the Moon", distance: 8.8, wait: 13)
]


var cards = [
    Card(name: "AMEX 6734", num: "448133443424702", cvc: 3345),
    Card(name: "VISA 2412", num: "5910384051051953", cvc: 773)
]

var orders : [Order] = [

]

var orderTime = 2

var estimated_pickup_time = ""

var placeInLine = -1


var favorites : [Drink] = []
