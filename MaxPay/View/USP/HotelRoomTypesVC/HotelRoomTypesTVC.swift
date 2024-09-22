//
//  HotelRoomTypesTVC.swift
//  MaxPay
//
//  Created by Admin on 05/06/24.
//

import UIKit

class HotelRoomTypesTVC: UITableViewCell {

    
    var isSelectedCell: Bool = false {
           didSet {
               updateRadioButton()
           }
       }
    
    
    
    @IBOutlet weak var imgForRoom: UIImageView!
    
    @IBOutlet weak var lblRoomType: UILabel!
    
    
    @IBOutlet weak var lblRoomsize: UILabel!
    
    @IBOutlet weak var lblRoomRefund: UILabel!
    
    @IBOutlet weak var stackViewRoomCell: UIStackView!
    
    @IBOutlet weak var viewOneAre: UIView!
    
    @IBOutlet weak var viewTwoArea: UIView!
    
    @IBOutlet weak var viewThreeArea: UIView!
    
    @IBOutlet weak var viewFourArea: UIView!
    
    @IBOutlet weak var imgViewOneSelect: UIImageView!
    
    @IBOutlet weak var lblOneMealtype: UILabel!
    
    @IBOutlet weak var lblViewOnePrice: UILabel!
    
   
    @IBOutlet weak var imgViewTwoSelect: UIImageView!
    
    @IBOutlet weak var lblTwoMealtype: UILabel!
    
    @IBOutlet weak var lblViewTwoPrice: UILabel!
    
    
    
    @IBOutlet weak var imgViewThreeSelect: UIImageView!
    
    @IBOutlet weak var lblThreeMealtype: UILabel!
    
    @IBOutlet weak var lblViewThreePrice: UILabel!
    
    
    
    
    @IBOutlet weak var imgViewFourSelect: UIImageView!
    
    @IBOutlet weak var lblFourMealtype: UILabel!
    
    @IBOutlet weak var lblViewFourPrice: UILabel!
    
    
    @IBOutlet weak var lblViewOneTax: UILabel!
    
    @IBOutlet weak var lblViewTwoTax: UILabel!

    @IBOutlet weak var lblViewThreeTax: UILabel!

    @IBOutlet weak var lblViewFourTax: UILabel!

    @IBOutlet weak var viewBackCell: UIView!
    
    
    @IBOutlet weak var btnSelectViewOne: UIButton!
    
    @IBOutlet weak var btnSelectViewTwo: UIButton!
    
    @IBOutlet weak var btnSelectViewThree: UIButton!
    
    @IBOutlet weak var btnSelectViewFour: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    
    func updateRadioButton() {
            let imageName = isSelectedCell ? "radio-on-button" : "radio-button"
            //radioButton.setImage(UIImage(named: imageName), for: .normal)
        imgViewFourSelect.image =  UIImage(named: imageName)
    }
    
    
    
    func setRoomTypeData(roomTypeData: String, duplexData :[DeluxeDuplex]?) {
        
       // print(roomTypeData)
       //print(duplexData)
        
        lblRoomType.text = roomTypeData

        
        let someValue = duplexData?.count

        switch someValue {
        case 0:
            print("eats 0")
        case 1:
           
            print("eats 1")
            lblOneMealtype.text = duplexData?[0].mealType ?? ""
           
            lblViewOnePrice.text = "\(duplexData?[0].price ?? 0)"
            
            
        case 2:
            print("eats 2")
            
            viewOneAre.isHidden = false
            viewTwoArea.isHidden = false
            viewThreeArea.isHidden = true
            viewFourArea.isHidden = true


            
            lblOneMealtype.text = duplexData?[0].mealType ?? ""
            lblTwoMealtype.text = duplexData?[1].mealType ?? ""
           // lblThreeMealtype.text = duplexData?[2].mealType ?? ""
           // lblFourMealtype.text = duplexData?[3].mealType ?? ""
            
            lblViewOnePrice.text = "\(duplexData?[0].price ?? 0)"
            lblViewTwoPrice.text = "\(duplexData?[1].price ?? 0)"
           // lblViewThreePrice.text = "\(duplexData?[2].price ?? 0)"
           // lblViewFourPrice.text = "\(duplexData?[3].price ?? 0)"
            
        case 3:
            print("eats 3")
            
            lblOneMealtype.text = duplexData?[0].mealType ?? ""
            lblTwoMealtype.text = duplexData?[1].mealType ?? ""
           // lblThreeMealtype.text = duplexData?[2].mealType ?? ""
            
            lblViewOnePrice.text = "\(duplexData?[0].price ?? 0)"
            lblViewTwoPrice.text = "\(duplexData?[1].price ?? 0)"
           // lblViewThreePrice.text = "\(duplexData?[2].price ?? 0)"
        case 4:
            print("eats 4")
            lblOneMealtype.text = duplexData?[0].mealType ?? ""
            lblTwoMealtype.text = duplexData?[1].mealType ?? ""
           // lblThreeMealtype.text = duplexData?[2].mealType ?? ""
           // lblFourMealtype.text = duplexData?[3].mealType ?? ""
            
            lblViewOnePrice.text = "\(duplexData?[0].price ?? 0)"
            lblViewTwoPrice.text = "\(duplexData?[1].price ?? 0)"
           // lblViewThreePrice.text = "\(duplexData?[2].price ?? 0)"
           // lblViewFourPrice.text = "\(duplexData?[3].price ?? 0)"
        default:
            print("no match")
        }
        
      
        
        
    }
    
