//
//  TravellersCVC.swift
//  MaxPay
//
//  Created by Admin on 09/07/24.
//

import UIKit

class TravellersCVC: UICollectionViewCell {
    
    @IBOutlet weak var viewBackSeat: UIView!
    
    @IBOutlet weak var lblSeatPrice: UILabel!
    
    @IBOutlet weak var btnSeat: UIButton!
    
    func configure(with seat: FlightSeatTravellerModel) {
        
        lblSeatPrice.text = "₹\(seat.price)"
            //seatImageView.backgroundColor = seat.isSelected ? .green : .white
        
        
        }
    
    
}
