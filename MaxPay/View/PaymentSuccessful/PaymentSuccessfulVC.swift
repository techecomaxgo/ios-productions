//
//  PaymentSuccessfulVC.swift
//  MaxPay
//
//  Created by Ios Developer on 28/01/24.
//

import UIKit
import AVFoundation

class PaymentSuccessfulVC: UIViewController, PaymentTagViewDelegate, AVAudioPlayerDelegate {

    var accountDetails: AccountDetailsOnIIN?
    var beneVpa = ""
    var vpaUpdate = ""
    var beneName = ""
    var transId = ""
    var refNo = ""
    var amount = ""
    var fromScreenOption = ""
    var isFromBank = false
    var paymentStatus = ""
    var complaintObj = ComplaintData()
    var player: AVPlayer?

    @IBOutlet weak var constraintSuccessVIewTop: NSLayoutConstraint!
    @IBOutlet weak var btnBackarrow: UIButton!
    @IBOutlet weak var imgBackarrow: UIImageView!
    
    @IBOutlet weak var viewBeneficaryBg: UIView!
    @IBOutlet weak var viewRecieptBg: CardView!
    @IBOutlet weak var imgPaymentStatus: UIImageView!
    @IBOutlet weak var lblTransactionId: UILabel!
    @IBOutlet weak var lblReferenceNo: UILabel!
    @IBOutlet weak var lblTransactionDateTime: UILabel!
    
    @IBOutlet weak var lblTransferAmount: UILabel!
    @IBOutlet weak var lblBeneficiaryName: UILabel!
    @IBOutlet weak var lblBeneficiaryUpi: UILabel!
    @IBOutlet weak var lblSentFrom: UILabel!
    
    @IBOutlet weak var btnHome: DesignableButton!
    @IBOutlet weak var btnPayAgain: DesignableButton!
    
    @IBOutlet weak var lblSuccessTitle: UILabel!
    @IBOutlet weak var lblRefrenceNoConstant: UILabel!
    @IBOutlet weak var lblRemitiName: UILabel!
    @IBOutlet weak var lblRemitiVpa: UILabel!
    var audioPlayer: AVAudioPlayer!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnHome.layer.borderColor = UIColor(named: "grey-chip-color")?.cgColor
        
        print("beneVpa =========>>> ",beneVpa)
        
        if fromScreenOption == "req" {
            
            // set constant label text
            lblSuccessTitle.text = "Request Successful"
            lblRemitiName.text = "Remitter Name"
            lblRemitiVpa.text = "Remitter UPI ID"
            btnPayAgain.setTitle("Request Again", for: .normal)

            lblReferenceNo.text = refNo
            imgPaymentStatus.image = UIImage(named: "payment-successful-ic") // change icon according to fail or success payment
            lblTransferAmount.text = "₹ \(amount)"
            lblTransactionId.text = transId
            lblBeneficiaryName.text = beneName
            lblBeneficiaryUpi.text = beneVpa
            lblSentFrom.text = (accountDetails?.bankName ?? "") + " " + (accountDetails?.maskedAccnumber ?? "")
            lblTransactionDateTime.text = getCurrentDateTime()
            
            // play Solic Sound
            playSolicSound()
            
            
        } else if fromScreenOption == "pay" {

            // Detault constant label text
            
            imgPaymentStatus.image = UIImage(named: "payment-successful-ic") // change icon according to fail or success payment
            lblTransferAmount.text = "₹ \(amount)"
            lblTransactionId.text = transId
            lblReferenceNo.text = refNo
            lblBeneficiaryName.text = beneName
            lblBeneficiaryUpi.text = beneVpa
            lblSentFrom.text = (accountDetails?.bankName ?? "") + " " + (accountDetails?.maskedAccnumber ?? "")
            
            lblTransactionDateTime.text = getCurrentDateTime()
            
            // play Solic Sound
            playSolicSound()

            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                // Submit Payment Tags
                let vw = PaymentTag()
                vw.frame = UIScreen.main.bounds
                vw.delegate = self
                vw.txnId = self.transId
                vw.setupUI()
                self.view.addSubview(vw)
            })
            

//            if paymentStatus == "00" {
//                btnPayAgain.setTitle("Pay Again", for: .normal)
//                imgPaymentStatus.image = UIImage(named: "payment-successful-ic")
//                lblSuccessTitle.text = "Payment Successful"
//            }
            
