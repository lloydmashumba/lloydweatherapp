//
//  ForcastView.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 23/7/2022.
//

import UIKit

public class ForecastView : UIView {
    
    let foreCastDetailsStack = UIStackView()
    var day : String!
    var image : String!
    var temperature : String!
    
    public override func draw(_ rect: CGRect) {
        
        foreCastDetailsStack.alignment = .fill
        foreCastDetailsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        foreCastDetailsStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        foreCastDetailsStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        foreCastDetailsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        foreCastDetailsStack.addSubview(forecastLabel(text: "Monday"))
        foreCastDetailsStack.addSubview(forecastLabel(text: ""))
        foreCastDetailsStack.addSubview(forecastLabel(text: "26"))
        
        self.addSubview(foreCastDetailsStack)
    }
    
    private func forecastLabel(text value : String) -> UILabel{
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = value;
        return label;
    }
    
    
    
}



