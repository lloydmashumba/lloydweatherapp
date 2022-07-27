//
//  ProgressVCViewController.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 27/7/2022.
//

import UIKit
//Implemented by a UIViewController that performs specific action On retry
protocol ProgressDelegate {
    func didProgressTapReload()
}
/*
 //Mark : enum for progress type
 - DIALOG - for notification
 - PROGRESS_INDICATOR - for progress eg on network
 */

enum ProgressType {
    case DIALOG,PROGRESS_INDICATOR
}

//ProgressVC indicates and shows the user the current status based on type
class ProgressVC: UIViewController {

    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnReload: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var lblProgress: UILabel!
    var text : String!
    var delegate : ProgressDelegate!
    var type : ProgressType!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //notifies user for error
    func shouldStopOnError(withText : String){
        lblProgress.text = withText
        btnReload.isHidden = false
        indicator.isHidden = true
        
    }
    //setting up the display before it appeard based on the progress type enum
    override func viewWillAppear(_ animated: Bool) {
        
        if(type == .PROGRESS_INDICATOR){
            indicator.startAnimating()
            btnClose.isHidden = true
        }else{
            btnClose.isHidden = false
            indicator.isHidden = true
        }
        btnReload.isHidden = true
        lblProgress.text = text
        lblProgress.font = weather_font(size: 20, .semibold)
        lblProgress.textColor = .white
    }
    /*
     triggers the implemented ProgressDelegate when reload is tapped
     and dismisses self when close is tapped
     */
    @IBAction func optionTapped(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            indicator.isHidden = false
            btnReload.isHidden = true
            if(!indicator.isHidden){
                indicator.startAnimating()
            }
            delegate.didProgressTapReload()
            break
        case 1:
            dismiss(animated: true){
                [self] in
                self.lblProgress.text = ""
            }
        default:break
        }
        
        
    }
    
    
}
