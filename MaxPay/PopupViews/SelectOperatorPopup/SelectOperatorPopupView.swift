//
//  SelectOperatorPopupView.swift
//  MaxPay
//
//  Created by Ios Developer on 18/05/24.
//

import UIKit

class SelectOperatorPopupView: UIViewController, selectOperatorProtocol, selectCircleProtocol {
   
    
    
    @IBOutlet weak var txtOperator: UITextField!
    
    
    @IBOutlet weak var txtCircle: UITextField!
    
    @IBOutlet var bgView_ctrl: UIView!
    
    @IBOutlet weak var popView_Ctrl: UIView!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.bgView_ctrl.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        popView_Ctrl.layer.cornerRadius = 25
        popView_Ctrl.layer.borderWidth = 1.0
        popView_Ctrl.layer.borderColor = UIColor.white.cgColor
        popView_Ctrl.clipsToBounds = true

        // Add tap gesture recognizer to the background view
             let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        bgView_ctrl.addGestureRecognizer(tapGestureRecognizer)
        
        
    }
    
    @objc func dismissPopup() {
            // Dismiss the popup and background view
           removeAnimate()
        }
    
    
    
    func selectedCircleInfo(CircleName: String?) {
        
        txtCircle.text = CircleName
    }
    
    
    func selectedOperatorInfo(operatorName: String, serviceType: String) {
        
        txtOperator.text = "\(operatorName) \(serviceType) "
        
        //txtCircle.text = serviceType
    }
    
    
    @IBAction func btnOperatorClicked(_ sender: UIButton) {
        
        /*
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let newViewController = storyboard.instantiateViewController(withIdentifier: "NewViewControllerID") as! NewViewController
         self.present(newViewController, animated: true, completion: nil)
         Ex
         */
        
        let storyboard = UIStoryboard(name: "USP", bundle: nil)
        
        
        let newViewController = storyboard.instantiateViewController(withIdentifier: "SelectOperatorVC") as! SelectOperatorVC
        
        // Optionally configure the new view controller here
        newViewController.modalPresentationStyle = .fullScreen // or .overFullScreen, .pageSheet, etc.
        newViewController.operatorSelectDelegate = self
        // Present the view controller
        self.present(newViewController, animated: true, completion: nil)

        
        
        
    }
    
    
    @IBAction func btnCircleClicked(_ sender: UIButton) {
        
        
        let storyboard = UIStoryboard(name: "USP", bundle: nil)
        
        
        let newViewController = storyboard.instantiateViewController(withIdentifier: "CircleViewController") as! CircleViewController
        
        // Optionally configure the new view controller here
        newViewController.modalPresentationStyle = .fullScreen // or .overFullScreen, .pageSheet, etc.
        newViewController.selectCircleDelegate = self
        
        // Present the view controller
        self.present(newViewController, animated: true, completion: nil)
        
        
    }
    
    
    func showAnimate()
        
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations:
            {
                self.view.alpha = 1.0
                self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
        
    {
        UIView.animate(withDuration: 0.0, animations:
            {
                self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }

    

    
    
    
    @IBAction func btnDoneClicked(_ sender: DesignableButton) {
        
        removeAnimate()
        
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
