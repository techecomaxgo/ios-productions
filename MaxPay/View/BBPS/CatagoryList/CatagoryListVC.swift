//
//  CatagoryListVC.swift
//  MaxPay
//
//  Created by india on 20/11/23.
//

import UIKit

class CatagoryListVC: BaseVC {
    
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var tblSearchCatagorySearch: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var strCatagoryImg = "", strCatagoryName = ""
    private var catagoryListViewModel = CatagoryListViewModel()
    
//    var originalData = [""]
//    var filteredData: [String]!
    
    var originalBillers: [BillerResp] = []
    var filteredBillers: [BillerResp] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSearchCatagorySearch.dataSource = self
        
        configuration()
        
        lblTitle.text = strCatagoryName
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension CatagoryListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatagorySearchCell", for: indexPath) as! CatagorySearchCell
//        let model:BillerResp = (catagoryListViewModel.catagoryListModel?.responseData?.billerResp?[indexPath.row])!
//        cell.lblCatagoryName?.text = model.billerName ?? ""
        cell.lblCatagoryName?.text = filteredBillers[indexPath.row].billerName
        let decodedData = NSData(base64Encoded: strCatagoryImg, options: [])
            if let data = decodedData {
                let decodedimage = UIImage(data: data as Data)
                cell.imgCatagory.image = decodedimage
            } else {
                print("error with decodedData")
            }
        cell.imgCatagory.setImageColors(color: UIColor(named: "primary-green")!)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBillers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "BBPS", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FetchingBillVC") as! FetchingBillVC
        vc.strImg = strCatagoryImg
        vc.strCatagoryName = filteredBillers[indexPath.row].billerName ?? ""
        self.navigationController?.pushViewController(vc,animated: true)
        vc.strBillerID = filteredBillers[indexPath.row].billerId ?? ""
    }

}

extension CatagoryListVC {
    //MARK: API Calling
    func configuration() {
        // ProgressHUD.showSucceed()
        initViewModel()
        observeEvent()
    }
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            catagoryListViewModel.catagoryListCall(strCatagoryName)
        }else{
            //  ProgressHUD.remove()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    //MARK: Observing the data
    func observeEvent() {
       // let loader =   self.loader()
        
        catagoryListViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
             //   self?.stopLoader(loader: loader)
            case .stopLoading:
                
                print("Stop loading...")
              //  self?.stopLoader(loader: loader)
            case .dataLoaded:
                print("Data loaded...")
               // self?.stopLoader(loader: loader)
                
                self?.originalBillers.removeAll()
                self?.filteredBillers.removeAll()
                
                if self?.catagoryListViewModel.catagoryListModel?.status == "success" {
//                    for i in 0..<(self?.catagoryListViewModel.catagoryListModel?.responseData?.billerResp!.count)! {
//                        self?.originalBillers.append(self?.catagoryListViewModel.catagoryListModel?.responseData?.billerResp?[i].billerName ?? "")
//                    }
                    
                    self?.originalBillers = self?.catagoryListViewModel.catagoryListModel?.responseData?.billerResp ?? []
                    self?.filteredBillers = self?.originalBillers ?? []
                    self?.tblSearchCatagorySearch.reloadData()
                }else{
                    self?.showErrorAlert("Error")
                }
                   // self?.stopLoader(loader: loader)
            case .error(let error):
                print(error!)
               // self?.stopLoader(loader: loader)
            }
        }
    }
}

extension CatagoryListVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        filteredBillers = searchText.isEmpty ? originalBillers : originalBillers.filter({(biller: BillerResp) -> Bool in
            
            return biller.billerName?.range(of: searchText, options: .caseInsensitive) != nil
        })

        tblSearchCatagorySearch.reloadData()

        return true
    }
    
}
