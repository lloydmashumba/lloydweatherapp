//
//  ViewController.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 22/7/2022.
//

import UIKit
import SwiftUI

class MainVC: UIViewController {

    
    @IBOutlet weak var lblWeatherDescription: UILabel!
    @IBOutlet weak var currentTempView: NSLayoutConstraint!
    @IBOutlet weak var mainForecastStack: UIStackView!
    
    @IBOutlet weak var lblMainTemp: UILabel!
    
    @IBOutlet weak var lblMinTemp: UILabel!
    
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherCalls.shared.currentWeather(latitude: 47.5001, longitude: -120.5015){
            result in
            
            let currentWeather  = result as! CurrentWeather
            DispatchQueue.main.async {
                self.lblMainTemp.text = "\(currentWeather.temp)°"
                self.lblMaxTemp.text = "\(currentWeather.maxTemp)°"
                self.lblCurrentTemp.text = "\(currentWeather.temp)°"
                self.lblMinTemp.text = "\(currentWeather.minTemp)°"
                self.lblWeatherDescription.text = currentWeather.weatherType
            }
            
        }
        
        self.view.backgroundColor = UIColor(named : "sea_cloudy_color")
        
        let days = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
        
        
        for i in 0...(days.count - 1) {
            mainForecastStack.addArrangedSubview(ForecastView(frame: CGRect.zero,day: days[i],temperature: 45))
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentTempView.constant = view.bounds.height / 2
    }

}

