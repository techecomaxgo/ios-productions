//
//  UserProfileView.swift
//  MaxPay
//
//  Created by Ios Developer on 25/05/24.
//

import UIKit

class UserProfileView: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    private var cardsArr:[AccountDetailsOnIIN] = []

    var primaryAccount: AccountDetailsOnIIN?
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblMobileNumber: UILabel!
    
    @IBOutlet weak var lblUpi: UILabel!
    
    @IBOutlet weak var lblBankdetails: UILabel!
    
    @IBOutlet weak var btnCopy: UIButton!
    
    @IBOutlet weak var btnVerify: UIButton!
    
    @IBOutlet weak var btnChain: UIButton!
    
    @IBOutlet weak var stackViewBack: UIStackView!
    
    @IBOutlet weak var collectionCardView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    let numberOfItems = 0 // Number of items in the collection view

    @IBOutlet weak var btnLogout: UIButton!
    
    @IBOutlet weak var viewCardBack: UIView!
    
    
    @IBOutlet weak var btnMilestone: UIButton!
    
    
    override func viewDidLoad() 
    {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImageView.image = UIImage(named: "milstonebrandstarPics")
        btnVerify.layer.cornerRadius = 10
        btnVerify.layer.borderColor = UIColor.black.cgColor
        btnVerify.layer.borderWidth = 1.0
        lblUserName.text = "\(Common.shared.userFirstName ?? "") \(Common.shared.userLastName ?? "")"
        lblMobileNumber.text = Common.shared.hideFirstSixDigits(of: Common.shared.phoneNo ?? "", hideCount: 6)
        
        NSLayoutConstraint.activate([
            customButton.widthAnchor.constraint(equalToConstant: 329),
            customButton.heightAnchor.constraint(equalToConstant: 187)
        ])
        
        self.customButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        if cardsArr.count <= 0 {
            
            
            //return
            
            
        } else {
            for card in cardsArr {
                
                if card.maskedAccnumber == Common.shared.primaryAccNo {
                    
                    primaryAccount = card
                    
                    break
                }else{
                    primaryAccount = card
                    
                }
            }
        }
        
        
        
        
        btnLogout.layer.cornerRadius = 12

       // btnLogout.clipsToBounds = true
        btnLogout.layer.masksToBounds = true
        
        viewCardBack.layer.cornerRadius = 12
        viewCardBack.layer.masksToBounds = true

        viewCardBack.backgroundColor = UIColor.white
        viewCardBack.layer.shadowColor = UIColor.lightGray.cgColor
        viewCardBack.layer.shadowOpacity = 0.8
        viewCardBack.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewCardBack.layer.shadowRadius = 6.0
        viewCardBack.layer.masksToBounds = false
        
        
        
        stackViewBack.layer.cornerRadius = 12
        stackViewBack.layer.masksToBounds = true

        stackViewBack.backgroundColor = UIColor.white
        stackViewBack.layer.shadowColor = UIColor.lightGray.cgColor
        stackViewBack.layer.shadowOpacity = 0.8
        stackViewBack.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        stackViewBack.layer.shadowRadius = 6.0
        stackViewBack.layer.masksToBounds = false


        
        //stackViewBack.layer.applyCornerRadiusShadow()
        
        collectionCardView.dataSource = self
        collectionCardView.delegate = self
        // Enable paging
        collectionCardView.isPagingEnabled = true // Disable default paging
            
        let nib = UINib(nibName: "ProfileCardCVC", bundle: nil)
        collectionCardView.register(nib, forCellWithReuseIdentifier: "ProfileCardCVC")
        
        
        // Set up the page control
        pageControl.numberOfPages = numberOfItems
        pageControl.currentPage = 0
        
        
        // Configure the collection view layout
        
        if let layout = collectionCardView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10 // Space between cells
            let width = collectionCardView.frame.width * 0.8 // Adjust this value to show the next half cell
            let height = collectionCardView.frame.height
            layout.itemSize = CGSize(width: width, height: height)
            collectionCardView.contentInsetAdjustmentBehavior = .never
            collectionCardView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) // Adjust to show part of the next cell
            
            
        }

        
        
    }
    
    
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           // Show the tab bar when this view is about to appear           
           navigationController?.setNavigationBarHidden(true, animated: animated)

       }
    
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//         super.viewWillAppear(animated)
//         navigationController?.setNavigationBarHidden(true, animated: animated)
//     }
    
