//
//  ViewController.swift
//  SKToast
//
//  Created by SachK13 on 12/29/2017.
//  Copyright (c) 2017 SachK13. All rights reserved.
//

import UIKit
import SKToast

class ViewController: UIViewController {
    
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SKToast.backgroundStyle(.light)
        SKToast.messageTextColor(UIColor.black)
        let myFont = UIFont(name: "AvenirNext-DemiBold", size: 16)
        SKToast.messageFont(myFont!)
    }
    
    
    // MARK: - SKToast Styles
    @IBAction func changeToastViewStyleButtonTapped(_ segment: UISegmentedControl) {
        
        switch segment.selectedSegmentIndex {
            
        case 1:
            SKToast.backgroundStyle(.extraLight)
            SKToast.messageTextColor(UIColor.black)
        case 2:
            SKToast.backgroundStyle(.dark)
            SKToast.messageTextColor(UIColor.white)
        default:
            SKToast.backgroundStyle(.light)
            SKToast.messageTextColor(UIColor.black)
        }
    }
    
    // MARK: - Show Toast
    @IBAction func showToastViewButtonTapped(_ sender: Any) {
        
        SKToast.show(withMessage: "Success seems to be connected with action. Successful people keep moving. They make mistakes, but they don't quit.")
        
        
        /*
         SKToast.show(withMessage: "Your internet connection appears to be offline, please check your internet connection") {
         print("Perform any task after toast disappearance.")
         }
         */
    }
}


