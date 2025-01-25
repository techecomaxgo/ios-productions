
import UIKit
class TabbarCollCell:UICollectionViewCell{
    
    @IBOutlet weak var imageTab: UIImageView!
    @IBOutlet weak var labelTap: UILabel!
    @IBOutlet weak var labelSeparator: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var constraintImgHeight: NSLayoutConstraint!
    
}

class TabbarVC: UIViewController {
    
    var tabaccountDetails: AccountDetailsOnIIN?
    
    @IBOutlet weak var tabBarCollectionView: UICollectionView!
    var selectedIndex:Int?
    var IsSelectedIndex = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       // print(selectedIndex ?? 0)
        tabBarCollectionView.delegate = self
        tabBarCollectionView.dataSource = self
        
        //tabBarCollectionView.reloadData()
        
        
 

        
    }
    
    func reloadUI(tempSelectedIndex:Int){
        IsSelectedIndex = tempSelectedIndex
        UserDefaults.standard.set(IsSelectedIndex, forKey: "selectIndex")
        tabBarCollectionView.reloadData()
    }
    
}

extension TabbarVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tabBarCollectionView.dequeueReusableCell(withReuseIdentifier: "TabbarCollCell", for: indexPath) as! TabbarCollCell
       let intIndex =  UserDefaults.standard.integer(forKey: "selectIndex")
        if (indexPath.row == 0){
            cell.labelTap.isHidden = false
            cell.constraintImgHeight.constant = 22

            cell.labelTap.text = "Home"
            cell.imageTab.image = UIImage(systemName: "house")//UIImage(named: "tab-home-ic")
            if (intIndex == indexPath.row){
                cell.imageTab.tintColor = UIColor(hexString: "9FC438") //setImageColor(color: UIColor(hexString: "9FC438"))
                cell.labelTap.textColor = UIColor(hexString: "9FC438")
                cell.labelSeparator.backgroundColor = UIColor(red: 209/255, green: 173/255, blue: 113/255, alpha: 1)
            }
            else {
                cell.imageTab.tintColor = .darkGray
                cell.labelTap.textColor = .darkGray
                cell.labelSeparator.backgroundColor = .clear
            }
            
        }
        else if (indexPath.row == 1){
            cell.labelTap.isHidden = false
            cell.constraintImgHeight.constant = 22

            cell.labelTap.text = "History"
            cell.imageTab.image = UIImage(named: "tab-myexpense-ic")
            if (intIndex == indexPath.row){
                
                cell.imageTab.setImageColor(color: UIColor(hexString: "9FC438"))
                cell.labelTap.textColor = UIColor(hexString: "9FC438")
                cell.labelSeparator.backgroundColor = UIColor(red: 209/255, green: 173/255, blue: 113/255, alpha: 1)
            } else {
                cell.imageTab.tintColor = .gray
                cell.labelTap.textColor = .gray
                cell.labelSeparator.backgroundColor = .clear
                
            }
        }
        else if (indexPath.row == 2){
            cell.labelTap.isHidden = true
            cell.constraintImgHeight.constant = 40
            
            cell.imageTab.image = UIImage(named: "tabQrscan")
            cell.labelTap.text = ""//"Scan QR"
            if (intIndex == indexPath.row){
                cell.labelTap.textColor = UIColor(hexString: "9FC438")
                cell.labelSeparator.backgroundColor = UIColor(red: 209/255, green: 173/255, blue: 113/255, alpha: 1)
            } else {
                cell.labelTap.textColor = .gray
                cell.labelSeparator.backgroundColor = .clear
                
            }
        }
        else if (indexPath.row == 3){
            cell.labelTap.isHidden = false
            cell.constraintImgHeight.constant = 22

            cell.labelTap.text = "Quiz"
            cell.imageTab.image = UIImage(named: "tab-quiz-ic")
            if (intIndex == indexPath.row){
                
                cell.imageTab.setImageColor(color: UIColor(hexString: "9FC438"))
                cell.labelTap.textColor = UIColor(hexString: "9FC438")
                cell.labelSeparator.backgroundColor = UIColor(red: 209/255, green: 173/255, blue: 113/255, alpha: 1)
            } else {
                cell.imageTab.tintColor = .gray
                cell.labelTap.textColor = .gray
                cell.labelSeparator.backgroundColor = .clear
                
            }
        }
        else if (indexPath.row == 4){
            cell.labelTap.isHidden = false
            cell.constraintImgHeight.constant = 22

            cell.labelTap.text = "Profile"
            cell.imageTab.image = UIImage(named: "tab-profile-ic")
            if (intIndex == indexPath.row){
                cell.imageTab.setImageColor(color: UIColor(hexString: "9FC438"))
                cell.labelTap.textColor = UIColor(hexString: "9FC438")
                cell.labelSeparator.backgroundColor = UIColor(red: 209/255, green: 173/255, blue: 113/255, alpha: 1)
            }
            else {
                cell.imageTab.tintColor = .darkGray
                cell.labelTap.textColor = .darkGray
                cell.labelSeparator.backgroundColor = .clear
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.IsSelectedIndex = indexPath.row
        
        if (self.IsSelectedIndex == 0){
            
            if let VC = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC {
                let navigationController = UINavigationController(rootViewController: VC)
                navigationController.isNavigationBarHidden = true
                self.view.window?.rootViewController = navigationController
            }
        }
        else if (self.IsSelectedIndex == 1){
            
            if let VC = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "TrasactionVC") as? TrasactionVC {
                let navigationController = UINavigationController(rootViewController: VC)
                navigationController.isNavigationBarHidden = true
                self.view.window?.rootViewController = navigationController
            }
        }
        else if (self.IsSelectedIndex == 2){
            
            if let VC = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "ScanQRVC") as? ScanQRVC {
              
//                VC.isFromtabBar = true
//                let navigationController = UINavigationController(rootViewController: VC)
//                navigationController.isNavigationBarHidden = true
//                self.view.window?.rootViewController = navigationController
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "ScanQRVC") as! ScanQRVC
                vc.accountDetails = tabaccountDetails
                vc.isFromtabBar = true
                self.navigationController?.pushViewController(vc, animated: true)
                
                
                
            }
        }
        else if (self.IsSelectedIndex == 3){
            
            if let VC = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "QuizVC") as? QuizVC {
                let navigationController = UINavigationController(rootViewController: VC)
                navigationController.isNavigationBarHidden = true
                self.view.window?.rootViewController = navigationController
            }
        }
        else if (self.IsSelectedIndex == 4){
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Dashboard", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "UserProfileView") as! UserProfileView
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.isNavigationBarHidden = true
            self.view.window?.rootViewController = navigationController
            
        }
        
            
        self.reloadUI(tempSelectedIndex: self.IsSelectedIndex )
            
        }
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width: self.tabBarCollectionView.frame.width/5, height: self.tabBarCollectionView.frame.size.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
    }
extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
class CurvedView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let curveHeight: CGFloat = 30.0 // Adjust the curve height as needed
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height - curveHeight))
        path.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height - curveHeight),
                          controlPoint: CGPoint(x: rect.width / 2, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
}
