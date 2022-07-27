//
//  SavedListVC.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 24/7/2022.
//

import UIKit

//Implemented by a state that wants to perform an action based on the SavedListVC Interactions
protocol SavedListDelegate {
    func didSelectLocation(location : SavedLocation)
}

//A viewcontroller that displays and manipulated save locations
class SavedListVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var bar: UINavigationBar!
    
    var themeColor : UIColor!
    @IBOutlet weak var tableContainer: UIView!
    
    var delegate : SavedListDelegate!
    
    @IBOutlet weak var savedListTable: UITableView!
    
    let locationRepository = SavedLocationService.shared
    var locationList = [SavedLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableContainer.backgroundColor = themeColor
        tableContainer.layer.borderWidth = 1
        tableContainer.layer.borderColor = UIColor.white.cgColor
        tableContainer.layer.cornerRadius = 20
        tableContainer.clipsToBounds = true
        bar.barTintColor = themeColor
        savedListTable.register(UITableViewCell.self, forCellReuseIdentifier: "location")
        
        locationRepository.getAllSavedLocations(){
            locationList in
            self.locationList = locationList
            savedListTable.reloadData()
        }
    
        
    }
    
    
    //dismis view on button click
    @IBAction func closeTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //number of cells based on count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList.count;
    }
    
    /**
    MARK : Saved location celll
    - cell adds SavedLocationsView to it's content view
    - initializes it  with the SavedLocation
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let location = locationList[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "location")!
        let savedLocationView = SavedLocationsView(frame: cell.contentView.bounds,location: location)
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.contentView.addSubview(savedLocationView)
        
        return cell
            
    }
    
    //selecting the desired location
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        dismiss(animated: true){ [self] in
            self.delegate.didSelectLocation(location: locationList[indexPath.row])
        }
    }
    //fixed height for the location content
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //deleting and reloading contents of the saved location db
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            locationRepository.deleteLocation(location:locationList[indexPath.row]){
                deleted in
                if(deleted){
                    locationRepository.getAllSavedLocations(){
                        locationList in
                        self.locationList = locationList
                        savedListTable.reloadData()
                    }
                }
            }
        }
    }
    
}

