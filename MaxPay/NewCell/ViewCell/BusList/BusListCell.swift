//
//  BusListCell.swift
//  MaxPay
//
//  Created by india on 05/12/23.
//

import UIKit
import SwiftyJSON

class AmenitiesCell: UICollectionViewCell {
    @IBOutlet weak var imgAmenities: UIImageView!
}

class BusListCell: UITableViewCell, UICollectionViewDataSource {

    
    @IBOutlet weak var lblFreeCancellation: UILabel!
    @IBOutlet weak var lblLiveTracking: UILabel!
    @IBOutlet weak var lblTotalSeat: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblTotalHrs: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    
    @IBOutlet weak var lblStartLocation: UILabel!
    @IBOutlet weak var lblEndLocation: UILabel!
    
    @IBOutlet weak var lblBusRate: UILabel!
    @IBOutlet weak var lblBusType: UILabel!
    @IBOutlet weak var lblBusName: UILabel!
    @IBOutlet weak var vwstackStar: UIStackView!
    @IBOutlet weak var vwRate: UIView!
    @IBOutlet weak var vwBack: UIView!
    
    @IBOutlet weak var btnCancellationPolicy: UIButton!
    @IBOutlet weak var btnBoardingPoint: UIButton!
    @IBOutlet weak var btnDroppingPoint: UIButton!
    
    @IBOutlet weak var collectionAmenities: UICollectionView!
    
    var lstAmenities = [JSON]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        vwBack.layer.applyCornerRadiusShadow()
//        vwBack.layer.cornerRadius = 4
//        vwBack.layer.borderColor = UIColor.lightGray.cgColor
//        vwBack.layer.borderWidth = 1
//        vwRate.clipsToBounds = true
//        vwRate.layer.cornerRadius = 4    
                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lstAmenities.count > 5 ? 5 : lstAmenities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AmenitiesCell
        
        if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("water") {
            cell.imgAmenities.image = UIImage(named: "Water-Bottle")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("blanket") {
            cell.imgAmenities.image = UIImage(named: "Blanket")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("ac") {
            cell.imgAmenities.image = UIImage(named: "AC")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("charging") {
            cell.imgAmenities.image = UIImage(named: "Charging-Point")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("fire") {
            cell.imgAmenities.image = UIImage(named: "Fire-Extinguisher")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("light") {
            cell.imgAmenities.image = UIImage(named: "Reading-Light")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("gps") {
            cell.imgAmenities.image = UIImage(named: "GPS-Tracking")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("aid") {
            cell.imgAmenities.image = UIImage(named: "First-Aid-Box")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("sanitizer") {
            cell.imgAmenities.image = UIImage(named: "Hand-Sanitizer")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("staff") {
            cell.imgAmenities.image = UIImage(named: "Staff")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("wifi") {
            cell.imgAmenities.image = UIImage(named: "WiFi")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("pillow") {
            cell.imgAmenities.image = UIImage(named: "Pillow")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("exit") {
            cell.imgAmenities.image = UIImage(named: "Emergency-Exit")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("hammer") {
            cell.imgAmenities.image = UIImage(named: "Hammer")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("tv") {
            cell.imgAmenities.image = UIImage(named: "TV")
        } else if lstAmenities[indexPath.row]["name"].stringValue.lowercased().contains("toilet") {
            cell.imgAmenities.image = UIImage(named: "Toilet")
        }
        
        return cell
    }
    
}
