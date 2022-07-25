//
//  SavedListVC.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 24/7/2022.
//

import UIKit

class SavedListVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var themeColor : UIColor!
    @IBOutlet weak var tableContainer: UIView!
    
    @IBOutlet weak var savedListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableContainer.backgroundColor = themeColor
        savedListTable.register(UITableViewCell.self, forCellReuseIdentifier: "location")
    
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "location")!
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cellView(cell: cell)
        
        return cell
            
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func cellView(cell : UITableViewCell){
        let savedLocationContent = UIView()
        savedLocationContent.backgroundColor = .clear
        savedLocationContent.frame = cell.contentView.bounds
        cell.contentView.addSubview(savedLocationContent)
        
        let citylbl = UILabel()
        citylbl.frame = savedLocationContent.bounds
        savedLocationContent.addSubview(citylbl)
        citylbl.text = "Harare"
        citylbl.textColor = .white
        
        
        
        //cell.layoutSubviews()
        
    }

}

