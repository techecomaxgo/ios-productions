//
//  RankTVC.swift
//  MaxPay
//
//  Created by Admin on 31/05/24.
//

import UIKit

class RankTVC: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var viewTwoSideCorner: UIView!
    @IBOutlet weak var lblSpent: UILabel!
    
    @IBOutlet weak var viewBg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewTwoSideCorner.layer.cornerRadius = 10
                
                // Apply to specific corners
        viewTwoSideCorner.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner] // Top-left & Top-right
                
        viewTwoSideCorner.layer.masksToBounds = true
    }
    
    func setRankCellData(rankCellData: Allrank?) {
        
      print(rankCellData)
      //  lblOperator.text = "\(operatorCellData?.operator_name ?? "") \(operatorCellData?.service_type ?? "")"
        
        lblName.text = rankCellData?.full_name ?? ""
        
        lblRank.text = "\(rankCellData?.rank ?? 0)"
        
        lblSpent.text = "₹*****/-"//\(rankCellData?.spent ?? 0)"
        
        
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
