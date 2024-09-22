//
//  BaseVC.swift
//  MaxPay
//
//  Created by india on 20/11/23.
//

protocol SideMenuDelegate
{
    func sideMenuItemSelectedAtIndex(_ index : Int32)
    
}


import UIKit

class BaseVC: UIViewController,SideMenuDelegate {

    var menuItems = [Dictionary<String,String>]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
    func loader() -> UIAlertController {
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.large
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            let img = UIImageView(frame: CGRect(x: 55, y: 15, width: 25, height: 25))
           img.image = UIImage(named: "english")
           alert.view.addSubview(img)
            present(alert, animated: true, completion: nil)
            return alert
        }
        
        func stopLoader(loader : UIAlertController) {
            DispatchQueue.main.async {
                loader.dismiss(animated: true, completion: nil)
            }
        }
    func showErrorAlert(_ strMsg:String){
        let alert = UIAlertController(title: "MaxUPI", message: strMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func showToast(message : String, font: UIFont = .systemFont(ofSize: 15)) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-100, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        toastLabel.layer.borderWidth = 1
        toastLabel.layer.borderColor = UIColor(hexString: "9FC438").cgColor
        toastLabel.textColor = UIColor.white
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    func sideMenuItemSelectedAtIndex(_ index: Int32)
    {
        let topViewController : UIViewController = self.navigationController!.topViewController!
        print("Base View Controller is : \(topViewController) \n")
        
        if (menuItems.indices.contains(Int(index)))
        {
            self.openViewControllerBasedOnIdentifier(menuItems[Int(index)]["vc"]!)
        }
    }
    
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String)
    {
        
        if strIdentifier != ""{
            
            let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
        
    }
    
    
    
//    func addSideMenuButton()
//    {
//        let btnMenu = UIButton.init(type: .custom)
//        btnMenu.setImage(UIImage(named: "side_menu.png"), for: UIControl.State.normal)
//        btnMenu.addTarget(self, action: #selector(self.onSideMenuButtonPressed(_:)), for: UIControl.Event.touchUpInside)
//        btnMenu.frame = CGRect(x:0, y:0, width:30, height:30)
//        
//        let barButton = UIBarButtonItem(customView: btnMenu)
//        self.navigationItem.leftBarButtonItem = barButton
//        
//    }
    
 //   @objc func onSideMenuButtonPressed(_ sender : UIBarButtonItem)
//    {
//        if (sender.tag == 10)
//        {
//            // To Hide Menu If it already there
//            self.sideMenuItemSelectedAtIndex(-1);
//            sender.tag = 0;
//            let viewMenuBack : UIView = view.subviews.last!
//            
//            UIView.animate(withDuration: 0.3,
//                           animations: {    () -> Void in
//                            var frameMenu : CGRect = viewMenuBack.frame
//                            frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
//                            viewMenuBack.frame = frameMenu
//                            viewMenuBack.layoutIfNeeded()
//                            viewMenuBack.backgroundColor = UIColor.clear
//            },
//                           completion: { (finished) -> Void in viewMenuBack.removeFromSuperview()}
//            )
//            return;
//        }
//        
//        sender.isEnabled = false
//        sender.tag = 10
//        
//        let VC : VCSideMenu = self.storyboard!.instantiateViewController(withIdentifier: "VCSideMenu") as! VCSideMenu
//        VC.btnMenu = sender
//        VC.delegate = self
//        
//        //self.view.addSubview(VC.view)
//        UIApplication.shared.keyWindow?.addSubview(VC.view)
//        self.addChild(VC)
//        VC.view.layoutIfNeeded()
//        
//        // Get the menu items(options) list from side menu panel
//        self.menuItems = VC.arrayMenuOptions
//        
//        let scrnDim = UIScreen.main.bounds.size
//        VC.view.frame=CGRect(x:0 - scrnDim.width, y:0, width:scrnDim.width, height: scrnDim.height);
//        
//        UIView.animate(withDuration: 0.3, animations: { () -> Void in
//            VC.view.frame=CGRect(x: 0, y: 0, width: scrnDim.width, height: scrnDim.height);
//            sender.isEnabled = true
//        }, completion:nil)
//        
//    }
    

    
}
