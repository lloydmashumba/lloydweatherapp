//
//  CallService.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 23/7/2022.
//

import Foundation
enum CallType{ case CURRENT,FORECAST}

@objc
protocol CallService {
    @objc optional func currentWeather(latitude lat : Float,longitude lon: Float, whenComplete : @escaping (Any)->Void)
    
}

extension CallService{
    
    func callComplete(complete : (Any)->Void, result : NSDictionary,type : CallType){
        
        switch type {
        case .CURRENT:
            let currentWeather = CurrentWeather(city: result["name"] as! String,
                                                temp: (result["main"] as! NSDictionary)["temp"] as! Double,
                                                maxTemp: (result["main"] as! NSDictionary)["temp_max"] as! Double,
                                                minTemp: (result["main"] as! NSDictionary)["temp_min"] as! Double,
                                                weatherType : ((result["weather"] as! NSArray)[0] as! NSDictionary)["main"] as! String,
                                                cloudPercentage: (result["clouds"] as! NSDictionary)["all"] as! Double
                                                )
            
            complete(currentWeather)
            
            break
        case .FORECAST:
            print("not yet")
        }
        
    }
}
