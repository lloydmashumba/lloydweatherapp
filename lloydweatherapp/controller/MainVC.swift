//
//  ViewController.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 22/7/2022.
//

import UIKit
import CoreLocation


class MainVC: UIViewController , SavedListDelegate,ProgressDelegate {
    
    
    
    var locationManager : CLLocationManager!
    var themeColor : UIColor!
    let locationRepo = SavedLocationService.shared
    var currentLatitude : Double!
    var currentLongitude : Double!
    var currentWeather : CurrentWeather!
    @IBOutlet weak var forecatView: NSLayoutConstraint!
    @IBOutlet weak var tempLevelsVIew: NSLayoutConstraint!
    var currentForecastList = [Forecast]()
    @IBOutlet weak var btnSaveLocation: UIButton!
    
    @IBOutlet weak var imgWeatherBackground: UIImageView!
    
    @IBOutlet weak var lblWeatherDescription: UILabel!
    @IBOutlet weak var currentTempView: NSLayoutConstraint!
    @IBOutlet weak var mainForecastStack: UIStackView!
    @IBOutlet weak var mainTempConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblMainTemp: UILabel!
    
    @IBOutlet weak var lblMinTemp: UILabel!
    
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    
    
    var progressVC : ProgressVC!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewBasedOnWeather(.DEFAULT)
        
        
        lblMainTemp.font = weather_font(size: 50, .bold)
        lblMinTemp.font = weather_font(size: 16, .semibold)
        lblCurrentTemp.font = weather_font(size: 16, .semibold)
        lblMaxTemp.font = weather_font(size: 16, .semibold)
        lblWeatherDescription.font = weather_font(size: 30, .semibold)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentTempView.constant = view.bounds.height * 0.40
        tempLevelsVIew.constant = view.bounds.height * 0.08
        forecatView.constant  = view.bounds.height * 0.32
        mainTempConstraint.constant = currentTempView.constant * 0.1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progressVC = storyboard?.instantiateViewController(withIdentifier: "ProgressVC") as? ProgressVC
        showProgressDialog(.PROGRESS_INDICATOR,text: "loading current weather")
        setUpLocationManager()
    }
    
    func showProgressDialog(_ type:ProgressType,text : String ){
        progressVC.type = type
        progressVC.modalTransitionStyle = .crossDissolve
        progressVC.modalPresentationStyle = .overCurrentContext
        progressVC.delegate = self
        progressVC.text = text
        present(progressVC, animated: true, completion: nil)
    }
    
    func viewBasedOnWeather(_ type : WeatherType){
        
        let weatherView = BACKGROUND_THEMES[type]!
        themeColor = UIColor(named : weatherView[.COLOR]!)
        self.view.backgroundColor = themeColor
        self.imgWeatherBackground.image = UIImage(named: weatherView[.IMAGE]!)
    }
    
    @IBAction func btnTapped(_ sender: UIButton) {
        
        switch sender.tag {
            case 1 :
                let vc = storyboard?.instantiateViewController(withIdentifier: "SavedListVC") as! SavedListVC
                vc.themeColor = themeColor
                vc.delegate = self
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overCurrentContext
                present(vc, animated: true, completion: nil)
                break
            case 2:
            if(currentWeather != nil){
                locationRepo.saveLocationFor(lat: currentLatitude, lon: currentLongitude, weather: currentWeather){
                    saved in
                    
                    let message = saved ? "Saved Location As Favourite" :"Saved Location As Favourite"
                
                    showProgressDialog(.DIALOG,text:message)
                        
                }
            }
            break
            default : break
        }
        
    }
    func didSelectLocation(location: SavedLocation){
        showProgressDialog(.PROGRESS_INDICATOR,text: "loading current weather for \(location.city!)")
        getCurrentWeatherForLocation(lat: location.lat, lon: location.lon)
    }
    func didProgressTapReload() {
        progressVC.lblProgress.text = "loading current weather"
        let coord : CLLocationCoordinate2D = locationManager.location!.coordinate
        
        getCurrentWeatherForLocation(lat: coord.latitude, lon: coord.longitude)
    }
    private func getCurrentWeatherForLocation(lat : Double,lon : Double ){
        WeatherCalls.shared.currentWeather(latitude: lat, longitude: lon){
            result  in
            DispatchQueue.main.async {
                if let currentWeather = result as? CurrentWeather {
                    self.currentLatitude = lat
                    self.currentLongitude = lon
                    self.currentWeather = currentWeather
                    self.lblMainTemp.text = "\(currentWeather.temp)°"
                    self.lblMaxTemp.text = "\(currentWeather.maxTemp)°"
                    self.lblCurrentTemp.text = "\(currentWeather.temp)°"
                    self.lblMinTemp.text = "\(currentWeather.minTemp)°"
                    self.lblWeatherDescription.text = "\(currentWeather.weatherType)"
                    self.viewBasedOnWeather(currentWeather.weatherType)
                    self.progressVC.dismiss(animated: true){
                        [self] in
                        self.progressVC.lblProgress.text = ""
                    }
                    self.getForecastForLocation(lat: lat, lon: lon)
                }else{
                    self.progressVC.shouldStopOnError(withText: "Failed To Load Current Weather.Please Check Internet Connection and try again!")
                }
            }
            
            
        }
        
    }
    private func getForecastForLocation(lat : Double,lon : Double){
        self.progressVC.lblProgress.text = "Loading Forecast"
        WeatherCalls.shared.forecast(latitude: lat, longitude: lon){
            result in
            
            if let forecastList = result as? [Forecast] {
                
                let forecastDict = Dictionary(grouping: forecastList, by: {
                    Calendar(identifier: .gregorian).component(.weekday, from: $0.day)
                }).filter{
                    $0.key != Calendar(identifier: .gregorian).component(.weekday, from: Date.now)}
                
                DispatchQueue.main.async {
                    for subview in self.mainForecastStack.arrangedSubviews {
                        subview.removeFromSuperview()
                    }
                    for i in forecastDict.keys.sorted() {
                        
                        let forecast = forecastDict[i]![0]
                        self.mainForecastStack.addArrangedSubview(ForecastView(frame: CGRect.zero,
                                                                               forecast: forecast))
                        //self.progressVC.dismiss(animated: true, completion: nil)
                    }
                }
                
            }else {
                self.progressVC.shouldStopOnError(withText: "Failed To Load Weather Forecast.Please Check Internet Connection and try again!")
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

