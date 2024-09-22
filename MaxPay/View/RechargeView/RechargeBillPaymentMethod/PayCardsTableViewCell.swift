//
//  PayCardsTableViewCell.swift
//  MaxPay
//
//  Created by Ios Developer on 23/05/24.
//

import UIKit

class PayCardsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblBankName: UILabel!
    
    @IBOutlet weak var img_Selection: UIImageView!

    @IBOutlet weak var btnCellBank: UIButton!
    
    var isSelectedCell: Bool = false {
           didSet {
               updateRadioButton()
           }
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btnCellBank.isUserInteractionEnabled = false

    }
    
    func updateRadioButton() {
            let imageName = isSelectedCell ? "radio-on-button" : "radio-button"
            //radioButton.setImage(UIImage(named: imageName), for: .normal)
        img_Selection.image =  UIImage(named: imageName)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
