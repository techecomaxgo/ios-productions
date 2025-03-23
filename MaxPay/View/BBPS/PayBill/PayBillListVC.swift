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
   
    
    @IBOutlet weak var constraintFavouriteCollectionBottom: NSLayoutConstraint!
    var originalCategories: [PayBillCategoriesModel] = []
    var filteredCategories: [PayBillCategoriesModel] = []
    var favouriteCategories: [PayBillCategoriesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addData()
               filteredCategories = originalCategories
               collVWPayBill.reloadData()
    }
    
   

    func addData() {
        originalCategories.append(PayBillCategoriesModel(name: "Favourite", imageName: "", isHeader: true))
       
        originalCategories.append(PayBillCategoriesModel(name: "Electricity", imageName: "Electricity Icon", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Credit Card", imageName: "creditcardnew", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Gas", imageName: "Gas", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Water", imageName: "Water", isHeader: false))
       
        
        originalCategories.append(PayBillCategoriesModel(name: "Recharges", imageName: "", isHeader: true))
        
        originalCategories.append(PayBillCategoriesModel(name: "Mobile Prepaid", imageName: "Water", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Fastag", imageName: "FastTag", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Mobile Postpaid", imageName: "Water", isHeader: false))
        
        
        originalCategories.append(PayBillCategoriesModel(name: "Essentials", imageName: "", isHeader: true))
        
        originalCategories.append(PayBillCategoriesModel(name: "Broadband Postpaid", imageName: "Broadband", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Gas", imageName: "Gas", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "LPG Gas", imageName: "Water", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Water", imageName: "Water", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Electricity", imageName: "Electricity Icon", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Landline Postpaid", imageName: "Water", isHeader: false))
        
       
        originalCategories.append(PayBillCategoriesModel(name: "Finances", imageName: "", isHeader: true))
        
        originalCategories.append(PayBillCategoriesModel(name: "Credit Card", imageName: "Water", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Insurance", imageName: "Water", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Loan", imageName: "Water", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Recurring Deposit", imageName: "Water", isHeader: false))
     
       // originalCategories.append(PayBillCategoriesModel(name: "Health Insurance", imageName: "life_insurance", isHeader: false))
       // originalCategories.append(PayBillCategoriesModel(name: "Life Insurance", imageName: "health_insurance", isHeader: false))
        
        originalCategories.append(PayBillCategoriesModel(name: "Home & Rentals", imageName: "", isHeader: true))
        
        originalCategories.append(PayBillCategoriesModel(name: "Clubs and Associations", imageName: "Club Assoction", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Housing Society", imageName: "Housing Socitey", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Municipal Services", imageName: "Muncipal House", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Municipal Taxes", imageName: "Muncipal", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Rental", imageName: "Rental", isHeader: false))
        
        originalCategories.append(PayBillCategoriesModel(name: "Entertainment", imageName: "", isHeader: true))
        
        originalCategories.append(PayBillCategoriesModel(name: "Cable TV", imageName: "Water", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "DTH", imageName: "Water", isHeader: false))
       
        
        originalCategories.append(PayBillCategoriesModel(name: "Others", imageName: "", isHeader: true))
        
        originalCategories.append(PayBillCategoriesModel(name: "Hospital", imageName: "Water", isHeader: false))
        originalCategories.append(PayBillCategoriesModel(name: "Education", imageName: "Water", isHeader: false))
       
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

extension PayBillListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // If collectionView is for favourites, return the count of favourite categories
        if collectionView == collVWFavourite {
            return favouriteCategories.count
        }

        // Return the count of filtered categories
        return filteredCategories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collVWPayBill.dequeueReusableCell(withReuseIdentifier: "PayBillListCollCell", for: indexPath) as! PayBillListCollCell

        let category: PayBillCategoriesModel?

        // Determine which collection view to pull data from
        if collectionView == collVWFavourite {
            category = favouriteCategories[indexPath.row]
        } else {
            category = filteredCategories[indexPath.row]
        }

        // Category name
        let strName = category?.name ?? ""

        // Pass only the image name as a string (not the actual image)
        cell.lblName.text = strName
        
        // For demonstration, we'll use image name directly, not base64 decoding
        if let imageName = category?.imageName {
            cell.img.image = UIImage(named: imageName)  // Load the image from assets using the image name
        } else {
            cell.img.image = nil
        }

        // Set image tint color (if needed)
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
        
        return CGSize(width: size, height: size + 30)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        textFieldSearch.resignFirstResponder()

        // Instantiate the CategoryListVC
        let storyboard = UIStoryboard(name: "BBPS", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CatagoryListVC") as! CatagoryListVC

        let category: PayBillCategoriesModel?

        // Determine which collection view to pull data from
        if collectionView == collVWFavourite {
            category = favouriteCategories[indexPath.row]
        } else {
            category = filteredCategories[indexPath.row]
        }

        // Pass the image name (not the actual UIImage) to the next VC
        vc.strCatagoryImg = category?.imageName ?? ""  // Passing image name as a string
        vc.strCatagoryName = category?.name ?? ""

        // Handle favourite categories logic
//        if collectionView == collVWPayBill && !favouriteCategories.contains(where: { $0 == category }) {
//            if favouriteCategories.count > 3 {
//                favouriteCategories.removeLast()
//            }
//            favouriteCategories.insert(category!, at: 0)
//
//            // Save favourite categories to UserDefaults
//            do {
//                let categoryData = try JSONEncoder().encode(favouriteCategories)
//                Common.shared.bbpsFavouriteCategories = categoryData
//            } catch {
//                print(error.localizedDescription)
//            }
//        }

        // Push to the next view controller
        self.navigationController?.pushViewController(vc, animated: true)
    }


    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        filteredCategories = originalCategories
        collVWPayBill.reloadData()
        return true
    }
}



//extension PayBillListVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return payBillListViewModel.payBillListModel?.filtered_categories?.count ?? 0
//
//        if collectionView == collVWFavourite {
//            return favouriteCategories.count
//        }
//
//        return filteredCategories.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collVWPayBill.dequeueReusableCell(withReuseIdentifier: "PayBillListCollCell", for: indexPath) as! PayBillListCollCell
//
//        let category:Filtered_categories?
//
//        if collectionView == collVWFavourite {
//            category = favouriteCategories[indexPath.row]
//        } else {
//            category = filteredCategories[indexPath.row]
//        }
//
////        let category = filteredCategories[indexPath.row]
//        let strName = category?.categoryName
////        let strName = payBillListViewModel.payBillListModel?.filtered_categories?[indexPath.row].categoryName
//
//        let urlBase64 = category?.categoryIcon ?? ""
////        let urlBase64 = payBillListViewModel.payBillListModel?.filtered_categories?[indexPath.row].categoryIcon ?? ""
//
//        cell.lblName.text = "\(strName ?? "")"
//        let sub = urlBase64.chopPrefix(22)
//        print("the base64 string is " + sub)
//        let decodedData = NSData(base64Encoded: sub, options: [])
//            if let data = decodedData {
//                let decodedimage = UIImage(data: data as Data)
//                cell.img.image = decodedimage
//            } else {
//                print("error with decodedData")
//            }
//        cell.img.setImageColors(color: UIColor(named: "primary-green")!)
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            return 5.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let noOfCellsInRow = 4
//
//        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//
//        let totalSpace = flowLayout.sectionInset.left
//        + flowLayout.sectionInset.right
//        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
//
//        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
//
//        return CGSize(width: size , height: size + 30)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        textFieldSearch.resignFirstResponder()
//
//        let storyboard = UIStoryboard(name: "BBPS", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "CatagoryListVC") as! CatagoryListVC
//
//        let category:PayBillCategoriesModel?
//
//        if collectionView == collVWFavourite {
//            category = favouriteCategories[indexPath.row]
//        } else {
//            category = filteredCategories[indexPath.row]
//        }
//
//
//        vc.strCatagoryImg = category?.image ?? ""
//
//        vc.strCatagoryName = category?.name ?? ""
//
//        if collectionView == collVWPayBill && !favouriteCategories.contains(where: { $0 == category })  {
//            if favouriteCategories.count > 3 {
//                favouriteCategories.removeLast()
//            }
//            favouriteCategories.insert(category!, at: 0)
//
//
////            Save cards to NSUserDefaults
//            do {
//                let categoryData = try JSONEncoder().encode(favouriteCategories)
//                Common.shared.bbpsFavouriteCategories = categoryData
//            } catch {
//                print(error.localizedDescription)
//            }
//
//        }
//
//        self.navigationController?.pushViewController(vc,animated: true)
//    }
//}
//
//extension PayBillListVC: UITextFieldDelegate {
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//        filterContentForSearchText(searchText)
//        return true
//    }
//
//    func filterContentForSearchText(_ searchText: String) {
//        if searchText.isEmpty {
//            // If the search text is blank, use the original data
//            filteredCategories = originalCategories
//        } else {
//            filteredCategories = originalCategories.filter { category in
//                if let categoryName = category.categoryName {
//                    return categoryName.lowercased().contains(searchText.lowercased())
//                } else {
//                    return false
//                }
//            }
//        }
//
//        // Sort the filtered array based on categoryName
//        filteredCategories.sort { $0.categoryName! < $1.categoryName! }
//
//        collVWPayBill.reloadData()
//    }
//
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        filteredCategories = originalCategories
//        collVWPayBill.reloadData()
//        return true
//    }

struct PayBillCategoriesModel {
    var name: String
    var imageName: String
    var isHeader: Bool

    // Initializer to easily create an instance of PayBillCategoriesModel
    init(name: String, imageName: String, isHeader: Bool) {
        self.name = name
        self.imageName = imageName
        self.isHeader = isHeader
    }
}
