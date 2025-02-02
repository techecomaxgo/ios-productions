//
//  UserDetailTableViewCell.swift
//  MaxPay
//
//  Created by Admin on 29/01/25.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {

   
    @IBOutlet weak var lblGoodMorning: UILabel!
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
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"  // 24-hour format (Use "hh:mm:ss a" for 12-hour)
        let currentTime = formatter.string(from: Date())
        let currentHour = Calendar.current.component(.hour, from: Date())

        if (0...12).contains(currentHour) {
            lblGoodMorning.text = "Good Morning!"
        } else if (12...18).contains(currentHour){
            lblGoodMorning.text = "Good Afternoon!"
        } else if (18...21).contains(currentHour){
            lblGoodMorning.text = "Good Evening!"
        } else {
            lblGoodMorning.text = "🌙 Bye Bye!"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view fo.ar the selected state
    }
    
}

