//
//  RealmManager.swift
//  MyPlaces
//
//  Created by Admin on 17.07.2020.
//  Copyright © 2020 TheProdigy. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class RealmManager {
    
    static func save(_ place: Place) {
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func delete(_ place: Place) {
        try! realm.write {
            realm.delete(place)
        }
    }
    
}
