//
//  CircleViewController.swift
//  MaxPay
//
//  Created by Ios Developer on 19/05/24.
//

protocol selectCircleProtocol {
    
    func selectedCircleInfo(CircleName:String?)
    
    
    
}


import UIKit

import SwiftLoader

class CircleViewController: BaseVC {
    
    var  selectCircleDelegate : selectCircleProtocol?

    @IBOutlet weak var btnCircle: UIButton!
    
    @IBOutlet weak var tableViewCircle: UITableView!
    
    private var circleView_Model =  CircleView_Model()
    
    
    var circleNamesArr : [String]?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            circleView_Model.CircleZoneCall(skeyStr: "142418AgQWGaSEHXoQ58ae75c4")

            observeOperatorApi()
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
        
        
    }
    
    @IBAction func btnCircleClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    //MARK: Observing the data
    func observeOperatorApi() {
        
        circleView_Model.eventHandler = { [weak self] event in
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
                    
                    if self?.circleView_Model.circlezoneModel?.status == "success" {
                        
                        self?.circleNamesArr = self?.circleView_Model.circlezoneModel?.circle_names
                        
                        DispatchQueue.main.async {
                            self?.tableViewCircle.reloadData()
                            SwiftLoader.hide()
                        }
                        
                    }else{
                        
                        self?.showErrorAlert(self?.circleView_Model.circlezoneModel?.status ?? "")

                        
                    }
                    
                    
                    
                        
      
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
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


extension CircleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.circleNamesArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CircleTableViewCell") as! CircleTableViewCell
        
        cell.lblZone.text = self.circleNamesArr?[indexPath.row]
        
        
       // cell.setOperatorCellData(operatorCellData: operatorResData?[indexPath.row])
        
//        let contact = operatorResData?[indexPath.row]
//
//        cell.lblName.text = contact.contactName
//        cell.lblMobileOrUpi.text = contact.contactNumbers
//
//        if let imageData = contact.thumbnailImageData {
//            cell.imgContact.image = UIImage(data: imageData)
//        } else {
//            // Set a placeholder image if no contact image is available
//            cell.imgContact.image = UIImage(named: "me_profile")
//        }
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectCircleDelegate?.selectedCircleInfo(CircleName: self.circleNamesArr?[indexPath.row])
        
        
        //operatorSelectDelegate?.selectedOperatorInfo(operatorName: operatorResData?[indexPath.row].operator_name ?? "", serviceType: operatorResData?[indexPath.row].service_type ?? "")
        
        self.dismiss(animated: true, completion: nil)

        
    }
    

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    
}
