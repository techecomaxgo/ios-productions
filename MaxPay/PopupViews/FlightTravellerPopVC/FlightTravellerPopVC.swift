//
//  FlightTravellerPopVC.swift
//  MaxPay
//
//  Created by Admin on 05/07/24.
//

protocol popPassengerSelectedDelegate {
    
    func popPassengersSelected(totalAdults:Int,totalChildren:Int,totalInfrant:Int)
    
}



import UIKit

class FlightTravellerPopVC: UIViewController {

    var delegatePopPassengers : popPassengerSelectedDelegate?

    
    var totalAdultsStr = 0
    var totalChildrenStr = 0
    var totalInfantsStr = 0
    
    
    // Variables to hold the counts
    var adultCount = 1
    var childCount = 0
    var infantCount = 0

    
    

    @IBOutlet weak var adultCountLabel: UILabel!
    
    @IBOutlet weak var childCountLabel: UILabel!
    
    @IBOutlet weak var infantCountLabel: UILabel!
    
    
    @IBOutlet var bgView_ctrl: UIView!
    
    @IBOutlet weak var popView_Ctrl: UIView!
    
    
    @IBOutlet weak var btnAddAdult: UIButton!
    
    @IBOutlet weak var btnAddChild: UIButton!
    
    @IBOutlet weak var btnAddInfants: UIButton!
    
    
    @IBOutlet weak var btnMinusAdult: UIButton!
    
    @IBOutlet weak var btnMinusChild: UIButton!
    
    @IBOutlet weak var btnMinusInfants: UIButton!
    
    
    @IBOutlet weak var btnDone: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.bgView_ctrl.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        popView_Ctrl.layer.cornerRadius = 25
        popView_Ctrl.layer.borderWidth = 1.0
        popView_Ctrl.layer.borderColor = UIColor.white.cgColor
        popView_Ctrl.clipsToBounds = true
        
        btnDone.layer.cornerRadius = 10

        
        
        
        
        // Add tap gesture recognizer to the background view
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
//        bgView_ctrl.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        btnAddAdult.addTarget(self, action: #selector(didTapClickbtnAddAdult(sender:)), for: .touchUpInside)
        
        btnAddChild.addTarget(self, action: #selector(didTapClickbtnAddChildren(sender:)), for: .touchUpInside)
        
        btnAddInfants.addTarget(self, action: #selector(didTapClickbtnAddInfrant(sender:)), for: .touchUpInside)

        
        btnMinusAdult.addTarget(self, action: #selector(didTapClickbtnMinusAdult(sender:)), for: .touchUpInside)
        
        btnMinusChild.addTarget(self, action: #selector(didTapClickbtnMinusChild(sender:)), for: .touchUpInside)
        
        btnMinusInfants.addTarget(self, action: #selector(didTapClickbtnMinusInfants(sender:)), for: .touchUpInside)
        
        
        updateLabels()
        
    }
    
    
    
    // Function to update the labels
        func updateLabels() {
            adultCountLabel.text = "\(adultCount)"
            childCountLabel.text = "\(childCount)"
            infantCountLabel.text = "\(infantCount)"
        }
    
    
    @objc func didTapClickbtnAddAdult(sender: UIButton) {
        
                adultCount += 1
                updateLabels()
        
    }
    
    @objc func didTapClickbtnAddChildren(sender: UIButton) {
        
                childCount += 1
                updateLabels()
        
    }
    
    @objc func didTapClickbtnAddInfrant(sender: UIButton) {
        
        infantCount += 1
        updateLabels()
        
    }
    
    
    @objc func didTapClickbtnMinusAdult(sender: UIButton) {
        
        if adultCount > 1 {
                    adultCount -= 1
                    updateLabels()
                }
        
    }
    
    @objc func didTapClickbtnMinusChild(sender: UIButton) {
        
        if childCount > 0 {
                    childCount -= 1
                    updateLabels()
                }
        
        
    }
    
    @objc func didTapClickbtnMinusInfants(sender: UIButton) {
        
        if infantCount > 0 {
                    infantCount -= 1
                    updateLabels()
                }
        
    }
    
    
    
    
    
    func initialViewSetUp() {
        
    }
    
    
    @objc func dismissPopup() {
            // Dismiss the popup and background view
           removeAnimate()
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
    
    
    
    
    
    
    
    

    
    @IBAction func btnDoneClicked(_ sender: UIButton) {
        
        
        delegatePopPassengers?.popPassengersSelected(totalAdults: adultCount, totalChildren: childCount, totalInfrant: infantCount)
        removeAnimate()
        
        
    }
    
    @IBAction func btnOutsideAreaClicked(_ sender: UIButton) {
        
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
