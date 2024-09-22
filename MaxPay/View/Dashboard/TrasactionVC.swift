//
//  TrasactionVC.swift
//  TabbarDemo
//
//  Created by Susant Nahak on 04/11/23.
//

import UIKit

class TrasactionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewController = TasactionPieChartVC(nibName: "TasactionPieChartVC", bundle: nil)
        present(viewController, animated: true)
    }
    
    
   
    

    
    @IBAction func btnListAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let vc = storyBoard.instantiateViewController(withIdentifier: "TrsactionlistVC") as! TrsactionlistVC
         self.navigationController?.pushViewController(vc, animated: true)
    }
    


}
