//
//  RoundView.swift
//  SettingNeeds
//
//  Created by Efflorescence 1 on 16/11/18.
//  Copyright © 2018 Efflorescence. All rights reserved.
//

import UIKit

@IBDesignable
class RoundView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    @IBInspectable override var borderWidth: CGFloat {
        didSet {
            self.layer.borderWidth = self.borderWidth
            // self.layer.masksToBounds = self.borderWidth > 0
        }
    }
    @IBInspectable override var cornerRadius: CGFloat {
        didSet{
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    @IBInspectable var borderCColor:UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
        didSet{
            self.layer.borderColor = self.borderColor?.cgColor
        }
    }
    @IBInspectable var addShadow:Bool = true{

            didSet(newValue) {
                if(newValue == true){
                    self.layer.masksToBounds = false
                    self.layer.shadowColor = UIColor.black.cgColor
                    self.layer.shadowOpacity = 0.5
                    self.layer.shadowOffset = CGSize(width: 5, height: 5)
                    self.layer.shadowRadius = 3

                    self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
                    self.layer.shouldRasterize = true
                    self.layer.rasterizationScale =  UIScreen.main.scale
                    print("trying to use shadow")
                }
            }

        }
    func customizeView(){
        // self.layer.borderWidth = 6
        //self.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.layer.masksToBounds = true
        dropShadow(scale: true)
        //clipsToBounds = true
    }
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 6
        
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        self.layer.masksToBounds = true
    }

}
