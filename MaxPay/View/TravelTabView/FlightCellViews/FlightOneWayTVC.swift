//
//  FlightOneWayTVC.swift
//  MaxPay
//
//  Created by Admin on 06/07/24.
//

import UIKit

class FlightOneWayTVC: UITableViewCell {

    
    @IBOutlet weak var lblTimeStop: UILabel!
    
    @IBOutlet weak var lblFrom: UILabel!
    
    @IBOutlet weak var lblTo: UILabel!
    
    @IBOutlet weak var lblFlightCompany: UILabel!
    
    @IBOutlet weak var lblFlightFare: UILabel!
    
    @IBOutlet weak var imgFlightPic: UIImageView!
    
    var  bondsArr : [Bonds]?
    
    var legsArr : [Legs]?
    
    var fareDict : Fare?
    
    var imgUrl = ""
    
    var defaultStateColor:UIColor?
    var hitStateColor:UIColor?
    
    
    @IBOutlet weak var viewCellBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        defaultStateColor = UIColor.white

        hitStateColor =  UIColor(red: 0.99, green: 0.99, blue: 0.96, alpha: 1.00)
        
        
        viewCellBack.addViewBorder(borderColor: UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00).cgColor, borderWith: 1, borderCornerRadius: 0)
        
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            if selected {
                viewCellBack.backgroundColor =  hitStateColor
            } else {
                viewCellBack.backgroundColor =  defaultStateColor
            }
        }

   
    
    func setoneWayCellData(oneWayCellData: Segments?) {
        
        print(oneWayCellData!)
        
        bondsArr = []
        legsArr =  []
        
        fareDict = oneWayCellData?.fare
        
        bondsArr = oneWayCellData?.bonds
        
        
        
        
        legsArr = bondsArr?[0].legs
        
        lblFlightCompany.text = legsArr?[0].flightName ?? ""
        
        lblFrom.text = legsArr?[0].departureTime ?? ""
        
        lblTo.text = legsArr?[0].arrivalTime ?? ""
        
        if legsArr?[0].numberOfStops == "0"{
            
            lblTimeStop.text = "\(legsArr?[0].duration ?? "") \(" | ") \("Non-Stop")"
            
        } else if  legsArr?[0].numberOfStops == "1"{
         
            lblTimeStop.text = "\(legsArr?[0].duration ?? "") \(" | ") \("1 Stop")"

        } else if  legsArr?[0].numberOfStops == "2"{
            
            lblTimeStop.text = "\(legsArr?[0].duration ?? "") \(" | ") \("2 Stop")"

        }else if  legsArr?[0].numberOfStops == "3"{
            
            lblTimeStop.text = "\(legsArr?[0].duration ?? "") \(" | ") \("3 Stop")"

        }else if  legsArr?[0].numberOfStops == "4"{
            
            lblTimeStop.text = "\(legsArr?[0].duration ?? "") \(" | ") \("4 Stop")"

        }
        else{
            
            
        }
        
        lblFlightFare.text = "₹ \(fareDict?.totalTaxWithOutMarkUp ?? 0)"
        
        imgUrl = "https://flight.easemytrip.com/Content/AirlineLogon/\(legsArr?[0].aircraftCode ?? "").png"
        
        print("aircraftCode",legsArr?[0].aircraftCode ?? "")
        print("imgUrl",imgUrl)
        imgFlightPic.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "itemPlaceholder.png"),options: [.refreshCached])

        
        //oneWayCellData
        
      //  lblOperator.text = "\(operatorCellData?.operator_name ?? "") \(operatorCellData?.service_type ?? "")"
        
//        lblName.text = rankCellData?.full_name ?? ""
//        
//        lblRank.text = "\(rankCellData?.rank ?? 0)"
//        
//        lblSpent.text = "₹\(rankCellData?.spent ?? 0)"
//        
        
        
    }
    
    

   

}
