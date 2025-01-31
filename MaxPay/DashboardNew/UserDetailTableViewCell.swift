//
//  UserDetailTableViewCell.swift
//  MaxPay
//
//  Created by Admin on 29/01/25.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {

   
    @IBOutlet weak var imgMaxLogo: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblCardNo: UILabel!
    @IBOutlet weak var lblRank: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgMaxLogo.layer.shadowColor = UIColor.black.cgColor
        imgMaxLogo.layer.shadowOpacity = 0.3
        imgMaxLogo.layer.shadowOffset = CGSize(width: 1, height: 1)
        imgMaxLogo.layer.shadowRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view fo.ar the selected state
    }
    
}

