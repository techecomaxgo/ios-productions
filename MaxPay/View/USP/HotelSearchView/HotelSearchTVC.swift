//
//  HotelSearchTVC.swift
//  MaxPay
//
//  Created by Admin on 03/06/24.
//

import UIKit

import Cosmos

import SDWebImage


class HotelSearchTVC: UITableViewCell {

    
    @IBOutlet weak var imgHotel: UIImageView!
    
    @IBOutlet weak var cosmosViewHalf: CosmosView!
    
    @IBOutlet weak var lblHotelname: UILabel!
    
    @IBOutlet weak var lblHotelLocation: UILabel!
    
    @IBOutlet weak var lblFreeCancel: UILabel!
    
    @IBOutlet weak var lblPerNight: UILabel!
    
    @IBOutlet weak var lblTaxes: UILabel!
    
    @IBOutlet weak var lblRealPrice: UILabel!
    
    @IBOutlet weak var lblDefaultPrice: UILabel!
    
    @IBOutlet weak var viewBackHotel: UIView!
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        
        viewBackHotel.layer.applyCornerRadiusShadow()
        
    }
    
    
    func setHotelListData(hotelListData: Hotellist?) {
        
        
        var originalPrice = NSMutableAttributedString(string: "\(hotelListData?.totalPrice ?? 0)", attributes: [
            NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.foregroundColor: UIColor.red
        ])

        
        
        lblDefaultPrice.attributedText = originalPrice
        
        // "+ ₹290 Taxes & Fees"
        
        lblTaxes.text = "+ ₹\(hotelListData?.surchargeTotal ?? 0) Taxes & Fees"

        
       // print("hotelListData :",hotelListData)
        
        lblHotelname.text = "\(hotelListData?.hotelName ?? "")"
        lblHotelLocation.text = "\(hotelListData?.location ?? ""),\(hotelListData?.city ?? "")"
        
        lblRealPrice.text = "₹\(hotelListData?.price ?? 0)"
        
        imgHotel.image = nil // Clear the old image
        imgHotel.layer.applyCornerRadiusShadow()

        
        imgHotel.sd_setImage(with: URL(string: hotelListData?.imageThumbUrl ?? ""), placeholderImage: UIImage(named: "hotelsamplePic.png"),options: [.refreshCached])
        

        cosmosViewHalf.rating = Double(hotelListData?.rating ?? "") ?? 0.0
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    

}
