//
//  ScanQRVC.swift
//  MaxPay
//
//  Created by india on 08/12/23.
//

import UIKit
import AVFoundation
import OlivePayLibrary
import SwiftLoader
import MessageUI
import Vision

class ScanQRVC: BaseVC, AVCaptureMetadataOutputObjectsDelegate {
    
    var arrangedQrData = [String:Any]()
   var  qrCheckString = ""
    
    var generateQrStr = ""
    
    var strQrScanm = ""
    
    var modifiedString = ""

    
    private var qrBharatVM =  QRBharatScanViewModel()
    
    var window: UIWindow?

    var mcccodeStr = ""
    var beneNameStr = ""


    

    private var checksumViewModel = SIMSelectionViewModel()
    var accountDetails: AccountDetailsOnIIN?
    
    var scanAreaView = UIView()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var scannedCode = ""
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var isFromtabBar = false
    
    @IBOutlet weak var tabBarView: UIView!
    
    
    let greyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true // Ensure the image doesn't overflow its bounds
        return imageView
    }()

    let backButton: UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()

    let selectFromGalleryButton: UIButton = {
        let selectFromGalleryButton = UIButton()
        selectFromGalleryButton.translatesAutoresizingMaskIntoConstraints = false
        return selectFromGalleryButton
    }()

    let myQrButton: UIButton = {
        let myQrButton = UIButton()
        myQrButton.translatesAutoresizingMaskIntoConstraints = false
        return myQrButton
    }()
    
    let scanBackButton: UIButton = {
        let scanAgainButton = UIButton()
        scanAgainButton.isHidden = false
        scanAgainButton.translatesAutoresizingMaskIntoConstraints = false
        return scanAgainButton
    }()
    

    let scanAgainButton: UIButton = {
        let scanAgainButton = UIButton()
        scanAgainButton.isHidden = true
        scanAgainButton.translatesAutoresizingMaskIntoConstraints = false
        return scanAgainButton
    }()
    
    
    
    let flashButton: UIButton = {
        let flashButton = UIButton()
        flashButton.translatesAutoresizingMaskIntoConstraints = false
        return flashButton
    }()
    var isFlashlightOn = false
    let imageFlashlightOn = UIImage(named: "flash-off-ic")
    let imageFlashlightOff = UIImage(named: "flash-on-ic")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(accountDetails)

        startScan()
        
        configuration()
        
    }
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        

        if isFromtabBar {
            
            self.dismiss(animated: true, completion: nil)
            self.tabBarController?.tabBar.isHidden = false

            
//            if let VC = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC {
//                isFromtabBar = false
//                let navigationController = UINavigationController(rootViewController: VC)
//                navigationController.isNavigationBarHidden = true
//                self.view.window?.rootViewController = navigationController
//            }
            
        } else {
            
            self.navigationController?.popViewController(animated: true)
            self.tabBarController?.tabBar.isHidden = false
            
        }
    }

    
    func startScan() {
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
        
        // Controls
        
        view.addSubview(greyImageView)
        NSLayoutConstraint.activate([
            greyImageView.topAnchor.constraint(equalTo: view.topAnchor),
            greyImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            greyImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            greyImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        greyImageView.image = UIImage(named: "qr-scanner-bg")

//        
//        view.addSubview(backButton)
//        NSLayoutConstraint.activate([
//            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
//            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            backButton.widthAnchor.constraint(equalToConstant: 55),
//            backButton.heightAnchor.constraint(equalToConstant: 35)
//        ])
//        backButton.setImage(UIImage(named: "backarrow"), for: .normal)
//        backButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)

        
        view.addSubview(flashButton)
        NSLayoutConstraint.activate([
            flashButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            flashButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            flashButton.widthAnchor.constraint(equalToConstant: 55),
            flashButton.heightAnchor.constraint(equalToConstant: 35)
        ])
        flashButton.setImage(UIImage(named: "flash-on-ic"), for: .normal)
        flashButton.addTarget(self, action: #selector(flashClicked), for: .touchUpInside)

        
        view.addSubview(selectFromGalleryButton)
        
        NSLayoutConstraint.activate([
            selectFromGalleryButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            selectFromGalleryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectFromGalleryButton.widthAnchor.constraint(equalToConstant: 205),
            selectFromGalleryButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        selectFromGalleryButton.setImage(UIImage(named: "select-from-gallery"), for: .normal)
        selectFromGalleryButton.addTarget(self, action: #selector(selectFromGallery), for: .touchUpInside)
        
        view.addSubview(myQrButton)
        
        NSLayoutConstraint.activate([
            myQrButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 230),
            myQrButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myQrButton.widthAnchor.constraint(equalToConstant: 145),
            myQrButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        myQrButton.setImage(UIImage(named: "my-qr-button"), for: .normal)
        myQrButton.addTarget(self, action: #selector(myQrButtonAction), for: .touchUpInside)

        view.addSubview(scanAgainButton)
        NSLayoutConstraint.activate([
            scanAgainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 310),
            scanAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scanAgainButton.widthAnchor.constraint(equalToConstant: 145),
            scanAgainButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        scanAgainButton.setImage(UIImage(named: "scan-again-button-bg"), for: .normal)
        scanAgainButton.addTarget(self, action: #selector(scanAgainButtonAction), for: .touchUpInside)

        //scanBackButton
        
        
        view.addSubview(scanBackButton)
        NSLayoutConstraint.activate([
            scanBackButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 390),
            scanBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scanBackButton.widthAnchor.constraint(equalToConstant: 145),
            scanBackButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //scanBackButton.setImage(UIImage(named: "milstonetoback"), for: .normal)
        scanBackButton.setTitleColor(.black, for: .normal)
        scanBackButton.setTitle("Back", for: .normal)
        scanBackButton.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        scanBackButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        scanBackButton.layer.cornerRadius = 8

        scanBackButton.addTarget(self, action: #selector(backButtonScanAction), for: .touchUpInside)
                
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
   //     navigationController?.setNavigationBarHidden(true, animated: animated)

        self.tabBarController?.tabBar.isHidden = true

        
        if (captureSession?.isRunning == false) {
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
        }
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
        
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        captureSession.stopRunning()
        scanAgainButton.isHidden = false
        
        if let metadataObject = metadataObjects.first {
            
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            
            if  !stringValue.localizedStandardContains("orgid") {
                
                strQrScanm = "\(stringValue)&orgid=400005"
            }else{
                
                
                strQrScanm = stringValue
            }
            
            
            modifiedString = strQrScanm.replacingOccurrences(of: "%20", with: "").replacingOccurrences(of: "%", with: "")

           // print(modifiedString)
            
            
       // oliveGenerateSignedQR(param: strQrScanm)
            
           // print( self.generateQrStr)
            
           // oliveUPiVerify(param: modifiedString)

            found(code: stringValue)
            
        }
        

    }
    
    
    func checkvpa(vpa: String) {
        

        
        let payerInfo = PayerInfo(accountnumber: Common.shared.primaryAccRefNumber, mcc: MCC, name: accountDetails?.name, payervpa: accountDetails?.vpa)
        
        var jsonToString = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(payerInfo)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                jsonToString = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }

        DispatchQueue.global(qos: .background).async {
            
            // Working properly
            OliveUpiManager.checkvpa(vpa: vpa, payerInfo: jsonToString) { data, error in
                
                if let err = error {
                    if err.code == 102 { // Customer Accounts not found / Timed Out
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    } else if err.code == 401 || err.code == 107 {
                        
                        self.configuration()
                        
                        return
                    }
                    DispatchQueue.main.async {
                        
                        SwiftLoader.hide()
                        
                    }
                } else {
                    
                    print(data)
                                        
//                    
//                    DispatchQueue.main.async {
//                    
//                    let storyboard = UIStoryboard(name: "BhimUpi", bundle: nil)
//                    let vc = storyboard.instantiateViewController(withIdentifier: "PaymentUPIIDNewVC") as! PaymentUPIIDNewVC
//                    vc.qrData = data
//                    vc.accountDetails = self.accountDetails
//                    vc.beneVpa = data["pa"] as! String
//                    vc.beneName = data["pn"] as! String
//                    vc.isFromQrScan = true
//                   // self.navigationItem.setHidesBackButton(true, animated: false)
//                    self.navigationController?.pushViewController(vc, animated: true)
//                        
//                }
//                    
                    
                    
//                    if let mcccode = data["mcccode"] as? String {
//                        print("MCC Code: \(mcccode)")
//                    } else {
//                        print("MCC Code not found or is not a String")
//                    }
                    
//                    self.dataDict = data
//
//                    print(self.dataDict ?? (Any).self)
//
//                    if let mccCode = self.getMccCode(from: data as! [[String : Any?]]) {
//                        print("MCC Code: \(mccCode)")
//                    } else {
//                        print("MCC Code not found")
//                    }
                    
                    
                    if let dt = data {
                        
                        
                        if let dataDictAll = self.convertToSScanData(data) {
                            
                           print("datadict")
                            
                            print(self.mcccodeStr)
                            
                        }
                        
                        
                        
                        
                        if let data = SendMoneyVC.convertToData(dt) {
                            do {
                                
                                print(data)
                                
                                //let beneficiaryList = try JSONDecoder().decode([MandateListModel].self, from: data)
                                
//                                for beneficiary in beneficiaryList {
//                                    self.mandateListArr.append(beneficiary)
//                                }
                                
                            } catch {
                                
                                print(error.localizedDescription)
                            }
                            
//                            DispatchQueue.main.async {
//                                self.tableViewMandate.reloadData()
//                                self.lblNoDataAvailable.isHidden = self.mandateListArr.count != 0
//                                SwiftLoader.hide()
//
//                            }
//
                        }
                        
                    }
                    
                    
                    
                    DispatchQueue.main.async {
                        
                        SwiftLoader.hide()
                        
                        let vc = UIStoryboard(name: "BhimUpi", bundle: nil).instantiateViewController(withIdentifier: "PaymentUPIIDNewVC") as! PaymentUPIIDNewVC
                        
//                        vc.contactData = contact
                        
                        vc.accountDetails = self.accountDetails
                        vc.beneVpa = vpa
                        vc.beneName = self.beneNameStr
                        vc.mccCodeDNewVC = self.mcccodeStr
                        
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                                                
                    }
                }
            }
        }

    }
    
    
    func convertToSScanData(_ object: Any) -> Data? {
       if let data = object as? Data {
           // If object is already Data, no conversion needed
           return data
       } else if let string = object as? String {
           // If object is String, convert it to Data using UTF-8 encoding
           return string.data(using: .utf8)
       } else if let number = object as? NSNumber {
           // If object is NSNumber, convert it to Data
           return number.stringValue.data(using: .utf8)
       } else if let array = object as? [Any] {
           // If object is an array, convert it to Data using JSONSerialization
           do {
               return try JSONSerialization.data(withJSONObject: array)
           } catch {
               print("Error converting array to Data: \(error)")
               return nil
           }
       } else if let dictionary = object as? [String: Any] {
           // If object is a dictionary, convert it to Data using JSONSerialization
           
          // dataDictVpa = dictionary
           
           mcccodeStr = dictionary["mcccode"] as? String ?? ""
           //print(dictionary["mcccode"] as? String)
           
           beneNameStr = dictionary["data"] as? String ?? ""
           
           print(mcccodeStr)
           
           
           
           do {
               return try JSONSerialization.data(withJSONObject: dictionary)
           } catch {
               print("Error converting dictionary to Data: \(error)")
               return nil
           }
       }
       

       // Handle other cases or return nil if the type is not supported
       print("Unsupported type for conversion to Data")
       return nil
   }
    
    func oliveUPiVerify(param:String){
        
        OliveUpiManager.verifySignedQR(qrString: param, callback: { data, error in
            
            if let err = error {
                if err.code == 102 { // Customer Accounts not found / Timed Out
                    DispatchQueue.main.async {
                        self.showErrorAlert(err.localizedDescription)
                    }
                } else if err.code == 401 || err.code == 107 {
                    
                    self.configuration()
                    
                    return
                }
                DispatchQueue.main.async {
                    
                    SwiftLoader.hide()
                    
                }
            } else {
                
                print(data)
                                    
               
                
                
                
//                    if let mcccode = data["mcccode"] as? String {
//                        print("MCC Code: \(mcccode)")
//                    } else {
//                        print("MCC Code not found or is not a String")
//                    }
                
//                    self.dataDict = data
//
//                    print(self.dataDict ?? (Any).self)
//
//                    if let mccCode = self.getMccCode(from: data as! [[String : Any?]]) {
//                        print("MCC Code: \(mccCode)")
//                    } else {
//                        print("MCC Code not found")
//                    }
                
                
                if let dt = data {
                    
                    
//                    if let dataDictAll = self.convertToSomeAnyData(data) {
//
//                       print("datadict")
//
//                        print(self.mcccodeStr)
//
//                    }
                    
                    
                    
                    
//                    if let data = SendMoneyVC.convertToData(dt) {
//                        do {
//
//                            print(data)
//
//                            //let beneficiaryList = try JSONDecoder().decode([MandateListModel].self, from: data)
//
////                                for beneficiary in beneficiaryList {
////                                    self.mandateListArr.append(beneficiary)
////                                }
//
//                        } catch {
//
//                            print(error.localizedDescription)
//                        }
//
////                            DispatchQueue.main.async {
////                                self.tableViewMandate.reloadData()
////                                self.lblNoDataAvailable.isHidden = self.mandateListArr.count != 0
////                                SwiftLoader.hide()
////
////                            }
////
//                    }
                    
                }
                
                
                
            }
        })
        
        
    }
    
    
    func oliveGenerateSignedQR(param:String){
        
        OliveUpiManager.generateSignedQR(qrString: param, callback: { data, error in
            
            if let err = error {
                if err.code == 102 { // Customer Accounts not found / Timed Out
                    DispatchQueue.main.async {
                        self.showErrorAlert(err.localizedDescription)
                    }
                } else if err.code == 401 || err.code == 107 {
                    
                    self.configuration()
                    
                    return
                }
                DispatchQueue.main.async {
                    
                    SwiftLoader.hide()
                    
                }
            } else {
                
                print(data)
                
                self.generateQrStr = data as? String ?? ""
                
             
              //  self.oliveUPiVerify(param: data)
                
               let strQrScanm = "\(param)&sign=\(self.generateQrStr)"

                          print(strQrScanm)
            
                self.oliveUPiVerify(param: strQrScanm)

                
                
                
//                    if let mcccode = data["mcccode"] as? String {
//                        print("MCC Code: \(mcccode)")
//                    } else {
//                        print("MCC Code not found or is not a String")
//                    }
                
//                    self.dataDict = data
//
//                    print(self.dataDict ?? (Any).self)
//
//                    if let mccCode = self.getMccCode(from: data as! [[String : Any?]]) {
//                        print("MCC Code: \(mccCode)")
//                    } else {
//                        print("MCC Code not found")
//                    }
                
                
                if let dt = data {
                    
                    
//                    if let dataDictAll = self.convertToSomeAnyData(data) {
//                        
//                       print("datadict")
//                        
//                        print(self.mcccodeStr)
//                        
//                    }
                    
                    
                    
                    
//                    if let data = SendMoneyVC.convertToData(dt) {
//                        do {
//                            
//                            print(data)
//                            
//                            //let beneficiaryList = try JSONDecoder().decode([MandateListModel].self, from: data)
//                            
////                                for beneficiary in beneficiaryList {
////                                    self.mandateListArr.append(beneficiary)
////                                }
//                            
//                        } catch {
//                            
//                            print(error.localizedDescription)
//                        }
//                        
////                            DispatchQueue.main.async {
////                                self.tableViewMandate.reloadData()
////                                self.lblNoDataAvailable.isHidden = self.mandateListArr.count != 0
////                                SwiftLoader.hide()
////
////                            }
////
//                    }
                    
                }
                
                return
                
            }
        })
        
        
    }
    
//    func found(code: String) {
//        scannedCode = code
//        verifySignedQR(stringURI: scannedCode)
//    }
    
    func found(code: String) {
        
        scannedCode = code
        
       // verifySignedQR(stringURI: scannedCode)
        
        
        
        let payloadFormatIndicator = String(scannedCode.prefix(6))
        
        print(payloadFormatIndicator)
        
        if payloadFormatIndicator == "000201" {
            
            qrCheckString = scannedCode
            configurationBharatQrCall()
            
            
        }else {
            
           // self.showErrorAlert(" ")
            
            verifySignedQR(stringURI: scannedCode)

            
        }
        

        
        
        
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
//    func startScan() {
//
//        let captureDevice = AVCaptureDevice.default(for: .video)!
//
//        do {
//            let input:AVCaptureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
//            captureSession = AVCaptureSession()
//            captureSession.addInput(input as AVCaptureInput)
//        } catch {
//            print("\(error.localizedDescription)")
//            return
//        }
//
//        let captureMetadataOutput = AVCaptureMetadataOutput()
//        captureSession.addOutput(captureMetadataOutput)
//
//        // calculate a centered square rectangle with red border
//        let size = 300
//        let screenWidth = self.view.frame.size.width
//        let xPos = (CGFloat(screenWidth) / CGFloat(2)) - (CGFloat(size) / CGFloat(2))
//        let scanRect = CGRect(x: Int(xPos), y: 150, width: size, height: size)
//
//        // create UIView that will server as a red square to indicate where to place QRCode for scanning
//        scanAreaView = UIView()
//        scanAreaView.layer.borderColor = UIColor(named: "primary-green")?.cgColor
//        scanAreaView.layer.borderWidth = 4.0
//        scanAreaView.layer.cornerRadius = 8.0
//        scanAreaView.frame = scanRect
//
//        // Set delegate and use the default dispatch queue to execute the call back
////        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
//        captureMetadataOutput.rectOfInterest = scanRect
//
//
//        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
//        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        videoPreviewLayer?.frame = view.layer.bounds
//        view.layer.addSublayer(videoPreviewLayer!)
//
//        // Start video capture.
//        captureSession.commitConfiguration()
//        captureSession.startRunning()
//
//        // Initialize QR Code Frame to highlight the QR code
//        qrCodeFrameView = UIView()
//        if let qrCodeFrameView = qrCodeFrameView {
//            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
//            qrCodeFrameView.layer.borderWidth = 2
//            view.addSubview(qrCodeFrameView)
//            view.bringSubviewToFront(qrCodeFrameView)
//        }
//        // Add a button that will be used to close out of the scan view
//        let videoBtn = UIButton()
//        videoBtn.setTitle("Close", for: .normal)
//        videoBtn.setTitleColor(UIColor.black, for: .normal)
//        videoBtn.backgroundColor = UIColor.gray
//        videoBtn.layer.cornerRadius = 5.0;
//        videoBtn.frame = CGRectMake(10, 30, 70, 45)
//        videoBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//
//        view.addSubview(videoBtn)
//
//        view.addSubview(scanAreaView)
//
//    }
    
    @objc func flashClicked() {
        
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                // Toggle flashlight state
                device.torchMode = isFlashlightOn ? .off : .on
                isFlashlightOn = !isFlashlightOn
                
                // Set flashlight button image based on the state
                let buttonImage = isFlashlightOn ? imageFlashlightOn : imageFlashlightOff
                flashButton.setImage(buttonImage, for: .normal)
                
                device.unlockForConfiguration()
            } catch {
                print("Error toggling flashlight: \(error.localizedDescription)")
            }
        }
    }
    
//    @objc func buttonClicked() {
//        self.navigationController?.popViewController(animated: true)
//    }
//    
    
    @objc func scanAgainButtonAction() {
        if (captureSession?.isRunning == false) {
            DispatchQueue.main.async {
                self.scanAgainButton.isHidden = true
                self.captureSession.startRunning()
            }
        }
    }
    
    
    @objc func backButtonScanAction() {
        
        
        
        if isFromtabBar {
            
//            self.window? = UIWindow(frame: UIScreen.main.bounds)
//            self.window?.rootViewController = CustomTabBarController()
//            self.window?.makeKeyAndVisible()
//            
            
            self.dismiss(animated: true, completion: nil)
            self.tabBarController?.tabBar.isHidden = false


            
//            if let VC = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC {
//                isFromtabBar = false
//                let navigationController = UINavigationController(rootViewController: VC)
//                navigationController.isNavigationBarHidden = true
//                self.view.window?.rootViewController = navigationController
//            }
            
        } else {
            
            self.navigationController?.popViewController(animated: true)
            self.tabBarController?.tabBar.isHidden = false

            
        }
        
        

    }
    
    
    @objc func myQrButtonAction() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
        vc.accountDetails = accountDetails
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func selectFromGallery() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false // Set to true if you want to allow editing
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func verifySignedQR(stringURI: String) {
        
        // upi://pay?pa=prem9099@axis&cu=INR&am=0&pn=KESHAVBHAI CHATURBHAI VAGHELA&refUrl=https://www.axisbank.com&orgid=400005&mode=01&purpose=00
        
//        [pa=prem9099@axis,
//         cu=INR,
//         am=0,
//         pn=KESHAVBHAI CHATURBHAI VAGHELA,
//         refUrl=https://www.axisbank.com,
//         orgid=400005,
//         mode=01,
//         purpose=00]
        
        var data = [String:Any]()
        
        let arrQue = stringURI.components(separatedBy:"?")
        
        //print(arrQue)
        
        if arrQue[0] == "upi://pay"{
            
            
        } else if arrQue[0] == "upi://mandate"{
            
            print("MAndate string :",arrQue[1])
            
            let arr = arrQue.last?.components(separatedBy:"&") ?? []
            
            print("Mandate arr:",arr)
            
            if arr.count > 0 {
                
                for row in arr {
                    
                    let pairs = row.components(separatedBy:"=")
                    data[pairs[0]] = pairs[1]
                    
                }
                
            }
                
                
            DispatchQueue.main.async {
            
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MandateNewReqVC") as! MandateNewReqVC
            vc.qrData = data
            vc.accountDetails = self.accountDetails
            vc.beneVpa = data["pa"] as! String
            vc.beneName = data["pn"] as! String
            vc.isFromQrScan = true
            self.navigationItem.setHidesBackButton(true, animated: false)
            self.navigationController?.pushViewController(vc, animated: true)
                
        }
            return
            
        }else if arrQue[0] == "upi://collect"{
            
            
        }else if arrQue[0] == "upiGlobal://"{
            
            
        }
        else{
            
            print(arrQue[0])
            
           // qrCheckString =  arrQue[0]
            
            
        }
        
        
        
        if arrQue.count == 2 {
            
            let arr = arrQue.last?.components(separatedBy:"&") ?? []
            
            if arr.count > 0 {
                
                for row in arr {
                    
                    let pairs = row.components(separatedBy:"=")
                    data[pairs[0]] = pairs[1]
                    
                }
                
                
                
//                if data["pa"] as? String != nil {
//                    
//                    checkvpa(vpa: data["pa"] as! String)
//                    
//                }
                    
                
                
                
                DispatchQueue.main.async {
                
//                let storyboard = UIStoryboard(name: "BhimUpi", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "PaymentUPIIDNewVC") as! PaymentUPIIDNewVC
//                vc.qrData = data
//                vc.accountDetails = self.accountDetails
//                
//                vc.beneVpa = data["pa"] as! String
//                vc.beneName = data["pn"] as! String
//                vc.isFromQrScan = true
//               // self.navigationItem.setHidesBackButton(true, animated: false)
//                self.navigationController?.pushViewController(vc, animated: true)
//                    
                   
                    let storyboard = UIStoryboard(name: "BhimUpi", bundle: nil)
                    if let vc = storyboard.instantiateViewController(withIdentifier: "PaymentUPIIDNewVC") as? PaymentUPIIDNewVC {
                        vc.qrData = data
                        vc.accountDetails = self.accountDetails
                        vc.beneVpa = data["pa"] as? String ?? ""
                        vc.beneName = data["pn"] as? String ?? ""
                        vc.isFromQrScan = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        print("Failed to instantiate PaymentUPIIDNewVC.")
                    }
                    
            }
                
               

                
                
                
            }
            
        }
        
//        DispatchQueue.main.async {
//            SwiftLoader.show(animated: true)
//        }
        
//        DispatchQueue.global(qos: .background).async {
//
//            OliveUpiManager.verifySignedQR(qrString: stringURI) { data, error in
//
//                if let err = error {
//                    if err.code == 102 { // VPA not allowed for this customer
//                        DispatchQueue.main.async {
//                            self.showErrorAlert(err.localizedDescription)
//                        }
//                    } else if err.code == 401 || err.code == 107 {
//
//                        self.configuration()
//                        return
//                    }
//                    DispatchQueue.main.async {
//                        SwiftLoader.hide()
//                    }
//
//                } else {
//                    print(data)
//
//                    if let respData = data {
//                    }
//                }
//            }
//        }
    }
    
}

extension ScanQRVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Dismiss the image picker
        picker.dismiss(animated: true, completion: nil)
        
        // Extract the selected image
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Do something with the selected image
            detectQRCode(from: pickedImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the image picker if the user cancels
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - QR Code Detection
    func detectQRCode(from image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            print("Failed to convert UIImage to CIImage")
            return
        }
        
        // Create a barcode detection request
        let request = VNDetectBarcodesRequest { (request, error) in
            if let error = error {
                print("Barcode detection error: \(error.localizedDescription)")
                return
            }
            
            guard let barcodes = request.results as? [VNBarcodeObservation] else {
                print("No barcodes found")
                return
            }
            
            // Process detected barcodes
            for barcode in barcodes {
                if let payload = barcode.payloadStringValue {
                    print("Detected QR code payload: \(payload)")
                    self.found(code: payload)
                }
            }
        }
        
        // Perform the barcode detection request
        let barcodeRequestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try barcodeRequestHandler.perform([request])
        } catch {
            print("Failed to perform barcode detection: \(error.localizedDescription)")
        }
    }
}

extension ScanQRVC: MFMessageComposeViewControllerDelegate {
    
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            checksumViewModel.loginChecksumCall(Common.shared.phoneNo ?? "", Common.shared.getDeviceID())
        }else{
            DispatchQueue.main.async {
                SwiftLoader.hide()
                self.showErrorAlert("Please check your internet connection.")
            }
            
        }
    }
    
    //MARK: Observing the data
    func observeEvent() {
        checksumViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")

            case .stopLoading:
                
                print("Stop loading...")
                
            case .dataLoaded:
                print("Data loaded...")
                if self?.checksumViewModel.checksumModel?.data?.result == "Success" {
                    Common.shared.merchantauthtoken = self?.checksumViewModel.checksumModel?.data?.data?.merchantauthtoken ?? ""
                    
                    self?.performMerchantHandshake()
                }else{
                    DispatchQueue.main.async {
                        self?.showErrorAlert(self?.checksumViewModel.checksumModel?.data?.result ?? "")
                    }
                }
                
            case .error(let error):
                print(error!)
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }
            }
        }
    }
    
    func performMerchantHandshake(){
        
        let sdkHandShake = SDKHandshake(emailId: "", merchId: MerchantId, merchChanId: MerchantId, submerchantid: SubMerchantId, mcccode: MCC, unqCustId: "91\(Common.shared.phoneNo ?? "")", mobileNo: "91\(Common.shared.phoneNo ?? "")", deviceid: Common.shared.getDeviceID(), appid: appId, custname: "MAX", merchantauthtoken: Common.shared.merchantauthtoken ?? "", unqTxnId:SDKHandshake.shared.generateRandomDigits(12))
        
        let jsonString = sdkHandShake.jsonString(sdkHandShake)
        
        OliveUpiManager.initiateSDK(sdkHandshake: jsonString,view: self , delegate: self) { (data, err) in
            print("The data is:\(String(describing: data))")
            self.verifySignedQR(stringURI: self.scannedCode)
        }
    }
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController,didFinishWith didFinishWithresult: MessageComposeResult) {
        controller.dismiss(animated: true, completion: {})
        switch didFinishWithresult {
        case .cancelled:
            print("Cancelled")
        case .sent:
            print("Message Sent")
            OliveUpiManager.sendMobileBindReqst(callback: { (data, err) in
                if let er = err{
                    print(er)
                    DispatchQueue.main.async {
                        self.showToast(message: "SMS Sent failed", font: .systemFont(ofSize: 12))
                        SwiftLoader.hide()
                    }
                }else{
                    if let dt = data{
                        print(dt)
                        self.verifySignedQR(stringURI: self.scannedCode)
                        DispatchQueue.main.async {
                            self.showToast(message: "SMS Delivered", font: .systemFont(ofSize: 12))
                        }
                    }
                }
            })
            break
        default:
            break
        }
    }
}

//extension ScanQRVC: AVCaptureMetadataOutputObjectsDelegate {
//
//    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//
//        // Check if the metadataObjects array is not nil and it contains at least one object.
//        if metadataObjects.count == 0 {
//            qrCodeFrameView?.frame = CGRect.zero
////            messageLabel.text = "No QR code is detected"
//            self.showErrorAlert("No QR code is detected")
//            return
//        }
//
//        // Get the metadata object.
//        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
//
//        if metadataObj.type == AVMetadataObject.ObjectType.qr {
//            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
//            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
//            qrCodeFrameView?.frame = barCodeObject!.bounds
//
//            if metadataObj.stringValue != nil {
////                messageLabel.text = metadataObj.stringValue
////                self.showErrorAlert(metadataObj.stringValue!)
//
//                self.verifySignedQR(stringURI: metadataObj.stringValue!)
//                self.captureSession.stopRunning()
//            }
//        }
//    }
//}



extension ScanQRVC {
    
    //MARK: API Calling
     func configurationBharatQrCall() {
         SwiftLoader.show(animated: true)
         bharatQrCall()
         observeEventBharatQr()
     }

    func bharatQrCall() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            qrBharatVM.qrBharatCall(qrCheckString)
            
        }else{
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
    }
    //MARK: Observing the data
    func observeEventBharatQr() {
        qrBharatVM.eventHandler = { [weak self] event in
            guard self != nil else { return }

            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                SwiftLoader.hide()
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    if self?.qrBharatVM.scanQrModel?.status == "success" {
                        
                       // print(self?.qrBharatVM.scanQrModel?.data)
                        
                        self?.verifySignedQR(stringURI: self?.qrBharatVM.scanQrModel?.data?.qrresponse ?? "")

                        
                      //  let urlData = self?.qrBharatVM.scanQrModel?.data?.qrresponse ?? ""
                        
                       // self?.verifySignedQR(stringURI:self?.qrBharatVM.scanQrModel?.data?.qrresponse ?? "")
                        
//                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        let vc = storyboard.instantiateViewController(withIdentifier: "OTPVerifyVC") as! OTPVerifyVC
//                        vc.isFromForgotPin = true
//                        vc.strPhoneNumber = Common.shared.phoneNo ?? ""
//                        self?.navigationController?.pushViewController(vc,animated: true)
//
                        
                        
//                        let storyboard = UIStoryboard(name: "BhimUpi", bundle: nil)
//                        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentUPIIDNewVC") as! PaymentUPIIDNewVC
//                        vc.qrData = data
//                        vc.accountDetails = self.accountDetails
//                        vc.beneVpa = data["pa"] as! String
//                        vc.beneName = data["pn"] as! String
//                        vc.isFromQrScan = true
//                        self.navigationController?.pushViewController(vc, animated: true)
//
                        
                       // verifySignedQR(stringURI: scannedCode)
                        
                        

                        
                  
                    }else{
                        self?.showErrorAlert(self?.qrBharatVM.scanQrModel?.message ?? "")
                        SwiftLoader.hide()
                    }
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
}
