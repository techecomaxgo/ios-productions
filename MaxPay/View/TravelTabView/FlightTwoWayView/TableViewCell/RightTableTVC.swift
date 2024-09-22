//
//  RightTableTVC.swift
//  MaxPay
//
//  Created by Admin on 10/07/24.
//

import UIKit

class RightTableTVC: UITableViewCell {

    
    
    @IBOutlet weak var airlineLabel: UILabel!
    
    @IBOutlet weak var viewBackCell: UIView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var lblDepartTime: UILabel!
    
    @IBOutlet weak var lblArrivalTime: UILabel!
  
    @IBOutlet weak var lblduration: UILabel!
    
    @IBOutlet weak var lblStopCount: UILabel!
    
    @IBOutlet weak var imgFlightBrand: UIImageView!
    
    
    var  bondsArr : [Bonds]?
    
    var legsArr : [Legs]?
    
    var fareDict : Fare?
    
    var imgUrl = ""
    
    var defaultStateColor:UIColor?
    var hitStateColor:UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        defaultStateColor = UIColor.white

        hitStateColor =  UIColor(red: 0.99, green: 0.99, blue: 0.96, alpha: 1.00)
        
        
        viewBackCell.addViewBorder(borderColor: UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00).cgColor, borderWith: 1, borderCornerRadius: 0)
        
        
    }

    
    
    func setRightCellData(rightTableCellData: Segments?) {
        
        print(rightTableCellData!)
        
        bondsArr = []
        legsArr =  []
        
        fareDict = rightTableCellData?.fare
        
        bondsArr = rightTableCellData?.bonds
        
        legsArr = bondsArr?[0].legs
        
        airlineLabel.text = legsArr?[0].flightName ?? ""
        
        lblDepartTime.text = legsArr?[0].departureTime ?? ""
        
        lblArrivalTime.text = legsArr?[0].arrivalTime ?? ""
        
        if legsArr?[0].numberOfStops == "0"{
            
            lblduration.text = "\(legsArr?[0].duration ?? "")"
            lblStopCount.text = "\("Non-Stop")"
            
        } else if  legsArr?[0].numberOfStops == "1"{
         
            lblduration.text = "\(legsArr?[0].duration ?? "")"
            lblStopCount.text = "\("1 Stop")"
            

        } else if  legsArr?[0].numberOfStops == "2"{
            
            lblduration.text = "\(legsArr?[0].duration ?? "")"
            lblStopCount.text = "\("2 Stop")"
            

        }else if  legsArr?[0].numberOfStops == "3"{
            
            lblduration.text = "\(legsArr?[0].duration ?? "")"
            lblStopCount.text = "\("3 Stop")"
            
            

        }else if  legsArr?[0].numberOfStops == "4"{
            
            
            lblduration.text = "\(legsArr?[0].duration ?? "")"
            lblStopCount.text = "\("4 Stop")"
            

        }
        else{
            
            
        }
        
        priceLabel.text = "₹ \(fareDict?.totalTaxWithOutMarkUp ?? 0)"
        
        imgUrl = "https://flight.easemytrip.com/Content/AirlineLogon/\(legsArr?[0].aircraftCode ?? "").png"
        
        print("aircraftCode",legsArr?[0].aircraftCode ?? "")
        print("imgUrl",imgUrl)
        imgFlightBrand.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "itemPlaceholder.png"),options: [.refreshCached])

        
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    

}
