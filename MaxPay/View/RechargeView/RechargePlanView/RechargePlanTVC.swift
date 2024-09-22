//
//  RechargePlanTVC.swift
//  MaxPay
//
//  Created by Ios Developer on 16/05/24.
//

import UIKit

class RechargePlanTVC: UITableViewCell {
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblValidity: UILabel!
    
    @IBOutlet weak var lblRData: UILabel!
    
    @IBOutlet weak var lblDescrip: UILabel!
    
    @IBOutlet weak var lblBottomDesp: UILabel!
    
    @IBOutlet weak var lblBottomMore: UILabel!
    
    @IBOutlet weak var lblBottomImg: UIImageView!
    
    @IBOutlet weak var viewBackground: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBackground.layer.applyCornerRadiusShadow()
    }
    
    
    func setTopUpDataData(topUpData: TOPUP?) {
        
        print(topUpData)
        lblPrice.text = "\(topUpData?.rs ?? 0)"
        lblValidity.text = topUpData?.validity
        lblDescrip.text = topUpData?.desc
        
        
    }
    
    func setAllData(topUpData: DATA?) {
        
        print(topUpData)
        lblPrice.text = "\(topUpData?.rs ?? 0)"
        lblValidity.text = topUpData?.validity
        lblDescrip.text = topUpData?.desc
        
        
    }
    
    func setFULLData(topUpData: FULLTT?) {
        
        print(topUpData)
        lblPrice.text = "\(topUpData?.rs ?? 0)"
        lblValidity.text = topUpData?.validity
        lblDescrip.text = topUpData?.desc
        
        
    }
    
    func setFRCData(topUpData: FRC?) {
        
        print(topUpData as Any)
        lblPrice.text = "\(topUpData?.rs ?? 0)"
        lblValidity.text = topUpData?.validity
        lblDescrip.text = topUpData?.desc
        
        
    }
    
    
    func setRomDataData(topUpData: Romaing?) {
        
        print(topUpData as Any)
        lblPrice.text = "\(topUpData?.rs ?? 0)"
        lblValidity.text = topUpData?.validity
        lblDescrip.text = topUpData?.desc
        
        
    }
    
    
   
    
    func setJioPhData(topUpData: JioPhone?) {
        
        print(topUpData as Any)
        lblPrice.text = "\(topUpData?.rs ?? 0)"
        lblValidity.text = topUpData?.validity
        lblDescrip.text = topUpData?.desc
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
