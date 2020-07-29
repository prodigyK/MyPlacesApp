//
//  Place.swift
//  MyPlaces
//
//  Created by Admin on 14.07.2020.
//  Copyright © 2020 TheProdigy. All rights reserved.
//

import RealmSwift


class Place: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var image: Data?
    @objc dynamic var date = Date()
    @objc dynamic var rating = 0.0
    
    convenience init(name: String, location: String?, type: String?, image: Data?, rating: Double) {
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.image = image
        self.rating = rating
    }
    
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
    
    static func savePlaces() {
        
         
        for place in restaurantNames {
            
            let newPlace = Place()
            
            let image = UIImage(named: place)
            guard let imageData = image?.pngData() else { return }
            
            newPlace.name = place
            newPlace.location = "Odessa"
            newPlace.type = "Bar"
            newPlace.image = imageData
            
            RealmManager.save(newPlace)
        }
    }
    
//    static func generatePlaces() -> [Place] {
//
//        var places: [Place] = []
//        for name in restaurantNames {
//            let place = Place(name: name, location: "Odessa", type: "Bar", image: nil, restaurantImage: name)
//            places.append(place)
//        }
//
//        return places
//    }
    
}
