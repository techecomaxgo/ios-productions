//
//  BusCancallation.swift
//  MaxPay
//
//  Created by india on 06/12/23.
//

import UIKit
import SwiftyJSON

class BusCancallation: UIView {

    @IBOutlet weak var tblBusCancallation: UITableView!
    @IBOutlet weak var vwMain: UIView!
    
    var arrCancallationPolicyList = [JSON]()
    var price = "0"
    
    func setupUI(){
        
        if let first = Bundle.main.loadNibNamed("BusCancallation", owner: self, options: nil)?.first as? UIView {
            vwMain = first
            vwMain.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            addSubview(vwMain)
        }
        
        tblBusCancallation.register(UINib(nibName: "CancellationPolicyCell", bundle: nil), forCellReuseIdentifier: "cell")
        tblBusCancallation.register(UINib(nibName: "CancellationPolicyTitleCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "cell")
        tblBusCancallation.register(UINib(nibName: "CancellationPolicyFooter", bundle: nil), forHeaderFooterViewReuseIdentifier: "cell1")
        
    }
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}
extension BusCancallation: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "cell") as! CancellationPolicyTitleCell
        return headerView
    }
        
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "cell1") as! CancellationPolicyFooter
        return footerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCancallationPolicyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CancellationPolicyCell
        cell.selectionStyle = .none
        
        cell.lblTermOfCanellation.text = convertToCancellationTerm(rule: arrCancallationPolicyList[indexPath.row])
        
        let percentageCharge = arrCancallationPolicyList[indexPath.row]["percentageCharge"].doubleValue
        let percentageAmount = (percentageCharge / 100) * (Double(price) ?? 0)
//        let finalPrice = (Double(price) ?? 0) - percentageAmount
        let outputString = String(format: "₹%.0f/%.0f (%.0f%%)", percentageAmount, (Double(price) ?? 0), percentageCharge)

        cell.lblCanellationCharges.text = outputString
        
        
        return cell
    }
    
    func convertToCancellationTerm(rule: JSON) -> String? {
        
        let timeFrom = rule["timeFrom"].intValue
        let timeTo = rule["timeTo"].intValue
        
        let term: String
        let timeFromDate = Date().addingTimeInterval(TimeInterval(timeFrom * 3600))
        let timeToDate = Date().addingTimeInterval(TimeInterval(timeTo * 3600))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E dd MMM HH:mm"
        
        let timeFromStr = dateFormatter.string(from: timeFromDate)
        let timeToStr = timeTo == -1 ? "Before" : "After"
        let timeToStrAppendix = timeTo == -1 ? "" : dateFormatter.string(from: timeToDate)
        
        term = "\(timeToStr) \(timeFromStr) \(timeToStrAppendix)"
        
        return term
    }
    
}


