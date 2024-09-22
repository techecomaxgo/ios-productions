//
//  RechargePlanViewController.swift
//  MaxPay
//
//  Created by Ios Developer on 15/05/24.
//

import UIKit


import UIKit
import AVFoundation
import SwiftLoader


class RechargePlanViewController: BaseVC {
    
    @IBOutlet weak var imgForMymobile: UIImageView!
    

    @IBOutlet weak var btnChange: UIButton!
    
    private var rechargeAllPlanVM =  RechargePlansViewModel()

    var plansDict : Plans?
    
    var plansViewModelData : DataSubPlans?
    
    var commonAllData: [TOPUP]? = []
    
    
    var topUpAllData: [TOPUP]? = []
    
    var fULLTTAllData: [FULLTT]? = []
    var DATAallData: [DATA]? = []
    var RomaingAllData: [Romaing]? = []
    var FRCAllData: [FRC]? = []
    var JioPhoneAllData: [JioPhone]? = []
    
    var selectedItemStr = ""

    //var topUpAllData: [SMS]? = []
//    var topUpAllData: [TOPUP]? = []
//    var topUpAllData: [TOPUP]? = []
//    var topUpAllData: [TOPUP]? = []
//    var topUpAllData: [TOPUP]? = []

    
    /*
     let fULLTT : [FULLTT]?
     let tOPUP : [TOPUP]?
     let dATA : [DATA]?
     let sMS : String?
     let rATE_CUTTER : String?
     let twoG : String?
     let romaing : [Romaing]?
     let cOMBO : String?
     let fRC : [FRC]?
     let jioPhone : [JioPhone]?
     let sTV : String?
     */

    @IBOutlet weak var tablePlansView: UITableView!
    
    @IBOutlet weak var lblMobnumber: UILabel!
    
    @IBOutlet weak var lblLasrRechargeDate: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var viewShowBackground: UIView!
    
    @IBOutlet weak var segControl: CollectionViewSegmentedControl!
    
    
    var contactNo = ""
    var skeyStr = ""
    
    override func viewDidLoad() {
        
        print(contactNo)
        print(skeyStr)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configurationRechargeAllCall()
        
        btnChange.layer.applyCornerRadiusShadow()
        
        imgForMymobile.layer.applyCornerRadiusShadow()
        
        setUIData()
        
    }
    
    func setUIData(){
        
        let contactStr = contactNo.removeWhitespace() // Thequickbrowndogjumpsoverthefoxylady.

        print(contactStr)
        
        Common.shared.userMobile_NUMBER  = contactStr
        
        lblMobnumber.text = contactStr
      
        //lblLasrRechargeDate.text =  "\(Common.shared.r ?? "")"
       // lblLocation.text = "\(Common.shared.phoneNo ?? "")"
        
        viewShowBackground.layer.applyCornerRadiusShadow()
        
    }
    
    
    
    
   
    
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

    @IBAction func btnChangeClicked(_ sender: UIButton) {
        
        let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectOperatorPopupView")  as! SelectOperatorPopupView
        
        //popOverVC.userName = contracterData.name ?? ""
        //popOverVC.ContractorPassData = contracterData
        //popOverVC.delegateYesSelectContractor = self

        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        self.addChild(popOverVC)
        
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

extension RechargePlanViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var countData = 0
        
        if  selectedItemStr == "TOPUP" {
       
            countData = topUpAllData?.count ?? 0

           
       }else if  selectedItemStr == "DATA" {
           
       
           countData = DATAallData?.count ?? 0

           
       }else if  selectedItemStr == "FULLTT" {
           
           countData = fULLTTAllData?.count ?? 0

           
       }else if  selectedItemStr == "FRC" {
           
           countData = FRCAllData?.count ?? 0

           
       }else if  selectedItemStr == "JioPhone" {
   
           countData = JioPhoneAllData?.count ?? 0
      

           
       }else if  selectedItemStr == "Romaing" {
           
       
           countData = RomaingAllData?.count ?? 0
           

           
       }else {
           
           
       }
        
        return countData

        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tablePlansView.dequeueReusableCell(withIdentifier: "RechargePlanTVC") as! RechargePlanTVC
        
        if  selectedItemStr == "TOPUP" {
    
            cell.setTopUpDataData(topUpData: topUpAllData?[indexPath.row])
           
       }else if  selectedItemStr == "DATA" {
           
           cell.setAllData(topUpData: DATAallData?[indexPath.row])
           
       }else if  selectedItemStr == "FULLTT" {
           
           cell.setFULLData(topUpData: fULLTTAllData?[indexPath.row])
           
       }else if  selectedItemStr == "FRC" {
           
           cell.setFRCData(topUpData: FRCAllData?[indexPath.row])
           
       }else if  selectedItemStr == "JioPhone" {
   
           cell.setJioPhData(topUpData: JioPhoneAllData?[indexPath.row])

       }else if  selectedItemStr == "Romaing" {
                  
           cell.setRomDataData(topUpData: RomaingAllData?[indexPath.row])
           
       }else {
           
           
       }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 180
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //PlanViewPopupVC
        
        
        
        
        let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "PlanViewPopupVC")  as! PlanViewPopupVC
        
