//
//  SearchBusCell.swift
//  MaxPay
//
//  Created by india on 05/12/23.
//

import UIKit

class SearchBusCell: UITableViewCell {

    @IBOutlet weak var btnTomorrowDate: UIButton!
    @IBOutlet weak var btnTodayDate: UIButton!
    @IBOutlet weak var lblDepatureDate: UILabel!
    @IBOutlet weak var btnDepature: UIButton!
    @IBOutlet weak var txtTo: UITextField!
    @IBOutlet weak var txtFrom: UITextField!
    @IBOutlet weak var btnTo: UIButton!
    @IBOutlet weak var btnFrom: UIButton!
    @IBOutlet weak var txtDepatureDate: UITextField!
    @IBOutlet weak var btnSearchBus: UIButton!
    @IBOutlet weak var vwSearchBus: UIView!
    @IBOutlet weak var vwDate: UIView!
    @IBOutlet weak var vwSqure: UIView!
    @IBOutlet weak var vwLocation: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwLocation.layer.applyCornerRadiusShadowGreen()
        vwLocation.layer.cornerRadius = 4
        vwLocation.layer.borderColor = UIColor(hexString: "9FC438").cgColor
        vwLocation.layer.borderWidth = 1
        
        vwDate.layer.applyCornerRadiusShadowGreen()
        vwDate.layer.cornerRadius = 4
        vwDate.layer.borderColor = UIColor(hexString: "9FC438").cgColor
        vwDate.layer.borderWidth = 1
        
        vwSearchBus.layer.applyCornerRadiusShadow()
        vwSearchBus.layer.cornerRadius = 10
//        vwSearchBus.layer.applyCornerRadiusShadowGreen()
//        vwSearchBus.layer.cornerRadius = 10
//        vwSearchBus.layer.borderColor = UIColor(hexString: "9FC438").cgColor
//        vwSearchBus.layer.borderWidth = 1
        
        vwSqure.layer.cornerRadius = 2
        vwSqure.layer.borderColor = UIColor(hexString: "9FC438").cgColor
        vwSqure.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
