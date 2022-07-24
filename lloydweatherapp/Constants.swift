//
//  Constants.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 22/7/2022.
//

import Foundation

// MARK : KEYS
let API_KEY = "1e8055ffb2635e34dd169d92bca3f972"

//MARK : DOMAIN
let BASE_URL = "https://api.openweathermap.org/data/2.5/"

// MARK : ENDPOINTS
let CURRENT_WEATHER = "weather"
let FORECAST = "forecast"

// MARK : ENUMS
enum BACKGROUN_ASSET {case IMAGE,COLOR}


// MARK : LIST ITEMS
let DAYS_OF_WEEK = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
let BACKGROUND_THEMES : [WeatherType:[BACKGROUN_ASSET:String]] =
[
    .CLOUDY:
        [
            .IMAGE : "sea_cloudy",
            .COLOR : "sea_cloudy_color"
        ],
    .RAINNY :
        [
            .IMAGE: "sea_rainy",
            .COLOR : "sea_rainy_color"
        ],
    .SUNNY:
        [
            .IMAGE : "sea_sunny",
            .COLOR : "sea_sunny_color"
        ]
    
]



