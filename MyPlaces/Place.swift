//
//  Place.swift
//  MyPlaces
//
//  Created by Admin on 14.07.2020.
//  Copyright © 2020 TheProdigy. All rights reserved.
//

import Foundation


struct Place {
    var name: String
    var location: String
    var type: String
    var image: String
    
    static let restaurantNames = [
        "Bonsai",
        "Burger Heroes",
        "Kitchen",
        "Love&Life",
        "Morris Pub",
        "Sherlock Holmes",
        "Speak Easy",
        "X.O",
        "Балкан Гриль",
        "Бочка",
        "Дастархан",
        "Вкусные истории",
        "Индокитай",
        "Классик",
        "Шок"
    ]
    
    static func generatePlaces() -> [Place] {
        
        var places: [Place] = []
        for name in restaurantNames {
            let place = Place(name: name, location: "Odessa", type: "Bar", image: name)
            places.append(place)
        }
        
        return places
    }
    
}
