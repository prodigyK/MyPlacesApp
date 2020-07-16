//
//  PlacesTableViewController.swift
//  MyPlaces
//
//  Created by Admin on 13.07.2020.
//  Copyright © 2020 TheProdigy. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController {
    
    var places: [Place] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = Place.generatePlaces()
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let sourceVC = segue.source as? DetailTableViewController else { return }
        
        let place = sourceVC.saveNewPlace()
        
        places.append(place)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PlaceTableViewCell

        let place = places[indexPath.row]
        
        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.placeImage.image = place.image != nil ? place.image : UIImage(named: places[indexPath.row].restaurantImage!)
        cell.placeImage.layer.cornerRadius = cell.placeImage.bounds.width / 2
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    

}
