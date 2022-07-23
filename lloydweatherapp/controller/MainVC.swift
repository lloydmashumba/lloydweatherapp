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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(named : "sea_cloudy_color")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentTempView.constant = view.bounds.height / 2
    }

}