        //popOverVC.userName = contracterData.name ?? ""
        //popOverVC.ContractorPassData = contracterData
        //popOverVC.delegateYesSelectContractor = self
        
        popOverVC.selectedPopStr = selectedItemStr
        
        
        if  selectedItemStr == "TOPUP" {
           // cell.setTopUpDataData(topUpData: topUpAllData?[indexPath.row])
            //print(topUpAllData?[indexPath.row])
            
            popOverVC.priceStr = "\(topUpAllData?[indexPath.row].rs ?? 0)"
            popOverVC.validityStr = "\(topUpAllData?[indexPath.row].validity ?? "0")"
            popOverVC.descriptionStr = "\(topUpAllData?[indexPath.row].desc ?? "0")"
            
           // popOverVC.setTopUpDataData(topUpData: topUpAllData?[indexPath.row])

            

       }else if  selectedItemStr == "DATA" {
           

           popOverVC.priceStr = "\(DATAallData?[indexPath.row].rs ?? 0)"
           popOverVC.validityStr = "\(DATAallData?[indexPath.row].validity ?? "0")"
           popOverVC.descriptionStr = "\(DATAallData?[indexPath.row].desc ?? "0")"

          // print(DATAallData?[indexPath.row])
           
       }else if  selectedItemStr == "FULLTT" {
           
           popOverVC.priceStr = "\(fULLTTAllData?[indexPath.row].rs ?? 0)"
           popOverVC.validityStr = "\(fULLTTAllData?[indexPath.row].validity ?? "0")"
           popOverVC.descriptionStr = "\(fULLTTAllData?[indexPath.row].desc ?? "0")"
           popOverVC.descriptionStr = "\(fULLTTAllData?[indexPath.row].desc ?? "0")"


           
           // print(fULLTTAllData?[indexPath.row])
           
       }else if  selectedItemStr == "FRC" {

           popOverVC.priceStr = "\(FRCAllData?[indexPath.row].rs ?? 0)"
           popOverVC.validityStr = "\(FRCAllData?[indexPath.row].validity ?? "0")"
           popOverVC.descriptionStr = "\(FRCAllData?[indexPath.row].desc ?? "0")"


           //print(FRCAllData?[indexPath.row])
           
       }else if  selectedItemStr == "JioPhone" {
   
           popOverVC.priceStr = "\(JioPhoneAllData?[indexPath.row].rs ?? 0)"
           popOverVC.validityStr = "\(JioPhoneAllData?[indexPath.row].validity ?? "0")"
           popOverVC.descriptionStr = "\(JioPhoneAllData?[indexPath.row].desc ?? "0")"

          // print(JioPhoneAllData?[indexPath.row])

       }else if  selectedItemStr == "Romaing" {
                  
           popOverVC.priceStr = "\(RomaingAllData?[indexPath.row].rs ?? 0)"
           popOverVC.validityStr = "\(RomaingAllData?[indexPath.row].validity ?? "0")"
           popOverVC.descriptionStr = "\(RomaingAllData?[indexPath.row].desc ?? "0")"

          // print(RomaingAllData?[indexPath.row])
           
       }else {
           
           
       }

        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        self.addChild(popOverVC)

        
    }
    
    
    
}


