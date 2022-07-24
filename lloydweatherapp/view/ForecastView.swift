//
//  ForcastView.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 23/7/2022.
//

import UIKit

//ForecastView is used to display weather forcast for future days in MainVC
public class ForecastView : UIView {
    
    let foreCastDetailsStack = UIStackView()
    private var forecast : Forecast
    
    public init(frame: CGRect,forecast : Forecast) {
        self.forecast = forecast
        super.init(frame: frame)
        createView()
    }
    
    private func createView(){
        addSubview(foreCastDetailsStack)
        
        foreCastDetailsStack.translatesAutoresizingMaskIntoConstraints = false
        
        foreCastDetailsStack.alignment = .fill
        foreCastDetailsStack.distribution = .equalSpacing
        foreCastDetailsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        foreCastDetailsStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        foreCastDetailsStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        foreCastDetailsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        let forecastIconView = UIView()
        
        
        let day = DAYS_OF_WEEK[Calendar(identifier: .gregorian).component(.weekday, from: forecast.day) - 1]
        
        foreCastDetailsStack.addArrangedSubview(forecastLabel(text: day))
        foreCastDetailsStack.addArrangedSubview(forecastIconView)
        forecastIconSetup(view : forecastIconView,icon: "clear")
        foreCastDetailsStack.addArrangedSubview(forecastLabel(text: "\(forecast.temp)°"))
        
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func forecastLabel(text value : String) -> UILabel{
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = value;
        return label;
    }
    
    private func forecastIconSetup(view : UIView,icon : String){
        
        
        let iconView = UIImageView()
        
        
        view.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        iconView.image = UIImage(named: icon)
        iconView.contentMode = .scaleAspectFit
        
        iconView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconView.widthAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        
        
    }
    
}



