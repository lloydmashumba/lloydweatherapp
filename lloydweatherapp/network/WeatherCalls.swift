//
//  NetworkCalls.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 23/7/2022.
//

import Foundation


public class WeatherCalls : CallService{
    
    static let shared = WeatherCalls()
    public func currentWeather(latitude lat : Float,longitude lon: Float, whenComplete : @escaping (Any)->Void){
        
        let urlString = String(format: "%@%@?units=metric&lat=%f&lon=%f&appid=%@",
                               BASE_URL,CURRENT_WEATHER,lat,lon,API_KEY)
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        let weatherCall = URLSession.shared.dataTask(with: request) { data, reponse, error in
            if data != nil {
                let res = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if(res != nil){
                    self.callComplete(complete : whenComplete,result: res!,type: .CURRENT)
                }
                
            }else{
                print("error")
                print("\(error!)")
            }
        }
        
        weatherCall.resume()
        
        
    }
    
    
    
}
