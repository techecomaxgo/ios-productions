//
//  CardDetaiilCollectionViewCell.swift
//  MaxPay
//
//  Created by Admin on 29/01/25.
//

import UIKit

class CardDetaiilCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btnTap: UIButton!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblCardNo: UILabel!
    @IBOutlet weak var imgBankLogo: UIImageView!
    @IBOutlet weak var lblBankName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func setValues(accountDetailsOnIIN: AccountDetailsOnIIN) {
        
        lblBankName.text = accountDetailsOnIIN.bankName
       
        lblCardNo.attributedText = formatCardNumber(accountDetailsOnIIN.maskedAccnumber ?? "")
        
        lblUserName.text = accountDetailsOnIIN.name
        imgBankLogo.sd_setImage(with: URL(string: "\(accountDetailsOnIIN.bankLogo ?? "")") , placeholderImage: UIImage(named: "placeholder.png"))
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
        }.joined(separator: "   ") // 6 spaces for visual separation
        
        // Create an attributed string without additional kerning inside groups
        let attributedString = NSMutableAttributedString(string: groupedNumber)
        
        return attributedString
    }

}
