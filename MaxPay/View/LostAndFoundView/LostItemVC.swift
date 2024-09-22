//
//  LostItemVC.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 23/05/24.
//

import UIKit
import DropDown
import OpalImagePicker
import Photos

class LostItemVC: UIViewController {
    @IBOutlet var vwCategories: UIView!
    @IBOutlet var vwCity: UIView!
    @IBOutlet var lblSelCat: UILabel!
    @IBOutlet var txtLocation: UITextField!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtNumber: UITextField!
    @IBOutlet var txtItemName: UITextField!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var cvItems: UICollectionView!
    @IBOutlet weak var tvDescription: TextViewWithPlaceholder!
    @IBOutlet weak var tvAddress: TextViewWithPlaceholder!
    @IBOutlet var txtCity: UITextField!
    @IBOutlet var btnAddImage: UIButton!
    @IBOutlet var btnSubmit: UIButton!
   
    let dropDown = DropDown()
    let imagePicker = OpalImagePickerController()
    
    var dataSource: [AnyObject]?
    var pageIndex = 0
    var buttonDataSource: [String]?
    var strTitle = ""
    var arrImages = [UIImage]()
    var isLost = true
    var postLostImageAPIManager = PostLostItemAPIManager()
    let categoryAPIManager = CategoriesAPIManager()
    var arrCategories = [CategoryData]()
    
    let randomIP = "\(Int.random(in: 0 ... 200))" + "." + "\(Int.random(in: 0 ... 200))" + "." + "\(Int.random(in: 0 ... 200))" + "." + "\(Int.random(in: 0 ... 200))"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callCategoriesAPI()
        setImagePicker()
        lblTitle.text = strTitle
        
        let tittle2 = NSAttributedString(string: "Submit", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark2) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 16.0)!])
        btnSubmit.setAttributedTitle(tittle2, for: .normal)
        let tittle = NSAttributedString(string: "  Add Image", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark2) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 14.0)!])
        btnAddImage.setAttributedTitle(tittle, for: .normal)
    }
    // MARK: - Custom Methods
    
    func setImagePicker(){
        imagePicker.maximumSelectionsAllowed = 5
    }
    
    func setDropDown(){
        // The view to which the drop down will appear on
        dropDown.anchorView = vwCategories // UIView or UIBarButtonItem
        // The list of items to display. Can be changed dynamically
        var arrCatNames = [String]()
        for category in arrCategories{
            if let name = category.name{
                arrCatNames.append(name)
            }
        }
        dropDown.dataSource = arrCatNames
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height) ?? 300)
        dropDown.backgroundColor = .white
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            lblSelCat.text = item
            lblSelCat.textColor = UIColor(named: KThemeTextDark2)
        }
        // Will set a custom width instead of the anchor view width
        dropDown.width = self.vwCategories.frame.width //- 38
    }
    
    func currDateInIso()->String{
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.dateFormat = isoDateFormat
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        let iso8601String = dateFormatter.string(from: Date())
        return iso8601String
    }
    
    func checkValidation()->Bool{
        if txtItemName.text!.count == 0{
            self.displayAlert(message: "Please enter item name")
            return false
        }else if lblSelCat.text == "Select product category"{
            self.displayAlert(message: "Please select category")
            return false
        }else if txtLocation.text!.count == 0{
            self.displayAlert(message: "Please enter location")
            return false
        }else if txtLocation.text!.count < 5{
            self.displayAlert(message: "Please enter valid location")
            return false
        }else if txtCity.text!.count == 0{
            self.displayAlert(message: "Please enter City")
            return false
        }else if txtName.text!.count == 0{
            self.displayAlert(message: "Please enter contat person name")
            return false
        }else if txtName.text!.count < 3{
            self.displayAlert(message: "Please enter contat person valid name")
            return false
        }else if txtNumber.text!.count == 0{
            self.displayAlert(message: "Please enter contat person mobile number")
            return false
        }else if txtNumber.text!.count != 10{
            self.displayAlert(message: "Please enter contat person valid number")
            return false
        }else if tvAddress.text!.count == 0{
            self.displayAlert(message: "Please enter adress")
            return false
        }else if tvDescription.text!.count == 0{
            self.displayAlert(message: "Please enter description")
            return false
        }else if arrImages.count == 0{
            self.displayAlert(message: "Please select atleast one image")
            return false
        }else{
            return true
        }
    }
    
    
    // MARK: - Action Methods
    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnCatDropdownClicked(_ sender: UIButton) {
        if dropDown.isHidden == true{
            dropDown.show()
        }else{
            dropDown.hide()
        }
    }
    
    @IBAction func btnAddImageClicked(_ sender: UIButton) {
        presentOpalImagePickerController(imagePicker, animated: true,
            select: { (assets) in
                //Select Assets
            self.cvItems.isHidden = false
            for asset in assets{
                let image = asset.image(targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil)
                let size = (image.getSizeIn(.megabyte))
                if Double(size) ?? 0 <= 5.0{
                    self.arrImages.append(image)
                }
            }
            self.cvItems.reloadData()
                 self.dismiss(animated: true, completion: nil)
            }, cancel: {
                //Cancel
            })
    }
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        if self.checkValidation(){
            if isLost{
                self.callPostLostItemAPI()
            }else{
                self.callPostFoundItemAPI()
            }
        }
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

extension LostItemVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count > 0 ? arrImages.count : 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell:LostItemCVCell = self.cvItems.dequeueReusableCell(withReuseIdentifier: KLostItemCVCell, for: indexPath) as! LostItemCVCell
        itemCell.ivItem.image = arrImages[indexPath.item]
        return itemCell
    }

}
extension LostItemVC{
    fileprivate func callPostLostItemAPI(){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue,
                         KLocation:txtLocation.text ?? "",
                   KLost_date_time:currDateInIso(),
                               KIp:randomIP,
                             KCity:txtCity.text!,
                         KCategory:lblSelCat.text!,
                      KDescription:tvDescription.text!,
                        KItem_name:txtItemName.text!,
                   KContact_number:txtNumber.text!,
                     KContact_name:txtName.text!,
                          KAddress:tvAddress.text!
        ] as [String : Any]
        APIManager.requestPostMultipartFormData(postLostItem, fromVC: self, dicsParams: dicLostParams, dicImages: arrImages, completionhandler: {response in
            self.hideProgressBar()
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
    
    fileprivate func callPostFoundItemAPI(){
        self.showProgressBar()
      
        let dicLostParams = [KSKEY:KSkeyValue,
                         KLocation:txtLocation.text ?? "",
                  KFound_date_time:currDateInIso(),
                               KIp:randomIP,
                             KCity:txtCity.text!,
                         KCategory:lblSelCat.text!,
                      KDescription:tvDescription.text!,
                        KItem_name:txtItemName.text!,
                   KContact_number:txtNumber.text!,
                     KContact_name:txtName.text!,
                          KAddress:tvAddress.text!
        ] as [String : Any]
        APIManager.requestPostMultipartFormData(postFoundItem, fromVC: self, dicsParams: dicLostParams, dicImages: arrImages, completionhandler: {response in
            self.hideProgressBar()
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
    
    fileprivate func callCategoriesAPI(){
        self.showProgressBar()
        categoryAPIManager.fetchCategoriesApiCall(params: [:], fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrCategories = result.data!
                            self.setDropDown()
                        }
                    }else{
                        self.displayAlert(message: result.message ?? NoItem)
                    }
                case .failure(_):
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
}