//
//     override func viewWillDisappear(_ animated: Bool) {
//         super.viewWillDisappear(animated)
//         navigationController?.setNavigationBarHidden(true, animated: animated)
//     }
        
        
    
    
    @IBAction func btnVerifyClicked(_ sender: UIButton) {
        
        
        
    }
    
    
    @IBAction func btnCopyClicked(_ sender: UIButton) {
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems == 0 ? 1 : numberOfItems
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if numberOfItems != 0 {
            let cell = collectionCardView.dequeueReusableCell(withReuseIdentifier: "ProfileCardCVC", for: indexPath) as! ProfileCardCVC
            
            cell.lblName.text = "Kotak Mahindra Bank"
            //  cell.accountLabel.text = "XXXX 2973"
            //  cell.upiLabel.text = "thakurhira.1999@okkotak"
            //  cell.manageButton.setTitle("Manage", for: .normal)
            //cell.btnClickProfil
            
            cell.btnManage.tag = indexPath.row
            cell.btnClickProfile.tag = indexPath.row
            
            cell.btnManage.addTarget(self, action:#selector(buttonManageTapped), for: .touchUpInside)
            cell.btnClickProfile.addTarget(self, action:#selector(buttonEditTapped), for: .touchUpInside)
            
            
            return cell
        }else{
            
            let cell = collectionCardView.dequeueReusableCell(withReuseIdentifier: "ProfileCardCVC", for: indexPath) as! ProfileCardCVC
            cell.contentView.addSubview(self.customButton)
                    
                    // Set button constraints
                    
                    
                    // Add button action
                    
            cell.lblName.text = ""
            cell.imgBack.image = UIImage(named: "my-card2-ic")
            
            cell.btnManage.tag = indexPath.row
            cell.btnClickProfile.tag = indexPath.row
            
            cell.btnManage.addTarget(self, action:#selector(buttonManageTapped), for: .touchUpInside)
            cell.btnClickProfile.addTarget(self, action:#selector(buttonEditTapped), for: .touchUpInside)
            
            
            return cell
        }
    }
    
    let customButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("Add Card", for: .normal)
        button.backgroundColor  = .clear
            button.setTitleColor(.white, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "my-card2-ic"), for: .normal)
            return button
        }()
    
    @objc private func buttonTapped() {
           print("Button was tapped!")
       }
    
    @objc func buttonEditTapped() {
        print("Button was tapped!")
        
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc,animated: true)
    }
    
    @objc func buttonManageTapped() {
        print("Button was tapped!")
        
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ManageAccountVC") as! ManageAccountVC
        self.navigationController?.pushViewController(vc,animated: true)
        
    }
    
    @objc func addCardBtn(_ sender: UIButton) {}
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
  
        
        
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width * 0.8 // Adjust this value to show the next half cell
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10 // Space between cells
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            updatePageControl()
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if !decelerate {
                updatePageControl()
            }
        }
        
        private func updatePageControl() {
            
            let pageWidth = collectionCardView.frame.width * 0.8 + 10 // Width of one page plus spacing
            let currentPage = Int((collectionCardView.contentOffset.x + pageWidth / 2) / pageWidth)
            pageControl.currentPage = currentPage
            let offset = CGPoint(x: CGFloat(currentPage) * pageWidth, y: 0)
            collectionCardView.setContentOffset(offset, animated: true)
            
        }
    
    
    
    @IBAction func btnProfileClicked(_ sender: UIButton) {
        
        
//        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "PollsViewController") as! PollsViewController
//        self.navigationController?.pushViewController(vc,animated: true)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(vc, animated: true)

        
        
    }
    
    
    @IBAction func btnMilstoneClicked(_ sender: Any) {
        
        
        
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MilesViewController") as! MilesViewController
        self.navigationController?.pushViewController(vc,animated: true)
        
        
        
    }
    
    
    @IBAction func btnQRClicked(_ sender: UIButton) {
        
        
//        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "PollsViewController") as! PollsViewController
//        self.navigationController?.pushViewController(vc,animated: true)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
        vc.accountDetails = primaryAccount
        self.navigationController?.pushViewController(vc, animated: true)

        
        
    }
    
    
    
    
    @IBAction func btnRankClicked(_ sender: UIButton) {
        
        //RankingViewController
        
        
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RankingViewController") as! RankingViewController
        self.navigationController?.pushViewController(vc,animated: true)
        
    }
    
    
    
    @IBAction func btnChainClicked(_ sender: UIButton) {
        //ChainViewController
        
        
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChainViewController") as! ChainViewController
        self.navigationController?.pushViewController(vc,animated: true)
        
        
    }
    
    
    
    
    @IBAction func btnLogoutClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { action in
                    self.logoutUser()
                }))
                
                self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func logoutUser() {
           // Remove auth token
//           let keychain = Keychain(service: "com.max.ecomaxgo.maxpay")
//           do {
//               try keychain.remove("authToken")
//           } catch let error {
//               print("Error removing token: \(error)")
//           }
           
           // Clear user data
//           UserDefaults.standard.removeObject(forKey: "userData")
//           UserDefaults.standard.synchronize()
        
        
        Common.shared.isLoggedIn = false
        Common.shared.token = ""
        Common.shared.userFirstName =  ""
        Common.shared.userLastName = ""
           
           // Navigate to login screen
//           if let window = UIApplication.shared.keyWindow {
//               let storyboard = UIStoryboard(name: "Main", bundle: nil)
//               let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
//               window.rootViewController = loginVC
//               window.makeKeyAndVisible()
//           }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegistractionVC") as! RegistractionVC
        self.navigationController?.pushViewController(vc,animated: true)
        
        
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



