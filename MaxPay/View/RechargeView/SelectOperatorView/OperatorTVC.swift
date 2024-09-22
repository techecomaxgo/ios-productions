//
//  OperatorTVC.swift
//  MaxPay
//
//  Created by Ios Developer on 20/05/24.
//

import UIKit

class OperatorTVC: UITableViewCell {
    
    @IBOutlet weak var lblOperator: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setOperatorCellData(operatorCellData: Operator_Data?) {
        
        print(operatorCellData)
        
        lblOperator.text = "\(operatorCellData?.operator_name ?? "") \(operatorCellData?.service_type ?? "")"
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
