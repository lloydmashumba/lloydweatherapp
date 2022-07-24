//
//  ViewController.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 22/7/2022.
//

import UIKit
import CoreLocation



class MainVC: UIViewController{
    
    var locationManager : CLLocationManager!

    @IBOutlet weak var imgWeatherBackground: UIImageView!
    
    @IBOutlet weak var lblWeatherDescription: UILabel!
    @IBOutlet weak var currentTempView: NSLayoutConstraint!
    @IBOutlet weak var mainForecastStack: UIStackView!
    
    @IBOutlet weak var lblMainTemp: UILabel!
    
    @IBOutlet weak var lblMinTemp: UILabel!
    
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentWeatherForLocation(lat: 47.5001, lon: -120.5015)
        getForecastForLocation(lat: 47.5001, lon: -120.5015)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentTempView.constant = view.bounds.height / 2
    }
    
    func viewBasedOnWeather(_ type : WeatherType){
        
        let weatherView = BACKGROUND_THEMES[type]!
        self.view.backgroundColor = UIColor(named : weatherView[.COLOR]!)
        self.imgWeatherBackground.image = UIImage(named: weatherView[.IMAGE]!)
    }
    
    private func getCurrentWeatherForLocation(lat : Double,lon : Double ){
        
        WeatherCalls.shared.currentWeather(latitude: lat, longitude: lon){
            result  in
            
            if let currentWeather = result as? CurrentWeather {
                DispatchQueue.main.async {
                    self.lblMainTemp.text = "\(currentWeather.temp)°"
                    self.lblMaxTemp.text = "\(currentWeather.maxTemp)°"
                    self.lblCurrentTemp.text = "\(currentWeather.temp)°"
                    self.lblMinTemp.text = "\(currentWeather.minTemp)°"
                    self.lblWeatherDescription.text = "\(currentWeather.weatherType)"
                    self.viewBasedOnWeather(currentWeather.weatherType)
                }
            }
            
        }
        
    }
    private func getForecastForLocation(lat : Double,lon : Double){
        
        WeatherCalls.shared.forecast(latitude: lat, longitude: lon){
            result in
            
            if let forecastList = result as? [Forecast] {
                
                let forecastDict = Dictionary(grouping: forecastList, by: {
                    Calendar(identifier: .gregorian).component(.weekday, from: $0.day)
                }).filter{
                    $0.key != Calendar(identifier: .gregorian).component(.weekday, from: Date.now)}
                    
                DispatchQueue.main.async {
                    for i in forecastDict.keys.sorted() {
                        
                        let forecast = forecastDict[i]![0]
                        self.mainForecastStack.addArrangedSubview(ForecastView(frame: CGRect.zero,
                                                                               forecast: forecast))
                    }
                }
                
            }
                
        }
        
    }
    
}
extension MainVC : CLLocationManagerDelegate{
    func setUpLocationManager(){
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coord : CLLocationCoordinate2D = manager.location!.coordinate
        
        getCurrentWeatherForLocation(lat: coord.latitude, lon: coord.longitude)
        
    }
}

