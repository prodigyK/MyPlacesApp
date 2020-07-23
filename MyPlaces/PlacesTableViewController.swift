//
//  PlacesTableViewController.swift
//  MyPlaces
//
//  Created by Admin on 13.07.2020.
//  Copyright © 2020 TheProdigy. All rights reserved.
//

import RealmSwift

class PlacesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let searchController = UISearchController(searchResultsController: nil)
    var places: Results<Place>!
    var filteredPlaces: Results<Place>!
    var ascendingSorting = true
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var reversedButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        searchController.isActive = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @IBAction func reversedPressed(_ sender: UIBarButtonItem) {

        ascendingSorting.toggle()
        let buttonImage = ascendingSorting ? #imageLiteral(resourceName: "AZ") : #imageLiteral(resourceName: "ZA")
        reversedButton.image = buttonImage
        
        sorting()
    }
    
    private func sorting() {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            places = places.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        tableView.reloadData()
    }
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        sorting()
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let sourceVC = segue.source as? DetailTableViewController else { return }
        sourceVC.savePlace()
       
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailCell" {
            guard let destVC = segue.destination as? DetailTableViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let place = places[indexPath.row]
            destVC.currentPlace = place
        }
        
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.isEmpty ? 0 : places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PlaceTableViewCell

        let place = places[indexPath.row]
        
        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.placeImage.image = UIImage(data: place.image!)
        cell.placeImage.layer.cornerRadius = cell.placeImage.bounds.width / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            let place = self.places[indexPath.row]
            RealmManager.delete(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [actionDelete])
    }
}

extension PlacesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredPlaces = places.filter("name CONTAINS[c] %@ OR location CONTAINS[c] %@", searchText, searchText)
        
        tableView.reloadData()
    }
}
