//
//  MyQRCodeVC.swift
//  MaxPay
//
//  Created by Ios Developer on 22/01/24.
//

import UIKit
import Alamofire

class MyQRCodeVC: UIViewController {

    var accountDetails: AccountDetailsOnIIN?
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var viewQRCodeBg: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUpi: UILabel!
    
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var imgBankIcon: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           self.tabBarController?.tabBar.isHidden = true

   }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }

    func setData() {
        
        lblName.text = accountDetails?.name
        lblUpi.text = "UPI ID: \(accountDetails?.vpa ?? "")"
        if let bankName = accountDetails?.bankName, let maskedAccnumber = accountDetails?.maskedAccnumber {
//            lblBankName.text = bankName  ??  "" + " - " + maskedAccnumber.suffix(4) ?? ""
        }
        
        if let logo = accountDetails?.bankLogo {
            if logo == "" {
//                imgBankIcon.image = UIImage(named: "bank_logo")
            } else {
                Alamofire.request(logo).response { response in
                    if let data = response.data {
                        let image = UIImage(data: data)
//                        self.imgBankIcon.image = image
                    } else {
                        print("Data is nil. I don't know what to do :(")
//                        self.imgBankIcon.image = UIImage(named: "bank_logo")
                    }
                }
            }
        }
                
        let URI = "upi://pay?pa=\(accountDetails?.vpa ?? "")&cu=INR&am=0&pn=\(accountDetails?.name ?? "")&refUrl=https://www.axisbank.com&orgid=400005&mode=01&purpose=00&mc=0000"
        
        imgQRCode.image = generateQRCode(from: URI)
    }
    
    func generateQRCode(from string: String) -> UIImage?
    {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator")
        {
            filter.setValue(data, forKey: "inputMessage")
            
            guard let qrImage = filter.outputImage else {return nil}
            let scaleX = self.imgQRCode.frame.size.width / qrImage.extent.size.width
            let scaleY = self.imgQRCode.frame.size.height / qrImage.extent.size.height
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
            if let output = filter.outputImage?.transformed(by: transform)
            {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    @IBAction func scanButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "ScanQRVC") as! ScanQRVC
        vc.accountDetails = accountDetails
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func shareButtonAction(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "ShareMyQRCodeVC") as! ShareMyQRCodeVC
        vc.accountDetails = accountDetails
        present(vc, animated: true)
        
//        shareButtonTapped(sender)
        return
        
//         Setting description
        let firstActivityItem = "Here are my UPI details\nName - \(accountDetails?.name ?? "")\nUPI Handle - \(accountDetails?.vpa ?? "")"

        // Setting url
//            let secondActivityItem : NSURL = NSURL(string: "http://your-url.com/")!
        
    let image = viewQRCodeBg.asImage()
    
        // If you want to use an image
//            let image : UIImage = UIImage(named: "your-image-name")!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, /*secondActivityItem,*/ image], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
        UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
    
        func shareButtonTapped(_ sender: UIButton) {
            // Create an array to store the items to share
            var itemsToShare = [Any]()
            
            let image = viewQRCodeBg.asImage()
            let firstActivityItem = "Here are my UPI details\nName - \(accountDetails?.name ?? "")\nUPI Handle - \(accountDetails?.vpa ?? "")"

            // Add the image and text to the items array
//            if let image = imageView.image {
                itemsToShare.append(image)
//            }
            itemsToShare.append(firstActivityItem)
            
            // Create the activity view controller
            let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
            
            // Exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [
                .addToReadingList,
                .assignToContact,
                .openInIBooks,
                .print
            ]
            
            // Present the activity view controller
            if let popoverController = activityViewController.popoverPresentationController {
                popoverController.sourceView = sender
                popoverController.sourceRect = sender.bounds
            }
            present(activityViewController, animated: true, completion: nil)
        }
    

}
