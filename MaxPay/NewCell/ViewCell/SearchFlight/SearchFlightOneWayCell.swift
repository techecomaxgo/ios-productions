//
//  SearchFlightOneWayCell.swift
//  MaxPay
//
//  Created by india on 24/11/23.
//

import UIKit

class SearchFlightOneWayCell: UITableViewCell {

    @IBOutlet weak var vwSearch: UIView!
    @IBOutlet weak var vwClassBack: UIView!
    @IBOutlet weak var vwTeavellerBack: UIView!
    @IBOutlet weak var vwReturnBack: UIView!
    @IBOutlet weak var vwCircle: UIView!
    @IBOutlet weak var vwToBack: UIView!
    @IBOutlet weak var vwFrom: UIView!
    @IBOutlet weak var vwDepatureDateBack: UIView!
    @IBOutlet weak var vwFromBack: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vwSearch.layer.applyCornerRadiusShadow()
        vwFromBack.layer.cornerRadius = 4
        vwFrom.layer.applyCornerRadiusShadowGreen()
        vwFromBack.layer.cornerRadius = 4
        vwFromBack.layer.borderColor = UIColor(hexString: "9FC438").cgColor
        vwFromBack.layer.borderWidth = 1
        
        vwToBack.layer.applyCornerRadiusShadowGreen()
        vwToBack.layer.cornerRadius = 4
        vwToBack.layer.borderColor = UIColor(hexString: "9FC438").cgColor
        vwToBack.layer.borderWidth = 1
        
        vwCircle.layer.applyCornerRadiusShadowGreen()
        vwCircle.layer.cornerRadius = 15
        vwCircle.layer.borderColor = UIColor(hexString: "9FC438").cgColor
        vwCircle.layer.borderWidth = 1
        
        vwDepatureDateBack.layer.applyCornerRadiusShadowGreen()
        vwDepatureDateBack.layer.cornerRadius = 4
        vwDepatureDateBack.layer.borderColor = UIColor(hexString: "9FC438").cgColor
        vwDepatureDateBack.layer.borderWidth = 1
        
        vwReturnBack.layer.applyCornerRadiusShadowGreen()
        vwReturnBack.layer.cornerRadius = 4
        vwReturnBack.layer.borderColor = UIColor(hexString: "9FC438").cgColor
        vwReturnBack.layer.borderWidth = 1
        
        vwTeavellerBack.layer.applyCornerRadiusShadowGreen()
        vwTeavellerBack.layer.cornerRadius = 4
        vwTeavellerBack.layer.borderColor = UIColor(hexString: "9FC438").cgColor
        vwTeavellerBack.layer.borderWidth = 1
        
        vwClassBack.layer.applyCornerRadiusShadowGreen()
        vwClassBack.layer.cornerRadius = 4
        vwClassBack.layer.borderColor = UIColor(hexString: "9FC438").cgColor
        vwClassBack.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
