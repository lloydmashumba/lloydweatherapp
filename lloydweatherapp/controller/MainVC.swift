//
//  ViewController.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 22/7/2022.
//

import UIKit
import SwiftUI

class MainVC: UIViewController {

    
    @IBOutlet weak var currentTempView: NSLayoutConstraint!
    
    @IBOutlet weak var mainForecastStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(named : "sea_cloudy_color")
        
        let days = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
        
        
        for i in 0...(days.count - 1) {
            mainForecastStack.addArrangedSubview(ForecastView(frame: CGRect.zero,day: days[i],temperature: 45))
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentTempView.constant = view.bounds.height / 2
    }

}

