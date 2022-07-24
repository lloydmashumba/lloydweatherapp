//
//  NetworkCalls.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 23/7/2022.
//

import Foundation


enum WeatherType {case CLOUDY,SUNNY,RAINNY}

public class WeatherCalls : CallService{
    
    static let shared = WeatherCalls()
    
    
    func forecast(latitude lat: Double, longitude lon: Double, complete: @escaping (Any) -> Void) {
        let urlString = String(format: "%@%@?units=metric&lat=%f&lon=%f&appid=%@",
                               BASE_URL,FORECAST,lat,lon,API_KEY)
        
        jsonCall(urlString){
            result in
                if let value = result as? NSDictionary{
                    
                    if let forecastDictList = value["list"] as? NSArray{
                        
                        var foreCastList = [Forecast]()
                        
                        for i in 0...(forecastDictList.count - 1){
                            
                            let forcastDict = forecastDictList[i] as! NSDictionary
                            
                            
                            let day = (Date(timeIntervalSince1970: forcastDict["dt"] as! Double))
                            
                            let forecast = Forecast(
                                day: day,
                                temp: (forcastDict["main"] as! NSDictionary)["temp"] as! Double,
                                type: ((forcastDict["weather"] as! NSArray)[0] as! NSDictionary)["main"] as! String
                            )
                            
                            foreCastList.append(forecast)
                            
                        }
                        complete(foreCastList)
                    }
                
            }
        }
    }
    
    public func currentWeather(latitude lat : Double,longitude lon: Double, complete : @escaping (Any)->Void){
        
        let urlString = String(format: "%@%@?units=metric&lat=%f&lon=%f&appid=%@",
                               BASE_URL,CURRENT_WEATHER,lat,lon,API_KEY)
        
        jsonCall(urlString){
            result in
            if let resultDict = result as? NSDictionary {
                let currentWeather = CurrentWeather(city: resultDict["name"] as! String,
                                                                temp: (resultDict["main"] as! NSDictionary)["temp"] as! Double,
                                                                maxTemp: (resultDict["main"] as! NSDictionary)["temp_max"] as! Double,
                                                                minTemp: (resultDict["main"] as! NSDictionary)["temp_min"] as! Double,
                                                    weatherType : self.determineWeatherType(s: ((resultDict["weather"] as! NSArray)[0] as! NSDictionary)["main"] as! String),
                                                                cloudPercentage: (resultDict["clouds"] as! NSDictionary)["all"] as! Double
                                                                )
                complete(currentWeather)
                
            }
        }
    
    }
    
    func determineWeatherType(s : String) -> WeatherType{
        return s == "Clouds" ? .CLOUDY : s == "Clear" ? .SUNNY : .RAINNY
    }
    
    
}