extension RechargePlanViewController {
    
    
    
    @IBAction func SegmentTapped(_ sender: CollectionViewSegmentedControl) {
        
        //selectedIndexLabel.text = "\(sender.selectedIndex)"
        //selectedItemLabel.text = "\(sender.selectedItem)"
        
        print("\(sender.selectedIndex)")
        print("\(sender.selectedItem)")
        
        selectedItemStr = "\(sender.selectedItem)"
        
         if  selectedItemStr == "TOPUP" {
             
             self.DATAallData = []
             self.fULLTTAllData = []
             self.FRCAllData = []
             self.JioPhoneAllData = []
             self.RomaingAllData = []
             self.topUpAllData = []

        
             self.topUpAllData = self.plansViewModelData?.plans?.tOPUP

            
        }else if  selectedItemStr == "DATA" {
            
            self.DATAallData = []
            self.fULLTTAllData = []
            self.FRCAllData = []
            self.JioPhoneAllData = []
            self.RomaingAllData = []
            self.topUpAllData = []
        
            self.DATAallData = self.plansViewModelData?.plans?.dATA

            
        }else if  selectedItemStr == "FULLTT" {
            
            self.DATAallData = []
            self.fULLTTAllData = []
            self.FRCAllData = []
            self.JioPhoneAllData = []
            self.RomaingAllData = []
            self.topUpAllData = []
            
            self.fULLTTAllData = self.plansViewModelData?.plans?.fULLTT

            
        }else if  selectedItemStr == "FRC" {
            
            self.DATAallData = []
            self.fULLTTAllData = []
            self.FRCAllData = []
            self.JioPhoneAllData = []
            self.RomaingAllData = []
            self.topUpAllData = []
            
            self.FRCAllData = self.plansViewModelData?.plans?.fRC

            
        }else if  selectedItemStr == "JioPhone" {
            
            self.DATAallData = []
            self.fULLTTAllData = []
            self.FRCAllData = []
            self.JioPhoneAllData = []
            self.RomaingAllData = []
            self.topUpAllData = []
    
            self.JioPhoneAllData = self.plansViewModelData?.plans?.jioPhone

            
        }else if  selectedItemStr == "Romaing" {
            self.DATAallData = []
            self.fULLTTAllData = []
            self.FRCAllData = []
            self.JioPhoneAllData = []
            self.RomaingAllData = []
            self.topUpAllData = []
        
            self.RomaingAllData = self.plansViewModelData?.plans?.romaing

            
        }else {
            
            
        }
        

        
        DispatchQueue.main.async
        {
        
            self.tablePlansView.reloadData()

        }
        
        
    }
    
    
    //MARK: API Calling
     func configurationRechargeAllCall() {
         SwiftLoader.show(animated: true)
        
         rechargeAllCall()
        
         observeRechargePlanApi()
         
     }

