//
//  PaymentTag.swift
//  MaxPay
//
//  Created by india on 06/12/23.
//

import UIKit
import SwiftyJSON
import SwiftLoader

@objc protocol PaymentTagViewDelegate: NSObjectProtocol {
    @objc optional func popBack()
}


class PaymentTag: UIView {

    weak var delegate:PaymentTagViewDelegate? = nil

    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var viewTags: UIView!
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    
    var txnId = "" //"AXIF7C1929249404488A55D4F077B6E48C6"
    var selectedTag = ""
    var isBoarding = false
    var arrPoints = [JSON]()
    
    private var complaintViewModel = ComplaintViewModel()

    func setupUI(){
        if let first = Bundle.main.loadNibNamed("PaymentTag", owner: self, options: nil)?.first as? UIView {
            vwMain = first
            
            vwMain.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            addSubview(vwMain)
        }
        
        
    }
    
    
    @IBAction func btnTags(_ sender: UIButton) {
        
        for view in viewTags.subviews {
            if view is UIButton {
                let btn = view as! UIButton
                
                if btn.titleLabel!.text != "Done" {
                    
                    btn.setTitleColor(UIColor(named: "card-number-color"), for: .normal)
                    btn.layer.borderWidth = 1
                    btn.backgroundColor = .clear
                    
                    selectedTag = btn.titleLabel?.text ?? ""
                }
            }
        }
        
        sender.setTitleColor(UIColor(named: "white-color"), for: .normal)
        sender.layer.borderWidth = 0
        sender.backgroundColor = UIColor(named: "primary-green")
        
    }
    
    @IBAction func btnDoneAction(_ sender: Any) {
        
        if selectedTag == "" {
            
            return
        }

        configurationForComplaintList()
    }
}

extension PaymentTag {
    
    func configurationForComplaintList() {
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        initViewModel()
        observeEventForComplaintSearch()
    }
    
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            complaintViewModel.transactionTaggingModel(txnid: txnId, tag: selectedTag)
        }else{
            DispatchQueue.main.async {
                SwiftLoader.hide()
//                self.showErrorAlert("Please check your internet connection.")
            }
        }
    }
    
    //MARK: Observing the data
    func observeEventForComplaintSearch() {
        
        complaintViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }
                
            case .dataLoaded:
                print("Data loaded...")
                                
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    
                    if let status = self?.complaintViewModel.complaintRegisterModel?.status {
                        
                        if status.lowercased() == "success" {
                            
                            self?.removeFromSuperview()
                            if let del = self?.delegate{
                                del.popBack?()
                            }
                        } else {

                            self?.removeFromSuperview()
                            if let del = self?.delegate{
                                del.popBack?()
                            }

//                            self?.showErrorAlert(self?.complaintViewModel.complaintRegisterModel?.message ?? "")
   
                        }
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
}
