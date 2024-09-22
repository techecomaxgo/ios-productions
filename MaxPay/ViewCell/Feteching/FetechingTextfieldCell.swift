//
//  FetechingTextfieldCell.swift
//  MaxPay
//
//  Created by india on 21/11/23.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func didTapButton(at indexPath: IndexPath)
}


class FetechingTextfieldCell: UITableViewCell {

    @IBOutlet weak var txtName: UITextField!
    weak var delegate: CustomCellDelegate?
    var indexPath: IndexPath!
    var cust_params_data: Cust_params_data?
    
    func setCustParamsData(cust_params_data: Cust_params_data) {
        
        txtName.placeholder = self.cust_params_data?.customParamName ?? ""
        
    }
    
    // Additional method to handle validation logic elsewhere, such as on a button press
    func validateConsumerNumber() -> Bool {
        guard let consumerNumber = txtName.text, !consumerNumber.isEmpty else {
            // Consumer number is required
            return false
        }
        
        // Check if the length is within the specified range
        let minLength = 9
        let maxLength = 9
        let isLengthValid = consumerNumber.count >= minLength && consumerNumber.count <= maxLength
        
        if isLengthValid {
            // Additional validation logic if needed
            return true
        } else {
            // Consumer number length is not within the specified range
            return false
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
