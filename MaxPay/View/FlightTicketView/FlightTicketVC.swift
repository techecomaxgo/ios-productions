//
//  FlightTicketVC.swift
//  MaxPay
//
//  Created by Admin on 15/07/24.
//

import UIKit

class FlightTicketVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        if let viewControllers = navigationController?.viewControllers {
                   for viewController in viewControllers {
                       if let viewControllerA = viewController as? TravelTabViewController {
                           navigationController?.popToViewController(viewControllerA, animated: true)
                           break
                       }
                   }
               }
        
        
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
