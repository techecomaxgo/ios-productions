//
//  MilestonesViewController.swift
//  MaxPay
//
//  Created by Ios Developer on 28/05/24.
//

import UIKit
import SwiftLoader

class MilestonesViewController: BaseVC {
    
    


    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            
        }else{
            
//            SwiftLoader.hide()
//            self.showErrorAlert("Please check your internet connection.")
            
        }
        
        
        
    }
    
    
    
    @IBAction func btnBackClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
