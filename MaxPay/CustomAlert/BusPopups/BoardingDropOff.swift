//
//  BoardingDropOff.swift
//  MaxPay
//
//  Created by india on 06/12/23.
//

import UIKit
import SwiftyJSON

class BoardingDropOff: UIView {

    @IBOutlet weak var tblLocation: UITableView!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    
    var isBoarding = false
    var arrPoints = [JSON]()
    
    func setupUI(){
        if let first = Bundle.main.loadNibNamed("BoardingDropOff", owner: self, options: nil)?.first as? UIView {
            vwMain = first
            
            vwMain.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            addSubview(vwMain)
        }
        
        DispatchQueue.main.async {
            self.tblLocation.layoutIfNeeded()
            self.tblLocation.reloadData()
            self.constraintTableHeight.constant = self.tblLocation.contentSize.height > 600 ? 600 : self.tblLocation.contentSize.height + 100
            self.lblTitle.text = self.isBoarding ? "Boarding Point" : "Dropping Point"
        }
    }
    
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}

extension BoardingDropOff: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPoints.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 45
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        
        let labelTime = UILabel(frame: CGRect(x: 10, y: 15, width: 60, height: 20))
        labelTime.text = isBoarding ? Common.shared.convertTo12HourFormatIfNeeded(arrPoints[indexPath.row]["time"].stringValue) :  Common.shared.convertTo12HourFormatIfNeeded(arrPoints[indexPath.row]["dpTime"].stringValue)
        labelTime.textColor = UIColor(named: "reload-grey-color")
        labelTime.font = UIFont(name: "Roboto-Medium", size: 12)
        cell.addSubview(labelTime)

        let labelName = UILabel(frame: CGRect(x: 80, y: 15, width: UIScreen.main.bounds.width - 120, height: 20))
        labelName.text = isBoarding ? arrPoints[indexPath.row]["bdLongName"].stringValue : arrPoints[indexPath.row]["dpName"].stringValue
        labelName.textColor = UIColor(named: "card-number")
        labelName.font = UIFont(name: "Roboto", size: 12)
        cell.addSubview(labelName)

        return cell
    }
    
}
