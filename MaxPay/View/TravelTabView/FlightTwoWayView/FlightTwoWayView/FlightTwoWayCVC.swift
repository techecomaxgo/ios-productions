//
//  FlightTwoWayCVC.swift
//  MaxPay
//
//  Created by Admin on 10/07/24.
//

import UIKit

class FlightTwoWayCVC: UICollectionViewCell {
    
    
    @IBOutlet weak var lblFromTime: UILabel!
    
    
    @IBOutlet weak var lblFromCity: UILabel!
    
    @IBOutlet weak var lblToTime: UILabel!
    
    @IBOutlet weak var lblToCity: UILabel!
    
    
    @IBOutlet weak var lblAirlineName: UILabel!
    
    @IBOutlet weak var lblFarePrice: UILabel!
    
    @IBOutlet weak var lblFlightduration: UILabel!
    
    @IBOutlet weak var lblStopCount: UILabel!
    
    @IBOutlet weak var imgCardBackPic: UIImageView!
    
    
    @IBOutlet weak var topViewflightCard: UIView!
    
    
    var  bondsArr : [Bonds]?
    
    var legsArr : [Legs]?
    
    var fareDict : Fare?
    
    var imgUrl = ""
    
    var defaultStateColor:UIColor?
    var hitStateColor:UIColor?
    
    

    func setTopCardellData(twoWayCellData: Segments?) {
        
        print(twoWayCellData!)
        
        bondsArr = []
        legsArr =  []
        
        fareDict = twoWayCellData?.fare
        
        bondsArr = twoWayCellData?.bonds
        
        legsArr = bondsArr?[0].legs
        

        
        lblAirlineName.text = legsArr?[0].flightName ?? ""
        
        
        lblFromTime.text = legsArr?[0].departureTime ?? ""
        
        lblToTime.text = legsArr?[0].arrivalTime ?? ""
        
        if legsArr?[0].numberOfStops == "0"{
            
            lblFlightduration.text = "\(legsArr?[0].duration ?? "")"
            lblStopCount.text = "\("Non-Stop")"
            
            
        } else if  legsArr?[0].numberOfStops == "1"{
         
            lblFlightduration.text = "\(legsArr?[0].duration ?? "")"
            
            lblStopCount.text = "\("1 Stop")"


        } else if  legsArr?[0].numberOfStops == "2"{
            
            lblFlightduration.text = "\(legsArr?[0].duration ?? "")"
            
            lblStopCount.text = "\("2 Stop")"

            

        }else if  legsArr?[0].numberOfStops == "3"{
            
            
            lblFlightduration.text = "\(legsArr?[0].duration ?? "")"
            
            lblStopCount.text = "\("3 Stop")"

            

        }else if  legsArr?[0].numberOfStops == "4"{
            
            
            lblFlightduration.text = "\(legsArr?[0].duration ?? "")"
            
            lblStopCount.text = "\("4 Stop")"

            

        }
        else{
            
            
        }
        
        lblFarePrice.text = "₹ \(fareDict?.totalTaxWithOutMarkUp ?? 0)"
        

        
        
    }
    
}
