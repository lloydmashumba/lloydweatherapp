//
//  SavedListVC.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 24/7/2022.
//

import UIKit

class SavedListVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var bar: UINavigationBar!
    
    var themeColor : UIColor!
    @IBOutlet weak var tableContainer: UIView!
    
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
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cellView(cell: cell,location: location)
        
        return cell
            
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func cellView(cell : UITableViewCell,location : SavedLocation){
        let savedLocationContent = UIView()
        savedLocationContent.backgroundColor = .clear
        savedLocationContent.frame = cell.contentView.bounds
        cell.contentView.addSubview(savedLocationContent)
        
        let citylbl = UILabel()
        citylbl.frame = savedLocationContent.bounds
        savedLocationContent.addSubview(citylbl)
        citylbl.text = location.city
        citylbl.textColor = .white
    
        //cell.layoutSubviews()
        
    }

}

