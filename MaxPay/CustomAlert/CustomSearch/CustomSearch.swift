//
//  CustomSearch.swift
//  MaxPay
//
//  Created by india on 06/12/23.
//

import UIKit
@objc protocol CustomSearchDelegate: NSObjectProtocol {
    func clickCity(_ selectedIndex:Int,_ strCityName:String)
    
}
class CustomSearch: UIView,UISearchBarDelegate{

    @IBOutlet weak var tblCity: UITableView!
    @IBOutlet weak var vwMain: UIView!
    weak var delegate:CustomSearchDelegate?
    var arrCity = [String]()
    var filteredData: [String]!
    func setupUI(){
        if let first = Bundle.main.loadNibNamed("CustomSearch", owner: self, options: nil)?.first as? UIView {
            vwMain = first
            filteredData = arrCity
            vwMain.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            addSubview(vwMain)
        }
    }
    @IBAction func btnCloseAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? arrCity : arrCity.filter({(dataString: String) -> Bool in
            
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        tblCity.reloadData()
    }
}
extension CustomSearch:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 45
    }
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if( !(cell != nil))
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell!.textLabel!.font = UIFont(name: "Roboto", size: 14)
        cell!.textLabel!.text = filteredData[indexPath.row]
        cell!.textLabel!.numberOfLines = 2
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
        print("The selected indexis:\(indexPath.row)")
        for var i in 0..<arrCity.count {
            if arrCity[i] == filteredData[indexPath.row]{
                delegate?.clickCity(i, filteredData[indexPath.row])
            }
        }
        
    }
}
