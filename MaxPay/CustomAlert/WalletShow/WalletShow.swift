//
//  WalletShow.swift
//  MaxPay
//
//  Created by india on 17/11/23.
//

import UIKit
@objc protocol WalletShowDelegate: NSObjectProtocol {
    @objc optional func btnBlock()
    @objc optional func btnRejected()
    
}

class WalletShow: UIView {

    weak var delegate:BlockalertViewDelegate? = nil
    @IBOutlet weak var vwBackBalance: UIView!
    @IBOutlet weak var vwBack: UIView!
    @IBOutlet weak var btnHidden: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var vwBackHeight: NSLayoutConstraint!
    
    let minHeight: CGFloat = 240
    let maxHeight: CGFloat = 400

    func setupUI(_ strUrl:String){
        if let first = Bundle.main.loadNibNamed("WalletShow", owner: self, options: nil)?.first as? UIView {
            mainView = first
//            btnCancel.clipsToBounds = true
//            btnCancel.layer.cornerRadius = 3
//            btnCancel.layer.borderWidth = 1
//            btnCancel.layer.borderColor = UIColor(hexString: "9FC438").cgColor
            mainView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            vwBack.addGestureRecognizer(panGesture)
            addSubview(mainView)
        }
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
           let translation = recognizer.translation(in: vwBack)
           
           // Calculate the new height based on the gesture translation
           var newHeight = vwBack.frame.height + translation.y
           
           // Ensure the new height stays within the specified range
           newHeight = min(maxHeight, max(minHeight, newHeight))

           // Update the view's frame with the new height
        vwBack.frame = CGRect(x: vwBack.frame.origin.x, y: vwBack.frame.origin.y, width: vwBack.frame.width, height: newHeight)
           
           // Reset the translation to avoid continuous incremental changes
           recognizer.setTranslation(CGPoint.zero, in: vwBack)
           
           // Handle the gesture state to perform actions when the gesture ends
           if recognizer.state == .ended {
               //vwBackHeight.constant = 240
               print("End")
           }else{
               vwBackHeight.constant = 400
               print("start")
           }
        
       }

    @IBAction func btnBackAction(_ sender: Any) {
        self.removeFromSuperview()
    }
}