    //[ExecutiveRoom]
    
    
    func setRoomTypeData(roomTypeData: String, executiveData :[ExecutiveRoom]?) {
        
        // print(roomTypeData)
         
         //print(duplexData)
         
         lblRoomType.text = roomTypeData

         
         let someValue = executiveData?.count

         switch someValue {
         case 0:
             print("eats 0")
         case 1:
             print("eats 1")
             lblOneMealtype.text = executiveData?[0].mealType ?? ""
            
             lblViewOnePrice.text = "\(executiveData?[0].price ?? 0)"
             
             
         case 2:
             print("eats 2")
             
             viewOneAre.isHidden = false
             viewTwoArea.isHidden = false
             viewThreeArea.isHidden = true
             viewFourArea.isHidden = true
             
             
             lblOneMealtype.text = executiveData?[0].mealType ?? ""
             lblTwoMealtype.text = executiveData?[1].mealType ?? ""
            // lblThreeMealtype.text = duplexData?[2].mealType ?? ""
            // lblFourMealtype.text = duplexData?[3].mealType ?? ""
             
             lblViewOnePrice.text = "\(executiveData?[0].price ?? 0)"
             lblViewTwoPrice.text = "\(executiveData?[1].price ?? 0)"
            // lblViewThreePrice.text = "\(duplexData?[2].price ?? 0)"
            // lblViewFourPrice.text = "\(duplexData?[3].price ?? 0)"
             
         case 3:
             print("eats 3")
             
             lblOneMealtype.text = executiveData?[0].mealType ?? ""
             lblTwoMealtype.text = executiveData?[1].mealType ?? ""
            // lblThreeMealtype.text = duplexData?[2].mealType ?? ""
             
             lblViewOnePrice.text = "\(executiveData?[0].price ?? 0)"
             lblViewTwoPrice.text = "\(executiveData?[1].price ?? 0)"
            // lblViewThreePrice.text = "\(duplexData?[2].price ?? 0)"
         case 4:
             print("eats 4")
             lblOneMealtype.text = executiveData?[0].mealType ?? ""
             lblTwoMealtype.text = executiveData?[1].mealType ?? ""
            // lblThreeMealtype.text = duplexData?[2].mealType ?? ""
            // lblFourMealtype.text = duplexData?[3].mealType ?? ""
             
             lblViewOnePrice.text = "\(executiveData?[0].price ?? 0)"
             lblViewTwoPrice.text = "\(executiveData?[1].price ?? 0)"
            // lblViewThreePrice.text = "\(duplexData?[2].price ?? 0)"
            // lblViewFourPrice.text = "\(duplexData?[3].price ?? 0)"
         default:
             print("no match")
         }
         
       
         
         
     }
    
    // [Suite]
    
    
    func setRoomTypeData(roomTypeData: String, suitsData :[Suite]?) {
        
        // print(roomTypeData)
         
         //print(duplexData)
         
         lblRoomType.text = roomTypeData

         
         let someValue = suitsData?.count

         switch someValue {
         case 0:
             print("eats 0")
         case 1:
             print("eats 1")
             lblOneMealtype.text = suitsData?[0].mealType ?? ""
            
             lblViewOnePrice.text = "\(suitsData?[0].price ?? 0)"
             
             
         case 2:
             print("eats 2")
             
             viewOneAre.isHidden = false
             viewTwoArea.isHidden = false
             viewThreeArea.isHidden = true
             viewFourArea.isHidden = true
             
             
             lblOneMealtype.text = suitsData?[0].mealType ?? ""
             lblTwoMealtype.text = suitsData?[1].mealType ?? ""
             lblTwoMealtype.text = suitsData?[1].mealType ?? ""
            // lblThreeMealtype.text = duplexData?[2].mealType ?? ""
            // lblFourMealtype.text = duplexData?[3].mealType ?? ""
             
             lblViewOnePrice.text = "\(suitsData?[0].price ?? 0)"
             lblViewTwoPrice.text = "\(suitsData?[1].price ?? 0)"
            // lblViewThreePrice.text = "\(duplexData?[2].price ?? 0)"
            // lblViewFourPrice.text = "\(duplexData?[3].price ?? 0)"
             
             
             lblViewOneTax.text = "+ ₹\(suitsData?[0].surchargeTotal ?? 0) Taxes & Fees"
             lblViewTwoTax.text = "+ ₹\(suitsData?[1].surchargeTotal ?? 0) Taxes & Fees"

             
         case 3:
             print("eats 3")
             
             lblOneMealtype.text = suitsData?[0].mealType ?? ""
             lblTwoMealtype.text = suitsData?[1].mealType ?? ""
            // lblThreeMealtype.text = duplexData?[2].mealType ?? ""
             
             lblViewOnePrice.text = "\(suitsData?[0].price ?? 0)"
             lblViewTwoPrice.text = "\(suitsData?[1].price ?? 0)"
            // lblViewThreePrice.text = "\(duplexData?[2].price ?? 0)"
         case 4:
             print("eats 4")
             lblOneMealtype.text = suitsData?[0].mealType ?? ""
             lblTwoMealtype.text = suitsData?[1].mealType ?? ""
            // lblThreeMealtype.text = duplexData?[2].mealType ?? ""
            // lblFourMealtype.text = duplexData?[3].mealType ?? ""
             
             lblViewOnePrice.text = "\(suitsData?[0].price ?? 0)"
             lblViewTwoPrice.text = "\(suitsData?[1].price ?? 0)"
            // lblViewThreePrice.text = "\(duplexData?[2].price ?? 0)"
            // lblViewFourPrice.text = "\(duplexData?[3].price ?? 0)"
             
         default:
             print("no match")
         }
         
       
         
         
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
