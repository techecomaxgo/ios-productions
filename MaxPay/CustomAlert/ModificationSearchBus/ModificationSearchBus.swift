//
//  ModificationSearchBus.swift
//  MaxPay
//
//  Created by india on 11/12/23.
//

import UIKit

class ModificationSearchBus: UIView {

    @IBOutlet var vwMain: UIView!
    
    func setupUI(){
        if let first = Bundle.main.loadNibNamed("ModificationSearchBus", owner: self, options: nil)?.first as? UIView {
            vwMain = first
           // filteredData = arrCity
            vwMain.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            addSubview(vwMain)
        }
    }
    @IBAction func btnDateAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func btnSearchAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func btnTodayAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func btnTomorrowDateAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}
