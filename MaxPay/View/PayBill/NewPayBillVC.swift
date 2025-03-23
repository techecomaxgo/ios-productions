//
//  NewPayBillVC.swift
//  MaxPay
//
//  Created by india on 20/03/25.
//

import UIKit
struct Paybildata {
    let headerName: String
    let categories: [CategoryItem] // Subcategories with images
}

struct CategoryItem {
    let name: String
    let imageName: String // Image asset name
}
class NewPayBillVC: BaseVC, PayBillListCellDelegate {
    
    @IBOutlet weak var SearchtextField: UITextField!
    @IBOutlet weak var PayBillisttbt: UITableView!
    
    var showList: [Paybildata] = []  // Original data
    var filteredList: [Paybildata] = [] // Filtered data for search
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ✅ Setup delegate & data source
        PayBillisttbt.delegate = self
        PayBillisttbt.dataSource = self
        SearchtextField.delegate = self
        
        // ✅ Load the original data
        showList = [
            Paybildata(headerName: "Favourite", categories: [
                CategoryItem(name: "Electricity", imageName: "Electricity Icon"),
                CategoryItem(name: "Credit Card", imageName: "creditcardnew"),
                CategoryItem(name: "Gas", imageName: "Gas"),
                CategoryItem(name: "Water", imageName: "Water")
            ]),
            Paybildata(headerName: "Recharges", categories: [
                CategoryItem(name: "Mobile Prepaid", imageName: "Mobilepostped"),
                CategoryItem(name: "Fastag", imageName: "FastTag"),
                CategoryItem(name: "Mobile Postpaid", imageName: "Mobilepospetd")
            ]),
            Paybildata(headerName: "Essentials", categories: [
                CategoryItem(name: "Broadband Postpaid", imageName: "Broadband"),
                CategoryItem(name: "Gas", imageName: "Gas"),
                CategoryItem(name: "LPG Gas", imageName: "LPG"),
                CategoryItem(name: "Electricity", imageName: "Electricity Icon"),
                CategoryItem(name: "Landline Postpaid", imageName: "Landline")
            ]),
            Paybildata(headerName: "Finances", categories: [
                CategoryItem(name: "Credit Card", imageName: "creditcardnew"),
                CategoryItem(name: "Insurance", imageName: "Insurance"),
                CategoryItem(name: "Loan", imageName: "Loan"),
                CategoryItem(name: "Recurring Deposit", imageName: "Recurring"),
            ]),
            Paybildata(headerName: "Home & Rentals", categories: [
                
                CategoryItem(name: "Clubs and Associations", imageName: "Club Assoction"),
                CategoryItem(name: "Housing Society", imageName: "Housing Socitey"),
                CategoryItem(name: "Municipal Services", imageName: "Muncipal House"),
                CategoryItem(name: "Municipal Taxes", imageName: "Muncipal"),
                CategoryItem(name: "Rental", imageName: "Rental"),
            ]),
            Paybildata(headerName: "Entertainment", categories: [
                CategoryItem(name: "Cable TV", imageName: "Water"),
                CategoryItem(name: "DTH", imageName: "DTH")
            ]),
            Paybildata(headerName: "Others", categories: [
                CategoryItem(name: "Hospital", imageName: "Hospital"),
                CategoryItem(name: "Education", imageName: "Education")
            ])
        ]
        
        // ✅ Initially show full data
        filteredList = showList
        PayBillisttbt.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    func didSelectCategory(category: CategoryItem) {
        let storyboard = UIStoryboard(name: "BBPS", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CatagoryListVC") as! CatagoryListVC
        vc.strCatagoryImg = category.imageName
        vc.strCatagoryName = category.name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}
extension NewPayBillVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PayBillListCellTableViewCell", for: indexPath) as! PayBillListCellTableViewCell
        cell.selectionStyle = .none
        cell.configure(with: filteredList[indexPath.row])
        cell.delegate = self
        cell.headelbl.text = filteredList[indexPath.row].headerName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if filteredList[indexPath.row].headerName == "Favourite" {
            return 190
        }else if filteredList[indexPath.row].headerName == "Recharges" {
            return 190
        }
        else if filteredList[indexPath.row].headerName == "Essentials" {
            return 300
        } else if filteredList[indexPath.row].headerName == "Finances" {
            return 190
        } else if filteredList[indexPath.row].headerName == "Home & Rentals" {
            return 300
        } else if filteredList[indexPath.row].headerName == "Entertainment" {
            return 190
        } else if filteredList[indexPath.row].headerName == "Other" {
            return 190
        }
        return UITableView.automaticDimension
    }
}

// MARK: - Search Functionality
extension NewPayBillVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // ✅ Get updated search text
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // ✅ Call search function
        filterTableData(searchText: newText)
        
        return true
    }
    
    func filterTableData(searchText: String) {
        if searchText.isEmpty {
            filteredList = showList // ✅ If empty, show full data
        } else {
            filteredList = showList.map { paybill in
                let filteredCategories = paybill.categories.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                return Paybildata(headerName: paybill.headerName, categories: filteredCategories)
            }
            .filter { !$0.categories.isEmpty } // ✅ Remove empty sections
        }
        
        PayBillisttbt.reloadData() // ✅ Reload TableView with filtered data
    }
}

