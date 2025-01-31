//
//  PayBillListVC.swift
//  MaxPay
//
//  Created by india on 20/11/23.
//

import UIKit
import Kingfisher
import SwiftLoader

class PayBillListVC: BaseVC {
    
    @IBOutlet weak var collVWPayBill: UICollectionView!
    @IBOutlet weak var collVWFavourite: UICollectionView!
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var lblFavouriteCategory: UILabel!
    private var payBillListViewModel = PayBillListViewModel()
    
    @IBOutlet weak var constraintFavouriteCollectionBottom: NSLayoutConstraint!
    var originalCategories: [Filtered_categories] = []
    var filteredCategories: [Filtered_categories] = []
    var favouriteCategories: [Filtered_categories] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true

        collVWFavourite.isHidden = favouriteCategories.count <= 0
        lblFavouriteCategory.isHidden = favouriteCategories.count <= 0
        constraintFavouriteCollectionBottom.constant = favouriteCategories.count <= 0 ? 0 : 20
        collVWFavourite.reloadData()
        collVWFavourite.layoutIfNeeded()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
}
extension PayBillListVC {
    //MARK: API Calling
    func configuration() {
        // ProgressHUD.showSucceed()
        initViewModel()
        observeEvent()
        
        // Fetch card array from user defaults
        if let decoded = Common.shared.bbpsFavouriteCategories {
            do {
                let cardList: [Filtered_categories] = try JSONDecoder().decode([Filtered_categories].self, from: decoded)
                
                for card in cardList {
                    favouriteCategories.append(card)
                }
                collVWFavourite.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            payBillListViewModel.payBillLstCall()
        }else{
            //  ProgressHUD.remove()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    //MARK: Observing the data
    func observeEvent() {
       // let loader =   self.loader()
        SwiftLoader.show(animated: true)

        payBillListViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
              //  self?.stopLoader(loader: loader)
                SwiftLoader.hide()
            case .stopLoading:
                
                print("Stop loading...")
                //  ProgressHUD.remove()
              //  self?.stopLoader(loader: loader)
                SwiftLoader.hide()
            case .dataLoaded:
                print("Data loaded...")
                    if self?.payBillListViewModel.payBillListModel?.status == "success" {
                      //  self?.stopLoader(loader: loader)
                        self?.originalCategories = self?.payBillListViewModel.payBillListModel?.filtered_categories ?? []
                        self?.filteredCategories = self?.originalCategories ?? []
                        self?.collVWPayBill.reloadData()
                    }else{
                        self?.showErrorAlert("Error")
                    }
                   // self?.stopLoader(loader: loader)
                SwiftLoader.hide()
            case .error(let error):
                print(error!)
               // self?.stopLoader(loader: loader)
                SwiftLoader.hide()
            }
        }
        SwiftLoader.hide()
    }
    func encodeToBase64(_ string: String) -> String? {
        if let data = string.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
}

extension PayBillListVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return payBillListViewModel.payBillListModel?.filtered_categories?.count ?? 0
        
        if collectionView == collVWFavourite {
            return favouriteCategories.count
        }
        
        return filteredCategories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collVWPayBill.dequeueReusableCell(withReuseIdentifier: "PayBillListCollCell", for: indexPath) as! PayBillListCollCell
        
        let category:Filtered_categories?
        
        if collectionView == collVWFavourite {
            category = favouriteCategories[indexPath.row]
        } else {
            category = filteredCategories[indexPath.row]
        }
        
//        let category = filteredCategories[indexPath.row]
        let strName = category?.categoryName
//        let strName = payBillListViewModel.payBillListModel?.filtered_categories?[indexPath.row].categoryName
        
        let urlBase64 = category?.categoryIcon ?? ""
//        let urlBase64 = payBillListViewModel.payBillListModel?.filtered_categories?[indexPath.row].categoryIcon ?? ""
        
        cell.lblName.text = "\(strName ?? "")"
        let sub = urlBase64.chopPrefix(22)
        print("the base64 string is " + sub)
        let decodedData = NSData(base64Encoded: sub, options: [])
            if let data = decodedData {
                let decodedimage = UIImage(data: data as Data)
                cell.img.image = decodedimage
            } else {
                print("error with decodedData")
            }
        cell.img.setImageColors(color: UIColor(named: "primary-green")!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5.0
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 4
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size , height: size + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        textFieldSearch.resignFirstResponder()
        
        let storyboard = UIStoryboard(name: "BBPS", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CatagoryListVC") as! CatagoryListVC
        
        let category:Filtered_categories?
        
        if collectionView == collVWFavourite {
            category = favouriteCategories[indexPath.row]
        } else {
            category = filteredCategories[indexPath.row]
        }
        
        let urlBase64 = category?.categoryIcon ?? ""
//        let urlBase64 = payBillListViewModel.payBillListModel?.filtered_categories?[indexPath.row].categoryIcon ?? ""
        let sub = urlBase64.chopPrefix(22)
        print("the base64 string is " + sub)
        vc.strCatagoryImg = sub
//        vc.strCatagoryName = payBillListViewModel.payBillListModel?.filtered_categories?[indexPath.row].categoryName ?? ""
        vc.strCatagoryName = category?.categoryName ?? ""
        
        if collectionView == collVWPayBill && !favouriteCategories.contains(where: { $0 == category })  {
            if favouriteCategories.count > 3 {
                favouriteCategories.removeLast()
            }
            favouriteCategories.insert(category!, at: 0)
            
            
//            Save cards to NSUserDefaults
            do {
                let categoryData = try JSONEncoder().encode(favouriteCategories)
                Common.shared.bbpsFavouriteCategories = categoryData
            } catch {
                print(error.localizedDescription)
            }

        }
        
        self.navigationController?.pushViewController(vc,animated: true)
    }
}

extension PayBillListVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        filterContentForSearchText(searchText)
        return true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            // If the search text is blank, use the original data
            filteredCategories = originalCategories
        } else {
            filteredCategories = originalCategories.filter { category in
                if let categoryName = category.categoryName {
                    return categoryName.lowercased().contains(searchText.lowercased())
                } else {
                    return false
                }
            }
        }
        
        // Sort the filtered array based on categoryName
        filteredCategories.sort { $0.categoryName! < $1.categoryName! }
        
        collVWPayBill.reloadData()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        filteredCategories = originalCategories
        collVWPayBill.reloadData()
        return true
    }
}
