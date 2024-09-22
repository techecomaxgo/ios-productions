//
//  CollViewCardCell.swift
//  MaxPay
//
//  Created by india on 09/11/23.
//

import UIKit

class CollViewCardCell: UICollectionViewCell {
    
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblcardNumber: UILabel!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var imgCardBg: UIImageView!
    @IBOutlet weak var lblSelected: UILabel!
    @IBOutlet weak var lblPrimary: UILabel!
    @IBOutlet weak var btnMenu: UIButton!
    
    func setValues(accountDetailsOnIIN: AccountDetailsOnIIN) {
        
        lblBankName.text = accountDetailsOnIIN.bankName
       
        lblcardNumber.attributedText = formatCardNumber(accountDetailsOnIIN.maskedAccnumber ?? "")
        
        lblCustomerName.text = accountDetailsOnIIN.name
        
    }
    
   
    
    
    private func formatCardNumber(_ cardNumber: String) -> NSAttributedString {
        // Remove any existing spaces
        var cleanNumber = cardNumber.replacingOccurrences(of: " ", with: "")
        
       
        if cleanNumber.count < 11 {
            cleanNumber = "XXXXXX" + cleanNumber // Add 6 "X" characters at the beginning
        }
        
        
        let regex = try! NSRegularExpression(pattern: ".{1,4}")
        let matches = regex.matches(in: cleanNumber, range: NSRange(location: 0, length: cleanNumber.count))
        
        // Combine the groups with a specific spacing between them (e.g., 6 spaces)
        let groupedNumber = matches.map {
            (cleanNumber as NSString).substring(with: $0.range)
        }.joined(separator: "      ") // 6 spaces for visual separation
        
        // Create an attributed string without additional kerning inside groups
        let attributedString = NSMutableAttributedString(string: groupedNumber)
        
        return attributedString
    }

    
    
}




