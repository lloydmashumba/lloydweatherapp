//
//  CallService.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 23/7/2022.
//

import Foundation

@objc
protocol CallService {
    @objc optional func currentWeather(latitude lat : Double,longitude lon: Double, complete : @escaping (Any)->Void)
    @objc optional func forecast(latitude lat : Double,longitude lon: Double, complete : @escaping (Any)->Void)
    
}

extension CallService{
    
    
    internal func jsonCall(_ url :  String,handler done : @escaping (Any?)->Void){
        let url = URL(string: url)
        
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let weatherCall = URLSession.shared.dataTask(with: request) { data, reponse, error in
            if data != nil {
                let res = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                done(res)
                
            }else{
                print("\(error!)")
                done(nil)
            }
        }
        
        weatherCall.resume()
    }
    
    
    
}

