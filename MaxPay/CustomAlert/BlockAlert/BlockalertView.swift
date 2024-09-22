//
//  BlockalertView.swift
//  MaxPay
//
//  Created by india on 15/11/23.
//

import UIKit
@objc protocol BlockalertViewDelegate: NSObjectProtocol {
    @objc optional func btnBlock()
    @objc optional func btnRejected()
    
}

class BlockalertView: UIView {

    weak var delegate:BlockalertViewDelegate? = nil
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet var mainView: UIView!
    func setupUI(_ strUrl:String){
        if let first = Bundle.main.loadNibNamed("BlockalertView", owner: self, options: nil)?.first as? UIView {
            mainView = first
            btnCancel.clipsToBounds = true
            btnCancel.layer.cornerRadius = 3
            btnCancel.layer.borderWidth = 1
            btnCancel.layer.borderColor = UIColor(hexString: "9FC438").cgColor
            mainView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            addSubview(mainView)
        }
    }
        @IBAction func btnBlcockAction(_ sender: Any) {
            self.removeFromSuperview()
            if let del = delegate{
                del.btnBlock?()
            }
        }
        @IBAction func btnCancelAction(_ sender: Any) {
            self.removeFromSuperview()
        }
        @IBAction func btnRejectAction(_ sender: Any) {
            self.removeFromSuperview()
            if let del = delegate{
                 del.btnRejected?()
            }
        }
    }