//            btnPayAgain.setTitle("Help", for: .normal)
//            imgPaymentStatus.image = UIImage(named: "payment-failed-ic")
//            lblSuccessTitle.text = "Payment Failed"
//            
//            btnPayAgain.setTitle("Help", for: .normal)
//            imgPaymentStatus.image = UIImage(named: "payment-pending-ic")
//            lblSuccessTitle.text = "Payment Pending"
            
            
        } else if fromScreenOption == "reqAppr" {
            
            // Detault constant label text
            
            imgPaymentStatus.image = UIImage(named: "payment-successful-ic") // change icon according to fail or success payment
            lblTransferAmount.text = "₹ \(amount)"
            lblTransactionId.text = transId
            lblReferenceNo.text = refNo
            lblBeneficiaryName.text = beneName
            lblBeneficiaryUpi.text = beneVpa
            lblSentFrom.text = (accountDetails?.bankName ?? "") + " " + (accountDetails?.maskedAccnumber ?? "")
            
            lblTransactionDateTime.text = getCurrentDateTime()
            
            // play Solic Sound
            playSolicSound()

            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                // Submit Payment Tags
                let vw = PaymentTag()
                vw.frame = UIScreen.main.bounds
                vw.delegate = self
                vw.txnId = self.transId
                vw.setupUI()
                self.view.addSubview(vw)
            })
                        
        } else if fromScreenOption == "complaint" {
            
            lblSuccessTitle.text = complaintObj.billerName
            lblRemitiName.text = "Biller Name"
            btnPayAgain.setTitle("Raise Query", for: .normal)

            imgPaymentStatus.image = UIImage(named: "payment-successful-ic") // change icon according to fail or success payment
            lblTransferAmount.text = "₹ \(complaintObj.totalTxnAmt ?? 0)"
            lblTransactionId.text = complaintObj.txnId ?? ""
            lblBeneficiaryName.text = complaintObj.billerName ?? ""
            
            lblReferenceNo.isHidden = true
            lblRefrenceNoConstant.isHidden = true
            viewBeneficaryBg.isHidden = true
            lblSentFrom.text = "UPI"
            lblTransactionDateTime.text = complaintObj.createdAt ?? ""
            
            constraintSuccessVIewTop.constant = 70
            btnBackarrow.isHidden = false
            imgBackarrow.isHidden = false
        }
        
    }
    
    func playSolicSound() {
        if let soundURL = Bundle.main.url(forResource: "pay", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer.delegate = self
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print("Error loading audio file: \(error.localizedDescription)")
            }
        } else {
            print("Could not find the audio file in the app bundle.")
        }
    }
    
    func getCurrentDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm a"
        let dateString = formatter.string(from: Date())
        return dateString
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomeActoin(_ sender : UIButton) {
        
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: DashboardVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                self.tabBarController?.tabBar.isHidden = false

                break
            }else{
                
                //ScanQRVC
                
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: ScanQRVC.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            }
        }
    }
    
    @IBAction func btnPayAgainActoin(_ sender : UIButton) {
     
        if fromScreenOption == "req" {

            // Request again
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: PaymentUPIIDRequestNewVC.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
            
        } else if fromScreenOption == "pay" {
            
            // Pay again
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: PaymentUPIIDNewVC.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
            
        } else if fromScreenOption == "reqAppr" {
            
            // Pay again
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: UPIPaymentReject.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
            
        } else if fromScreenOption == "complaint" {
            
            let storyboard = UIStoryboard(name: "Complaint", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ComplaintFormVC") as! ComplaintFormVC
            vc.txnId = complaintObj.txnId ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
            
        }

        
    }
    
    
    @IBAction func shareButtonAction(_ sender: UIButton) {
        
//         Setting description
        let firstActivityItem = "Here are my Reciept"
        // Setting url
//            let secondActivityItem : NSURL = NSURL(string: "http://your-url.com/")!
        
    let image = viewRecieptBg.asImage()
    
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

    // Block Popup handel
    
    func btnBlock() {
//        for controller in self.navigationController!.viewControllers as Array {
//            if controller.isKind(of: DashboardVC.self) {
//                self.navigationController!.popToViewController(controller, animated: true)
//                break
//            }
//        }
    }
}
