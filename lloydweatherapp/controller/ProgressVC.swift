//
//  ProgressVCViewController.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 27/7/2022.
//

import UIKit

protocol ProgressDelegate {
    func didProgressTapReload()
}
enum ProgressType {
    case DIALOG,PROGRESS_INDICATOR
}
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
    
    func shouldStopOnError(withText : String){
        lblProgress.text = withText
        btnReload.isHidden = false
        indicator.isHidden = true
        
    }
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
