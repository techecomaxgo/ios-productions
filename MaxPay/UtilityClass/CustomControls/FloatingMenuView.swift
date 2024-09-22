//
//  FloatingMenuView.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 23/05/24.
//

import UIKit

class FloatingMenuView: UIView {
    
    @IBOutlet var vwFloatingMenu: UIView!
    @IBOutlet var btnHome: UIButton!
    @IBOutlet var ivHomeBorder: UIImageView!
    @IBOutlet var btnMyPost: UIButton!
    @IBOutlet var ivMyPostBorder: UIImageView!
    var parentVC:LostAndFoundViewController?
    var parentPostVC:MyPostVC?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Override Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    // MARK: -  Common Method
    
    private func commonInit(){
        Bundle.main.loadNibNamed(KFloatingMenuView, owner: self, options: nil)
        addSubview(vwFloatingMenu)
        vwFloatingMenu.frame = self.bounds
        vwFloatingMenu.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    
    // MARK: -  Action Method
    
    @IBAction func btnPostClicked(_ sender: UIButton) {
        if parentVC != nil{
            parentVC?.presentPostOptionView()
        }
    }
    @IBAction func btnHomeClicked(_ sender: UIButton) {
        let tittle2 = NSAttributedString(string: "My Post", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark) as Any,NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnMyPost.setAttributedTitle(tittle2, for: .normal)
        self.ivMyPostBorder.isHidden = true
        self.btnHome.setTitleColor(UIColor(named: KThemeLightGreen), for: .normal)
        let tittle = NSAttributedString(string: "Home", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeLightGreen) as Any,NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnHome.setAttributedTitle(tittle, for: .normal)
        self.ivHomeBorder.isHidden = false
        if parentVC != nil{
            parentVC?.hidePostView()
        }else{
            parentPostVC?.hidePostView()
        }
    }
    
    @IBAction func btnMyPostClicked(_ sender: UIButton) {
        let tittle = NSAttributedString(string: "My Post", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeLightGreen) as Any,NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnMyPost.setAttributedTitle(tittle, for: .normal)
        self.ivMyPostBorder.isHidden = false
        self.btnHome.setTitleColor(UIColor(named: KThemeTextDark), for: .normal)
        self.ivHomeBorder.isHidden = true
        let tittle2 = NSAttributedString(string: "Home", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark) as Any,NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnHome.setAttributedTitle(tittle2, for: .normal)
        parentVC?.showPostView()
        
    }
}
