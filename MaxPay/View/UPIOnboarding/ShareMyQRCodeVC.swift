//
//  ShareMyQRCodeVC.swift
//  MaxPay
//
//  Created by Ios Developer on 22/01/24.
//

import UIKit
import Alamofire

class ShareMyQRCodeVC: UIViewController {

    var accountDetails: AccountDetailsOnIIN?
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var viewQRCodeBg: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUpi: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        shareButtonTapped(viewQRCodeBg)
        share(viewQRCodeBg)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        dismiss(animated: true)
    }

    func setData() {
                        
        let URI = "upi://pay?pa=\(accountDetails?.vpa ?? "")&cu=INR&am=0&pn=\(accountDetails?.name ?? "")&refUrl=https://www.axisbank.com&orgid=400005&mode=01&purpose=00"
        
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
    
    @IBAction func shareButtonAction() {
        
        shareButtonTapped(viewQRCodeBg)
        return
        
    }
    
    func shareImage() {
        
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
        activityViewController.popoverPresentationController?.sourceView = (viewQRCodeBg)
        
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
    
    func share(_ view: UIView) {

        
//        if let soundURL = Bundle.main.url(forResource: "ss", withExtension: "png") {
//            do {
//
//
//
//
//            } catch {
//                print("Error loading audio file: \(error.localizedDescription)")
//            }
//        } else {
//            print("Could not find the audio file in the app bundle.")
//        }

        
        
        
        guard let viewToShare = view.toImage() else {
            print("Failed to convert view to image.")
            return
        }
        
        guard let imageData = viewToShare.jpegData(compressionQuality: 1.0) else {
            print("Failed to convert image to JPEG data.")
            return
        }
        
        //        let image = viewQRCodeBg.asImage()
        let firstActivityItem = "Here are my UPI details\nName - \(accountDetails?.name ?? "")\nUPI Handle - \(accountDetails?.vpa ?? "")"
        
        let activityViewController = UIActivityViewController(activityItems: [imageData, firstActivityItem], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // For iPad compatibility
        
        // Exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.airDrop]
        
        // Present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    func shareButtonTapped(_ sender: UIView) {
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
        present(activityViewController, animated: true, completion: {
            // self.dismiss(animated: true)
        })
    }
    
}

extension UIView {
    func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
}
