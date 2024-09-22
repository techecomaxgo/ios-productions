//  Side Menu - VCSideMenu.swift
//  Created by Vikas Ninawe on 12/11/17.
//  Copyright © 2017 VSN. All rights reserved.
//

import UIKit

class VCSideMenu: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tblVwMenuOptions: UITableView!
    @IBOutlet weak var vwSidePanel: UIView!
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var btnCloseMenuOverlay: UIButton!
    
    var arrayMenuOptions = [Dictionary<String,String>]()
    var btnMenu : UIButton!
    var delegate : SideMenuDelegate?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        lblUsername.text = "\(Common.shared.userFirstName ?? "") \(Common.shared.userLastName ?? "")"
      
        tblVwMenuOptions.dataSource = self
        tblVwMenuOptions.delegate = self
        tblVwMenuOptions.backgroundColor = UIColor.white
        
        imgProfilePic.layer.masksToBounds = false
        imgProfilePic.layer.cornerRadius = imgProfilePic.frame.height*0.5
        imgProfilePic.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        updateArrayMenuOptions()
    }

    func updateArrayMenuOptions()
    {
        arrayMenuOptions.append(["title":"Your Rank", "icon":"rankPic", "vc":"RankingViewController"])
        arrayMenuOptions.append(["title":"Your Chain", "icon":"chainPic", "vc":"ChainViewController"])
        arrayMenuOptions.append(["title":"Your Milestone", "icon":"miles", "vc":"MilesViewController"])
        arrayMenuOptions.append(["title":"Monthly Contest", "icon":"me_monthly_contest", "vc":""])
       
        arrayMenuOptions.append(["title":"Setting", "icon":"me_settings", "vc":""])
       // arrayMenuOptions.append(["title":"Log Out", "icon":"me_logout", "vc":""])

        tblVwMenuOptions.reloadData()
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!)
    {
        btnMenu.tag = 0
        
        if (self.delegate != nil)
        {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay)
            {
                index = -1
            }
            delegate?.sideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations:
        { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        },completion:
            {   (finished) -> Void in
                self.view.removeFromSuperview() //@ need to check
            self.removeFromParent()
            })
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.backgroundColor = UIColor.clear
        
        let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        
        imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            return 70;
        }
        return 60;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayMenuOptions.count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
}