    func rechargeAllCall() {
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            let contactStr = contactNo.removeWhitespace() // Thequickbrowndogjumpsoverthefoxylady.

            print(contactStr)
            
            // 7007439651
            
            rechargeAllPlanVM.rechargePlanCall(numStr: "7007439651", skey: "142418AgQWGaSEHXoQ58ae75c4")
            
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    
    //MARK: Observing the data
    func observeRechargePlanApi() {
        
        rechargeAllPlanVM.eventHandler = { [weak self] event in
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
                                        
                   // print((self?.rechargeAllPlanVM.rechargeAllModel?.data?.plans)!)
                    
                    SwiftLoader.hide()
                    
                    self?.topUpAllData = []
                    self?.fULLTTAllData = []
                    self?.DATAallData = []
                    self?.RomaingAllData = []
                    self?.FRCAllData = []
                    self?.JioPhoneAllData = []
                    
                    if self?.rechargeAllPlanVM.rechargeAllModel?.data.success != false {
                        
                    self?.plansViewModelData = self?.rechargeAllPlanVM.rechargeAllModel?.data

                   // print(self!.plansViewModelData)
                        
                        // Access the plans dictionary
                        
                        self?.plansDict = self?.plansViewModelData?.plans
                        
 
                        // Usage example
                        let keys = Plans.nonStringKeys()
                        print(keys)
                        
                        self?.segControl.items = keys
                        
                        
                        self?.topUpAllData = self?.plansViewModelData?.plans?.tOPUP
                        
                        self?.fULLTTAllData = self?.plansViewModelData?.plans?.fULLTT
                        
                        self?.DATAallData = self?.plansViewModelData?.plans?.dATA
                        
                        self?.RomaingAllData = self?.plansViewModelData?.plans?.romaing
                        
                        self?.FRCAllData = self?.plansViewModelData?.plans?.fRC
                        
                        self?.JioPhoneAllData = self?.plansViewModelData?.plans?.jioPhone
                        
                        
                        //if self?.plansViewModelData?.plans
                        
                        self?.selectedItemStr = self?.segControl.items[0] ?? ""

                        
                        if  self?.segControl.items[0] == "TOPUP" {
                            
                       
                            self?.topUpAllData = self?.plansViewModelData?.plans?.tOPUP

                           
                       }else if  self?.segControl.items[0] == "DATA" {
                           
                       
                           self?.DATAallData = self?.plansViewModelData?.plans?.dATA

                           
                       }else if  self?.segControl.items[0] == "FULLTT" {
                           
                           self?.fULLTTAllData = self?.plansViewModelData?.plans?.fULLTT

                           
                       }else if  self?.segControl.items[0] == "FRC" {
                           
                           self?.FRCAllData = self?.plansViewModelData?.plans?.fRC

                           
                       }else if  self?.segControl.items[0] == "JioPhone" {
                   
                           self?.JioPhoneAllData = self?.plansViewModelData?.plans?.jioPhone

                           
                       }else if  self?.segControl.items[0] == "Romaing" {
                           
                       
                           self?.RomaingAllData = self?.plansViewModelData?.plans?.romaing

                           
                       }else {
                           
                           
                       }
                        
                        
                        
                        
                        DispatchQueue.main.async
                        {
                        
                            self?.tablePlansView.reloadData()

                        }
                        

                        
                        
                    }else{
                        
                        self?.showErrorAlert(self?.rechargeAllPlanVM.rechargeAllModel?.data.message ?? "")

                        //print(self?.rechargeAllPlanVM.rechargeAllModel?.data)

                        
                    }
                        
                        
                        
                    
                    
//                    
//                    if self?.rechargeAllPlanVM.checksumModel?.status == "success" {
//                        
//                        print(self?.rechargeAllPlanVM.rechargeAllModel?.data!)
//                        
//                  
//                    }else{
//                        
//                        //self?.showErrorAlert(self?.rechargeAllPlanVM.rechargeAllModel?.data?.message ?? "")
//                        print(self?.rechargeAllPlanVM.rechargeAllModel?.data)
//                        SwiftLoader.hide()
//                    }
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
}

// Extension to get keys
// Extension to get keys
//extension Plans {
//    static func allKeys() -> [String] {
//        return [
//            CodingKeys.fULLTT.rawValue,
//            CodingKeys.tOPUP.rawValue,
//            CodingKeys.dATA.rawValue,
//            CodingKeys.sMS.rawValue,
//            CodingKeys.rATE_CUTTER.rawValue,
//            CodingKeys.twoG.rawValue,
//            CodingKeys.romaing.rawValue,
//            CodingKeys.cOMBO.rawValue,
//            CodingKeys.fRC.rawValue,
//            CodingKeys.jioPhone.rawValue,
//            CodingKeys.sTV.rawValue
//        ]
//    }
//}


extension Plans {
    static func nonStringKeys() -> [String] {
        let allKeys: [CodingKeys: Any.Type] = [
            .fULLTT: [FULLTT].self,
            .tOPUP: [TOPUP].self,
            .dATA: [DATA].self,
            .sMS: String.self,
            .rATE_CUTTER: String.self,
            .twoG: String.self,
            .romaing: [Romaing].self,
            .cOMBO: String.self,
            .fRC: [FRC].self,
            .jioPhone: [JioPhone].self,
            .sTV: String.self
        ]

        return allKeys
            .filter { $0.value != String.self }
            .map { $0.key.rawValue }
    }
}


extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
  }
