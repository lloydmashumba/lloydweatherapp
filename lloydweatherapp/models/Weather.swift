//
//  CurrentWeather.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 23/7/2022.
//

import Foundation

//current weather model
public struct CurrentWeather {
    
    var city : String
    var temp : Double
    var maxTemp : Double
    var minTemp : Double
    var weatherType : WeatherType
    var cloudPercentage : Double
    
}
//Forcast Model
public struct Forecast{
    
    var day : Date
    var temp : Double
    var type : String
    
}
