//
//  CurrentWeather.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 23/7/2022.
//

import Foundation


public struct CurrentWeather {
    
    var city : String
    var temp : Double
    var maxTemp : Double
    var minTemp : Double
    var weatherType : String
    var cloudPercentage : Double
    
}

public struct Forecast{
    
    var day : Date
    var temp : Double
    var type : String
    
}
