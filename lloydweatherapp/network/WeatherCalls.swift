//
//  NetworkCalls.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 23/7/2022.
//

import Foundation


public class WeatherCalls : CallService{
    
    static let shared = WeatherCalls()
    
    public func currentWeather(latitude lat : Double,longitude lon: Double, complete : @escaping (CurrentWeather)->Void){
        
        let urlString = String(format: "%@%@?units=metric&lat=%f&lon=%f&appid=%@",
                               BASE_URL,CURRENT_WEATHER,lat,lon,API_KEY)
        
        jsonCall(urlString){
            result in
            
            if(result != nil){
                
                if let resultDict = result as? NSDictionary {
                    
                    let currentWeather = CurrentWeather(city: resultDict["name"] as! String,
                                                                    temp: (resultDict["main"] as! NSDictionary)["temp"] as! Double,
                                                                    maxTemp: (resultDict["main"] as! NSDictionary)["temp_max"] as! Double,
                                                                    minTemp: (resultDict["main"] as! NSDictionary)["temp_min"] as! Double,
                                                                    weatherType : ((resultDict["weather"] as! NSArray)[0] as! NSDictionary)["main"] as! String,
                                                                    cloudPercentage: (resultDict["clouds"] as! NSDictionary)["all"] as! Double
                                                                    )
                    complete(currentWeather)
                    
                }
                
            }
        }
    
    }
    
    
    
}
