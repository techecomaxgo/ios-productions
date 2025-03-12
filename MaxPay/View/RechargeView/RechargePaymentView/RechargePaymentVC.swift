//
//  RechargePaymentVC.swift
//  MaxPay
//
//  Created by Ios Developer on 20/05/24.
//

import UIKit

class RechargePaymentVC: BaseVC {

    @IBOutlet weak var btnBack: UIButton!
   
    
    @IBOutlet weak var lblMilePoint: UILabel!
    
    var selectedPopPStr = ""

    var pricePStr = 0
    
    var validityPStr = ""
    var descriptionPStr = ""
    var dataDayPStr = ""
    var userMobile = ""
    var userMobileNumber = ""
    
    @IBOutlet weak var lblPriceDisp: UILabel!
    
    @IBOutlet weak var lblMobile: UILabel!
    
    @IBOutlet weak var lblBillDate: UILabel!
    
    @IBOutlet weak var lblValidity: UILabel!
    
    // Words for single digits, teens, tens, and large numbers
    let numberWords = [
        0: "zero", 1: "one", 2: "two", 3: "three", 4: "four", 5: "five", 6: "six", 7: "seven", 8: "eight", 9: "nine",
        10: "ten", 11: "eleven", 12: "twelve", 13: "thirteen", 14: "fourteen", 15: "fifteen", 16: "sixteen", 17: "seventeen", 18: "eighteen", 19: "nineteen",
        20: "twenty", 30: "thirty", 40: "forty", 50: "fifty", 60: "sixty", 70: "seventy", 80: "eighty", 90: "ninety"
    ]

    let largeNumberWords = [
        1_000: "thousand",
        1_000_000: "million",
        1_000_000_000: "billion",
        1_000_000_000_000: "trillion"
    ]

    @IBOutlet weak var lblPricewords: UILabel!
    
    
    @IBOutlet weak var btnPay: DesignableButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // count the floor valur greater than 100
        
//        pricePStr = 200.25
          print(pricePStr)
        print(Int(pricePStr))
        
        
        lblPriceDisp.text = "\(formatPriceWithRupeeSymbol(price: pricePStr))"
       
        lblPricewords.text = "\(numberToWords(pricePStr)) rupees only"
        
        
        if pricePStr > 100 {
                    lblMilePoint.text = "\(floorAndDivideBy100(of: pricePStr)) miles"
                } else {
                    lblMilePoint.text = "1 mile"
                }
        
                
        // Get the current date
               let currentDate = Date()
               print("Current date: \(currentDate)")
               
               // Create a DateFormatter
               let dateFormatter = DateFormatter()
               dateFormatter.dateStyle = .medium // You can choose from .short, .medium, .long, .full
               dateFormatter.timeStyle = .medium // You can choose from .none, .short, .medium, .long, .full
               
               // Optionally set a specific date format
                dateFormatter.dateFormat = "dd/MM/yyyy"
               
               // Convert the current date to a string
               let dateString = dateFormatter.string(from: currentDate)
               print("Formatted date: \(dateString)")
       
        lblBillDate.text = dateString
       
        lblValidity.text = validityPStr
        
        print("userMob :",Common.shared.userMobile_NUMBER ?? "")
        
       
        
        lblMobile.text = Common.shared.userMobile_NUMBER ?? ""
        
        btnPay.setTitle("Pay \(formatPriceWithRupeeSymbol(price: pricePStr))", for: .normal)
      
    }
    
    
    func formatPriceWithRupeeSymbol(price: Int) -> String {
        // Format the price to 2 decimal places if needed
        let formattedPrice = String(price)
        
        // Concatenate the rupee symbol with the formatted price
        let priceWithRupeeSymbol = "₹\(formattedPrice)"
        
        return priceWithRupeeSymbol
    }
    
 

    
    func floorAndDivideBy100(of number: Int) -> Int {
      
        
        // Divide the floor value by 100 and return the result as an Int
        return Int(number / 100)
    }
    
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        showCancelPaymentAlert()
        
    }
    
    
    func showCancelPaymentAlert() {
        // Step 1: Create the alert controller
        let alertController = UIAlertController(title: "Cancel Payment?", message: "Are you sure you want to cancel this payment?", preferredStyle: .alert)
        
        // Step 2: Define the actions
        let cancelAction = UIAlertAction(title: "Cancel Payment", style: .destructive) { _ in
            // Code to handle the cancellation of the payment
            self.cancelPayment()
        }
        
        let keepAction = UIAlertAction(title: "Keep Payment", style: .cancel, handler: nil)
        
        // Step 3: Add actions to the alert controller
        alertController.addAction(cancelAction)
        alertController.addAction(keepAction)
        
        // Step 4: Present the alert controller
        self.present(alertController, animated: true, completion: nil)
    }

    // Function to handle the payment cancellation
       func cancelPayment() {
           // Implement the payment cancellation logic here
           print("Payment has been cancelled.")
           
           self.navigationController?.popViewController(animated: true)
           
       }
    
    
    
   
    func numberToWords(_ number: Int) -> String {
        if number == 0 {
            return numberWords[0]!
        }
        
        var result = ""
        var number = number
        
        if number < 0 {
            result = "minus "
            number = abs(number)
        }
        
        for (value, word) in largeNumberWords.sorted(by: { $0.key > $1.key }) {
            if number >= value {
                let quotient = number / value
                let remainder = number % value
                result += numberToWords(quotient) + " " + word
                if remainder > 0 {
                    result += " " + numberToWords(remainder)
                }
                return result
            }
        }
        
        if number >= 100 {
            let quotient = number / 100
            let remainder = number % 100
            result += numberToWords(quotient) + " hundred"
            if remainder > 0 {
                result += " " + numberToWords(remainder)
            }
            return result
        }
        
        if number >= 20 {
            let quotient = number / 10 * 10
            let remainder = number % 10
            result += numberWords[quotient]!
            if remainder > 0 {
                result += "-" + numberWords[remainder]!
            }
            return result
        }
        userMobileNumber = "\(number)"
        return numberWords[number]!
    }
    

    
    @IBAction func btnPayBillVClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RechargeBillPaymentMethodVC") as! RechargeBillPaymentMethodVC
        //vc.priceStr = String(pricePStr)
        vc.priceStr = pricePStr
     //   vc.OperaterName = userMobileNumber
        vc.phone = userMobileNumber
       // vc.CircleName = userMobileNumber
       
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
