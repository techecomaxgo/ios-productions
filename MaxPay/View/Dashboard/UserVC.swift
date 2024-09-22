//
//  UserVC.swift
//  TabbarDemo
//
//  Created by Susant Nahak on 04/11/23.
//

import UIKit

struct UserModelDashboard {
    let strNameContent:String?
    let strImage:String?
}

class UserVC: UIViewController {

    @IBOutlet weak var collVWUser: UICollectionView!
    
    let arrUserModel = [UserModelDashboard(strNameContent: "Profile", strImage: "me_profile"),UserModelDashboard(strNameContent: "Rank", strImage: "me_rank"),UserModelDashboard(strNameContent: "Chain", strImage: "me_chain"),UserModelDashboard(strNameContent: "Milestone", strImage: "me_milestone"),UserModelDashboard(strNameContent: "Monthly Content", strImage: "me_monthly_contest"),UserModelDashboard(strNameContent: "Settings", strImage: "me_settings"),UserModelDashboard(strNameContent: "Privecy Policy", strImage: "me_ppolicy"),UserModelDashboard(strNameContent: "Logout", strImage: "me_logout")]
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
   

}
extension UserVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrUserModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collVWUser.dequeueReusableCell(withReuseIdentifier: "UserDashboardCollVWCell", for: indexPath) as! UserDashboardCollVWCell
        let arr = arrUserModel[indexPath.row]
        cell.imgContent.image = UIImage(named: arr.strImage ?? "")
        cell.lblName.text = arr.strNameContent ?? ""
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        if indexPath.row == 0{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 7 {
            
            print("7")
            let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                    alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { action in
                        self.logoutUser()
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
            
        }else{
            
           
            
            
        }
        
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
   

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 1.0
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 2

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size , height: size)
    }
    
    
    
}
