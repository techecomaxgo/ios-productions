//
//  PassengersTVC.swift
//  MaxPay
//
//  Created by Admin on 07/07/24.
//

import UIKit

class PassengersTVC: UITableViewCell {

    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lblmobile: UILabel!
    
    @IBOutlet weak var cellTableCheckBox: UIButton!
    
//    var passengersModel = [PassengersModel]()
//    
//    var selectedPassengers = [PassengersModel]()
    
    var passengersModel: PassengersModel? {
            didSet {
                guard let passenger = passengersModel else { return }
           
                lblname.text = "\(passenger.firstName) \(passenger.lastName), \(passenger.age) years"
                lblmobile.text = "\(passenger.phone)"
                cellTableCheckBox.isSelected = passenger.isSelected
                
            }
        }

 

    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        
     
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }

}


