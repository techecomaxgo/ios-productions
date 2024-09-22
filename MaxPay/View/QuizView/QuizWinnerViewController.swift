//
//  QuizWinnerViewController.swift
//  MaxPay
//
//  Created by Ios Developer on 22/05/24.
//

import UIKit

class QuizWinnerViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var stackHeightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var btnBack: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        stackHeightConstant.constant = 70
        
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
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
