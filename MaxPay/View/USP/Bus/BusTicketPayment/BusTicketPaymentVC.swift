//
//  BusTicketPaymentVC.swift
//  MaxPay
//
//  Created by Ios Developer on 12/02/24.
//

import UIKit

class BusTicketPaymentVC: BaseVC {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblAmountWords: UILabel!
    
    @IBOutlet weak var lblPassenderName: UILabel!
    @IBOutlet weak var lblTotalSeat: UILabel!
    @IBOutlet weak var lblTravelDate: UILabel!
    @IBOutlet weak var lblBaseFare: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblGst: UILabel!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    
    var busName = ""
    var countdownTimer: Timer?
    var totalSeconds = 8 * 60 // 8 minutes in seconds
    
    var strPassenderName = ""
    var strTotalSeat = ""
    var strTravelDate = ""
    var discount: Double?

    var validFor = ""
    var transactionId = ""
    var strGst: Double?
    var baseFare: Double?
    var serviceTaxAbsolute: Double?
    var totalSeatPrice:Double?
    var paymentOf = "" // "bus" / "flight" / "hotel"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if paymentOf == "bus" {
            lblTitle.text = "Bus Ticket Payment"
        } else if paymentOf == "flight" {
            lblTitle.text = "Flight Ticket Payment"
        } else if paymentOf == "hotel" {
            lblTitle.text = "Hotel Booking Payment"
        }

        lblAmount.text = "₹\(totalSeatPrice ?? 0.00)"
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        lblAmountWords.text = numberFormatter.string(from: (totalSeatPrice ?? 0.00) as NSNumber)?.capitalizingFirstLetter()
        
        btnPay.setTitle("Pay \("₹\(totalSeatPrice ?? 0.00)")", for: .normal)

        lblPassenderName.text = strPassenderName
        lblTotalSeat.text = strTotalSeat
        lblTravelDate.text = strTravelDate
        
        lblBaseFare.text = "₹\(baseFare ?? 0.00)"
        lblDiscount.text = "₹\(discount ?? 0.00)"
        lblGst.text = "₹\(strGst ?? 0.00)"
        
        totalSeconds = (Int(validFor) ?? 0) * 60
        startTimer()

    }
    
    
    
    func startTimer() {
        // Invalidate any existing timer
        countdownTimer?.invalidate()
        
        // Create a new timer that fires every second
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        // Immediately update the timer label once to display the initial time
        updateTimerLabel()
    }
    
    @objc func updateTimer() {
        // Decrease the totalSeconds by 1 every second
        totalSeconds -= 1
        
        // Update the timer label to reflect the new remaining time
        updateTimerLabel()
        
        // Check if the timer has reached 0
        if totalSeconds <= 0 {
            // If the timer has reached 0, invalidate the timer
            countdownTimer?.invalidate()
            // Optionally, you can perform any actions you want when the timer reaches 0 here
            
            showAlertMessageWithOkAction(title: "MaxUPI", message: "Your session has ended, Please try again.", vc: self) { status in
                self.btnBackAction(UIButton())
            }
        }
    }
    
    func updateTimerLabel() {
        // Calculate minutes and seconds from totalSeconds
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        
        // Update the timer label text
        lblTimer.text = String(format: "%02d:%02d minutes left", minutes, seconds)
    }
    
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: TravelVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func btnInfoAction(_ sender: Any) {
    }


    @IBAction func btnViewBIllAction(_ sender: Any) {
    }
    
    
    @IBAction func btnPayAction(_ sender: Any) {
        let vc = UIStoryboard(name: "USP", bundle: nil).instantiateViewController(withIdentifier: "BusTicketPaymentPayVC") as! BusTicketPaymentPayVC
        vc.totalSeatPrice = totalSeatPrice ?? 0.00
        vc.paymentOf = paymentOf
        vc.transactionId = transactionId
        vc.busName = busName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
