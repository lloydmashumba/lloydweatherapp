//
//  SavedListVC.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 24/7/2022.
//

import UIKit

protocol SavedListDelegate {
    func didSelectLocation(location : SavedLocation)
}


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
    
    
    
    @IBAction func closeTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let location = locationList[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "location")!
        let savedLocationView = SavedLocationsView(frame: cell.contentView.bounds,location: location)
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.contentView.addSubview(savedLocationView)
        
        return cell
            
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        dismiss(animated: true){ [self] in
            self.delegate.didSelectLocation(location: locationList[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
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

