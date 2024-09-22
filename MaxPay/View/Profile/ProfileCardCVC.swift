//
//  ProfileCardCVC.swift
//  MaxPay
//
//  Created by Ios Developer on 25/05/24.
//

import UIKit

class ProfileCardCVC: UICollectionViewCell {

    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var btnManage: DesignableButton!
    
    @IBOutlet weak var btnClickProfile: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgBack.layer.applyCornerRadiusShadow()
        
        
        
        btnManage.layer.cornerRadius = 12
       // btnLogout.clipsToBounds = true
       // btnManage.layer.masksToBounds = true
        
        
        btnManage.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        //btnManage.layer.shadowColor = UIColor.lightGray.cgColor
       // btnManage.layer.shadowOpacity = 0.8
        //btnManage.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
       // btnManage.layer.shadowRadius = 6.0
        btnManage.layer.masksToBounds = false
        
        

        
    }

}
