//
//  BookingViewSuccess.swift
//  MaxPay
//
//  Created by india on 13/12/23.
//

import UIKit
import Lottie
@objc protocol BookingViewSuccessDelegate: NSObjectProtocol {
    func backToHome()
    
}
class BookingViewSuccess: UIView {

    @IBOutlet weak var vwSuccess: LottieAnimationView!
    @IBOutlet var vwMain: UIView!
    @IBOutlet weak var lblBookingID: UILabel!
    weak var delegate:BookingViewSuccessDelegate?
    
    func setupUI(_ intTrasactionID: String){
        if let first = Bundle.main.loadNibNamed("BookingViewSuccess", owner: self, options: nil)?.first as? UIView {
            vwMain = first
            lblBookingID.text = "Booking ID : \(intTrasactionID)"
//            vwSuccess = .init(name: "coffee")
            vwSuccess.contentMode = .scaleAspectFit
            vwSuccess.loopMode = .loop
            vwSuccess.animationSpeed = 0.5
            vwSuccess.play()
            vwMain.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            addSubview(vwMain)
        }
    }
    @IBAction func btnBackHomeAction(_ sender: Any) {
        self.removeFromSuperview()
        delegate?.backToHome()
    }
}
