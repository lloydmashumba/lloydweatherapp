//
//  SavedLocationsView.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 24/7/2022.
//

import UIKit

//SavedLocationsView is displayed on the SavedListVC table view cell
class SavedLocationsView : UIView {
    
    
    //accepts saved location for display
    init(frame: CGRect,location : SavedLocation) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(mainHorizontalStackView(location: location))
    }
    
    //setting up the view
    func mainHorizontalStackView(location : SavedLocation) -> UIStackView{
        
        //based on location data
        let mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.frame = bounds
        mainStack.axis = .horizontal
        mainStack.alignment = .fill
        mainStack.spacing = 4
        mainStack.distribution = .fillEqually
        
        let subStack = UIStackView()
        subStack.axis = .vertical
        subStack.alignment = .fill
        subStack.distribution = .fillEqually
        
        let citylbl = UILabel()
        citylbl.font = weather_font(size: 20, .semibold)
        citylbl.text = location.city
        citylbl.textColor = .white
        
        let coordinateslbl = UILabel()
        coordinateslbl.text = "[\(location.lat),\(location.lon)]"
        coordinateslbl.font = weather_font(size: 14, .thin)
        coordinateslbl.textColor = .white
        
        subStack.addArrangedSubview(citylbl)
        subStack.addArrangedSubview(coordinateslbl)
        let datelbl = UILabel()
        datelbl.textAlignment = .right
        datelbl.text = "\(location.savedOn!)".components(separatedBy: " ")[0]
        datelbl.textColor = .white
        datelbl.font = weather_font(size: 14, .thin)
        
        mainStack.addArrangedSubview(subStack)
        mainStack.addArrangedSubview(datelbl)
        datelbl.frame = bounds
        
        return mainStack
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
