//
//  SelectCityViewController.swift
//  MaxPay
//
//  Created by Admin on 04/07/24.
//

protocol cityFlightSelectedDelegate {
    
    func popCityCodeSelected(cityCode:String,cityName:String,idStr:Int,comeFrom:String)
    
}


import UIKit
import SwiftLoader

class SelectCityViewController: BaseVC,UITextFieldDelegate {
    
    var delegatecityFlightSelect : cityFlightSelectedDelegate?

    var searchActive : Bool = false


    @IBOutlet weak var textCity: UITextField!
    
    var comeFrom = ""
    
    private var originCityViewModel =  OriginCityViewModel()

    var citySelectListArr : [Airports]? = []
    
    var filteredCityList: [Airports]? = []


    @IBOutlet weak var tableViewCity: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textCity.delegate = self
        
        textCity.setLeftPadding()
        textCity.setRightPadding()
        
        if comeFrom == "Origin" {
            
            textCity.placeholder = "From where?"
            textCity.layer.cornerRadius = 10
            textCity.layer.borderWidth = 1.0
            textCity.layer.borderColor = UIColor.gray.cgColor

           

            
            
        }else{
            
            // Customize the second text field
            textCity.placeholder = "To where?"
            textCity.layer.cornerRadius = 10
            textCity.layer.borderWidth = 1.0
            textCity.layer.borderColor = UIColor.gray.cgColor
            
        }
        
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            DispatchQueue.main.async {
                                
                SwiftLoader.show(animated: true)
                
            }
            
            originCityViewModel.OriginCityModelApiCall(skeyStr: "142418AgQWGaSEHXoQ58ae75c4", pageStr: 500)
            observeCityApi()
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
        
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        searchCity(with: updatedText)
        return true
        
    }
        
        func searchCity(with query: String) {
            
            if query != "" {
                
                
                searchActive = true
                
                filteredCityList = citySelectListArr?.filter { $0.cityName?.lowercased().contains(query.lowercased()) ?? false }
                
                DispatchQueue.main.async
                {
                    
                    //self.tableViewCity.isHidden = false
                    self.tableViewCity.reloadData()
                    
                }
                
            }else {
                
                
                searchActive = false
                
                
                let isConnected = ReachabilityClass.isConnectedToNetwork()
                
                if isConnected == true {
                    
                    DispatchQueue.main.async {
                                        
                        SwiftLoader.show(animated: true)
                        
                    }
                    
                    originCityViewModel.OriginCityModelApiCall(skeyStr: "142418AgQWGaSEHXoQ58ae75c4", pageStr: 500)
                    observeCityApi()
                    
                }else{
                    
                    SwiftLoader.hide()
                    self.showErrorAlert("Please check your internet connection.")
                    
                }
                
            }
            
        }
        
    
    
    
    
    //MARK: Observing the data
    func observeCityApi() {
        
        
        originCityViewModel.eventHandler = { [weak self] event in
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
                                        
//                print((self?.rankVM.rankModelBase?.data)!)
                    
                    SwiftLoader.hide()
                    
                    self?.citySelectListArr = []
                    
                    self?.filteredCityList = []
                    
                    if self?.originCityViewModel.cityOriginBase?.status == "1" {
                        
                        self?.citySelectListArr = self?.originCityViewModel.cityOriginBase?.data?.airports
                        
                       // print(" citySelectListArr : ", self?.citySelectListArr?.count)

                        DispatchQueue.main.async {
                            
                            self?.tableViewCity.reloadData()
                            
                            SwiftLoader.hide()
                            
                        }
                        
                        
                    }else{
                        
                        self?.showErrorAlert(self?.originCityViewModel.cityOriginBase?.status ?? "")
                        
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



extension SelectCityViewController: UITableViewDelegate, UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if searchActive == false{
            
            return self.citySelectListArr?.count ?? 0
            
          //  print(" citySelectListArr : ", self.citySelectListArr?.count)

            
        }else{
            
           // print(" filteredCityList : ", self.filteredCityList?.count)

            return self.filteredCityList?.count ?? 0

            
        }
        
        
        

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableViewCity.dequeueReusableCell(withIdentifier: "SelectCityFlightTVC") as! SelectCityFlightTVC
        
        
        cell.lblCityCode.layer.cornerRadius = 4
        cell.lblCityCode.layer.borderWidth = 1.0
        cell.lblCityCode.layer.borderColor = UIColor.gray.cgColor
        
        if searchActive == false{
            
            cell.lblCityName.text = self.citySelectListArr?[indexPath.row].cityName ?? ""
            
            cell.lblAirportName.text =  self.citySelectListArr?[indexPath.row].airportName ?? ""
            
            cell.lblCityCode.text = self.citySelectListArr?[indexPath.row].cityCode ?? ""
            
        }else{
            
            cell.lblCityName.text = self.filteredCityList?[indexPath.row].cityName ?? ""
            
            cell.lblAirportName.text =  self.filteredCityList?[indexPath.row].airportName ?? ""
            
            cell.lblCityCode.text = self.filteredCityList?[indexPath.row].cityCode ?? ""
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchActive == false{
            
        if self.citySelectListArr?[indexPath.row].cityName ?? "" != "" {
            
            delegatecityFlightSelect?.popCityCodeSelected(cityCode:  self.citySelectListArr?[indexPath.row].cityCode ?? "", cityName: self.citySelectListArr?[indexPath.row].cityName ?? "", idStr: self.citySelectListArr?[indexPath.row].id ?? 0, comeFrom: comeFrom)
            
        }
        
    }else{
        
        if self.filteredCityList?[indexPath.row].cityName ?? "" != "" {
            
            delegatecityFlightSelect?.popCityCodeSelected(cityCode:  self.filteredCityList?[indexPath.row].cityCode ?? "", cityName: self.filteredCityList?[indexPath.row].cityName ?? "", idStr: self.filteredCityList?[indexPath.row].id ?? 0, comeFrom: comeFrom)
            
        }
        
        
    }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
        
    }
    
    
    
}
