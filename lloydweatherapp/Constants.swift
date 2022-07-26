//
//  Constants.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 22/7/2022.
//

import Foundation
import UIKit

let appdelegate = UIApplication.shared.delegate as! AppDelegate

// MARK : KEYS
let API_KEY = "1e8055ffb2635e34dd169d92bca3f972"

//MARK : DOMAIN
let BASE_URL = "https://api.openweathermap.org/data/2.5/"

// MARK : ENDPOINTS
let CURRENT_WEATHER = "weather"
let FORECAST = "forecast"

// MARK : ENUMS
enum BACKGROUND_ASSET {case IMAGE,COLOR}


// MARK : LIST ITEMS
let DAYS_OF_WEEK = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
let BACKGROUND_THEMES : [WeatherType:[BACKGROUND_ASSET:String]] =
[
    .CLOUDY:
        [
            .IMAGE : "forest_cloudy",
            .COLOR : "forest_cloudy_color"
        ],
    .RAINNY :
        [
            .IMAGE: "forest_rainy",
            .COLOR : "forest_rainy_color"
        ],
    .SUNNY:
        [
            .IMAGE : "forest_sunny",
            .COLOR : "forest_sunny_color"
        ]
    
]



