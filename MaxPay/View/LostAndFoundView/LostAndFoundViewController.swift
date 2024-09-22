//
//  LostAndFoundViewController.swift
//  MaxPay
//
//  Created by Admin on 08/06/24.
//

import UIKit
import DropDown

class LostAndFoundViewController: UIViewController {
    
    @IBOutlet var cvCategories: UICollectionView!
    @IBOutlet var cvItems: UICollectionView!
    @IBOutlet var vwFloatingMenu: FloatingMenuView!
    @IBOutlet var vwPostOption: UIView!
    @IBOutlet var btnFoundSelect: UIButton!
    @IBOutlet var btnLostSelect: UIButton!
    @IBOutlet var ivFoudSelect: UIImageView!
    @IBOutlet var ivLostSelect: UIImageView!
    @IBOutlet var ivSmilyFoundSelect: UIImageView!
    @IBOutlet var ivSmilyLostSelect: UIImageView!
    @IBOutlet var btnFoundItems: UIButton!
    @IBOutlet var btnLostItems: UIButton!
    @IBOutlet var btnMyItems: UIButton!
    @IBOutlet weak var vwMyItems: UIView!
    @IBOutlet weak var vwFoundItems: UIView!
    @IBOutlet weak var vwLostItems: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var vwCategories: UIView!
    @IBOutlet weak var btnSearchCancel: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    
    var btnLostSelected = true
    var btnFoundSelected = false
    var btnMyItemSelected = false
    
    let dropDown = DropDown()
    
    var search:String=""
    var isSeraching:Bool = false
    
    let categoryAPIManager = CategoriesAPIManager()
    
    let lostItemAPIManager = LostItemListAPIManager()
    let searchLostItemAPIManager = SearchLostItemListAPIManager()
    let filterLostItemByLatestAPIManager = LostItemListByLatestAPIManager()
    let filterLostItemByOldestAPIManager = LostItemListByOldestAPIManager()
    let filterLostItemByCityAPIManager = LostItemByCityAPIManager()
    let filterLostItemByDateAPIManager = LostItemByDateAPIManager()
    let filterLostItemByCategoryAPIManager = LostItemByCategoryAPIManager()

    
    let foundItemAPIManager = FoundItemListAPIManager()
    let searchFoundItemAPIManager = SearchFoundItemAPIManager()
    let filterFoundItemByLatestAPIManager = FoundListByLatestAPIManager()
    let filterFoundItemByOldestAPIManager = FoundByOldestAPIManager()
    let filterFoundItemByCityAPIManager = FoundByCityAPIManager()
    let filterFoundItemByDateAPIManager = FoundByDateAPIManager()
    let filterFoundItemByCategoryAPIManager = FoundItemByCategoryAPIManager()
    
    let claimedItemAPIManager = ClaimedItemListAPIManager()
    let filterClaimItemByLatestAPIManager = ClaimItemByLatestAPIManager()
    let filterClaimItemByOldestAPIManager = ClaimItemByOldestAPIManager()
    let filterClaimItemByDateAPIManager = ClaimItemByDateAPIManager()
    
    var arrCategories = [CategoryData]()
    
    var arrLostItems = [Item]()
    var arrFoundItems = [FoundItem]()
    var arrClaimedItems = [ClaimedItem]()
    var arrSearchLostItems = [Item]()
    var arrSearchFoundItems = [FoundItem]()
    var arrSearchClaimedItems = [ClaimedItem]()

    var arrFilters = ["All","City","Latest", "Oldest", "Date"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callCategoriesAPI()
        self.vwFloatingMenu.parentVC = self
        self.setupCollectionView()
        self.addSwipeGesture()
        self.setSelected()
        txtSearch.delegate = self
        setDropDown()
        let tittle = NSAttributedString(string: "Found an item?", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark2) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnFoundSelect.setAttributedTitle(tittle, for: .normal)
        let tittle2 = NSAttributedString(string: "Lost an item?", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark2) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)! ])
        btnLostSelect.setAttributedTitle(tittle2, for: .normal)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          self.tabBarController?.tabBar.isHidden = true

  }
    
    
    override func viewWillLayoutSubviews() {
        setupCollectionView()
    }
    
    
    
    // MARK: - Action Methods
    
    @IBAction func btnFoundClicked(_ sender: UIButton) {
        ivLostSelect.image = UIImage(named: "foundSmilyBgGrey")
        ivSmilyLostSelect.image = UIImage(named: "lostSmilyGrey")
        ivFoudSelect.image = UIImage(named: "foundSmilyBgSelected")
        ivSmilyFoundSelect.image = UIImage(named: "foundSmilySelected")
        btnLostSelect.setTitleColor(.white, for: .selected)
        let tittle = NSAttributedString(string: "Lost an item?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnLostSelect.setAttributedTitle(tittle, for: .normal)
        let tittle2 = NSAttributedString(string: "Found an item?", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark) as Any,NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnFoundSelect.setAttributedTitle(tittle2, for: .normal)
        
        let LostView:LostItemVC = self.storyboard?.instantiateViewController(withIdentifier: KLostItemView) as! LostItemVC
        LostView.strTitle = "Found Item"
        LostView.isLost = false

        self.navigationController?.pushViewController(LostView, animated: true)
    }
    @IBAction func btnLostClicked(_ sender: UIButton) {
        ivLostSelect.image = UIImage(named: "foundSmilyBgSelected")
        ivSmilyLostSelect.image = UIImage(named: "lostSmilyWhite")
        ivFoudSelect.image = UIImage(named: "foundSmilyBgGrey")
        ivSmilyFoundSelect.image = UIImage(named: "foundSmilyGrey")
        btnFoundSelect.setTitleColor(.white, for: .selected)
        let tittle = NSAttributedString(string: "Found an item?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnFoundSelect.setAttributedTitle(tittle, for: .normal)
        let tittle2 = NSAttributedString(string: "Lost an item?", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark) ?? .gray ,NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnLostSelect.setAttributedTitle(tittle2, for: .normal)
        //KLostItemView
        let LostView:LostItemVC = self.storyboard?.instantiateViewController(withIdentifier: KLostItemView) as! LostItemVC
        LostView.strTitle = "Lost Item"
        LostView.isLost = true
        self.navigationController?.pushViewController(LostView, animated: true)
    }
    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        self.removeChild()
        if vwFloatingMenu.isHidden == true{
            self.vwFloatingMenu.isHidden = false
        }
    }
    
    @IBAction func btnLostITemClicked(_ sender: UIButton) {
        setLostSelected()
    }
    
    @IBAction func btnFoundItemClicked(_ sender: UIButton) {
        setFoundSelected()
    }
    @IBAction func btnMyItemClicked(_ sender: UIButton) {
        setMyItemsSelected()
    }
    
    @IBAction func btnSearchCancelClicked(_ sender: UIButton) {
        search = ""
        txtSearch.text = ""
        arrSearchLostItems.removeAll()
        arrSearchFoundItems.removeAll()
        arrSearchClaimedItems.removeAll()
        btnSearchCancel.isHidden = true
        isSeraching = false
        txtSearch.resignFirstResponder()
        if btnLostSelected{
            setLostSelected()
        }else if btnFoundSelected{
            setFoundSelected()
        }else{
            setMyItemsSelected()
        }
    }
    @IBAction func btnFilterClicked(_ sender: UIButton) {
        if dropDown.isHidden == true{
            dropDown.show()
        }else{
            dropDown.hide()
        }
    }
    // MARK: - Custom Methods
    func setDropDown(){
        // The view to which the drop down will appear on
        dropDown.anchorView = btnFilter // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = arrFilters
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height) ?? 300)
        dropDown.backgroundColor = .white
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if index == 0{
                if btnFoundSelected{
                    callFoundItemListAPI()
                }else if btnLostSelected{
                    callLostItemListAPI()
                }else{
                    callClaimedItemListAPI()
                }
            }else if index == 1{
                //city
                if btnFoundSelected || btnLostSelected{
                    let filterTexPopUpVCView:FilterTexPopUpVC = self.storyboard?.instantiateViewController(withIdentifier: KFilterPopUPVC) as! FilterTexPopUpVC
                    filterTexPopUpVCView.parentVC = self
                    configureChildViewController(childController: filterTexPopUpVCView, onView: self.vwContainer)
                    self.vwFloatingMenu.isHidden = true
                }
            }else if index == 2{
                if btnFoundSelected{
                    callFilterFoundItemByLatestListAPI()
                }else if btnLostSelected{
                    callFilterLostItemByLatestListAPI()
                }else{
                    //callFilterClaimItemByLatestListAPI()
                }
            }else if index == 3{
                if btnFoundSelected{
                    callFilterFoundItemByOldestListAPI()
                }else if btnLostSelected{
                    callFilterLostItemByOldestListAPI()
                }else{
                    //callFilterClaimItemByOldestListAPI()
                }
            }else if index == 4{
                if btnFoundSelected || btnLostSelected{
                    let filterDatePopUpVC:FilterDatePopUpVC = self.storyboard?.instantiateViewController(withIdentifier: KFilterDatePopUPVC) as! FilterDatePopUpVC
                    filterDatePopUpVC.parentVC = self
                    configureChildViewController(childController: filterDatePopUpVC, onView: self.vwContainer)
                    self.vwFloatingMenu.isHidden = true
                }
            }
        }
        // Will set a custom width instead of the anchor view width
        dropDown.width = self.vwCategories.frame.width - 18
    }
    func resetOptions()
    {
        ivLostSelect.image = UIImage(named: "foundSmilyBgGreen")
        ivSmilyLostSelect.image = UIImage(named: "lostSmilyGreen")
        ivSmilyFoundSelect.image = UIImage(named: "foundSmilyGreen")
        btnLostSelect.setTitleColor(.white, for: .selected)
        let tittle = NSAttributedString(string: "Lost an item?", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark2)as Any])
        btnLostSelect.setAttributedTitle(tittle, for: .normal)
        let tittle2 = NSAttributedString(string: "Found an item?", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark2) as Any])
        btnFoundSelect.setAttributedTitle(tittle2, for: .normal)
        ivFoudSelect.image = UIImage(named: "foundSmilyBgGreen")
    }
    func setSelected(){
        let tittle = NSAttributedString(string: "Lost Items", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark2) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnLostItems.setAttributedTitle(tittle, for: .normal)
        vwLostItems.backgroundColor = UIColor(named: KThemeLightGreen)
        btnLostSelected = true
        btnFoundSelected = false
        btnMyItemSelected = false
    }
    
    func setFoundSelected(){
        let tittle = NSAttributedString(string: "Lost Items", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnLostItems.setAttributedTitle(tittle, for: .normal)
        vwLostItems.backgroundColor = .clear
        
        let tittle2 = NSAttributedString(string: "Found Items", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark2) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnFoundItems.setAttributedTitle(tittle2, for: .normal)
        vwFoundItems.backgroundColor = UIColor(named: KThemeLightGreen)
        
        let tittle3 = NSAttributedString(string: "My Items", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnMyItems.setAttributedTitle(tittle3, for: .normal)
        vwMyItems.backgroundColor = .clear
        
        btnLostSelected = false
        btnFoundSelected = true
        btnMyItemSelected = false
        if !isSeraching{
            callFoundItemListAPI()
        }else{
            cvItems.reloadData()
        }
    }
    
    func setLostSelected(){
        let tittle = NSAttributedString(string: "Lost Items", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark2) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnLostItems.setAttributedTitle(tittle, for: .normal)
        vwLostItems.backgroundColor = UIColor(named: KThemeLightGreen)
        let tittle2 = NSAttributedString(string: "Found Items", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnFoundItems.setAttributedTitle(tittle2, for: .normal)
        vwFoundItems.backgroundColor = .clear
        let tittle3 = NSAttributedString(string: "My Items", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnMyItems.setAttributedTitle(tittle3, for: .normal)
        vwMyItems.backgroundColor = .clear
        
        btnLostSelected = true
        btnFoundSelected = false
        btnMyItemSelected = false
        
        if !isSeraching{
            callLostItemListAPI()
        }else{
            cvItems.reloadData()
        }
    }
    
    func setMyItemsSelected(){
        let tittle = NSAttributedString(string: "Lost Items", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark) ?? .gray, NSAttributedString.Key.backgroundColor: UIColor.clear, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnLostItems.setAttributedTitle(tittle, for: .normal)
        vwLostItems.backgroundColor = .clear
        
        let tittle2 = NSAttributedString(string: "Found Items", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark) ?? .gray, NSAttributedString.Key.backgroundColor: UIColor.clear, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnFoundItems.setAttributedTitle(tittle2, for: .normal)
        vwFoundItems.backgroundColor = .clear
        
        let tittle3 = NSAttributedString(string: "My Items", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark2) ?? .gray, NSAttributedString.Key.backgroundColor: UIColor(named: KThemeLightGreen) ?? .green, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 11.0)!])
        btnMyItems.setAttributedTitle(tittle3, for: .normal)
        vwMyItems.backgroundColor = UIColor(named: KThemeLightGreen)
        btnLostSelected = false
        btnFoundSelected = false
        btnMyItemSelected = true
        
        callClaimedItemListAPI()
    }
    
    func addSwipeGesture(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .left
        self.view.addGestureRecognizer(swipeDown)
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer)
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                if btnLostSelected{
                    setFoundSelected()
                }else if btnFoundSelected{
                    setMyItemsSelected()
                }else{
                    setLostSelected()
                }
            case .left:
                if btnLostSelected{
                    setMyItemsSelected()
                }else if btnFoundSelected{
                    setLostSelected()
                }else{
                    setFoundSelected()
                }
            default:
                break
            }
        }
    }
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 10 //as per your requirement
        layout.minimumInteritemSpacing = 10 //as per your requirement
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.cvItems.frame.width / 2 - 10, height: 225)
        self.cvItems.collectionViewLayout = layout
    }
    
    func presentPostOptionView()
    {
        if self.vwPostOption.isHidden == true{
            self.vwPostOption.isHidden = false
        }else{
            self.vwPostOption.isHidden = true
        }
    }
    
    func showPostView(){
        let myPostView:MyPostVC = self.storyboard?.instantiateViewController(withIdentifier: KMyPostView) as! MyPostVC
        configureChildViewController(childController: myPostView, onView: self.vwContainer)
    }
    
    func showItemDetailView(index:Int){
        let itemDetailsView:ItemDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: KItemDetailsView) as! ItemDetailsVC
        if btnLostSelected{
            itemDetailsView.isLost = true
            itemDetailsView.isClaimed = false
            if isSeraching{
                itemDetailsView.lostData = arrSearchLostItems[index]
            }else{
                itemDetailsView.lostData = arrLostItems[index]
            }
        }else if btnFoundSelected{
            itemDetailsView.isLost = false
            itemDetailsView.isClaimed = false
            if isSeraching{
                itemDetailsView.foundData = arrSearchFoundItems[index]
            }else{
                itemDetailsView.foundData = arrFoundItems[index]
            }
        }else{
            itemDetailsView.isClaimed = true
            itemDetailsView.isLost = false
            if isSeraching{
                itemDetailsView.claimedData = arrSearchClaimedItems[index]
            }else{
                itemDetailsView.claimedData = arrClaimedItems[index]
            }
        }
        self.navigationController?.pushViewController(itemDetailsView, animated: true)
    }
    
    func hidePostView(){
        self.removeChild()
    }
    
    func filterSubmit(filterText:String){
        self.removeChild()
        if vwFloatingMenu.isHidden == true{
            self.vwFloatingMenu.isHidden = false
        }
        if filterText.count > 0{
            if btnFoundSelected{
                callFilterFoundItemByCityListAPI(city: filterText)
            }else{
                callFilterLostItemByCityListAPI(city: filterText)
            }
        }
    }
    
    func filterDateSubmit(filterText:String){
        self.removeChild()
        if vwFloatingMenu.isHidden == true{
            self.vwFloatingMenu.isHidden = false
        }
        if filterText.count > 0{
            //call filter API
            if btnFoundSelected{
                callFilterFoundItemByDateListAPI(date: filterText)
            }else if btnLostSelected{
                callFilterLostItemByDateListAPI(date: filterText)
            }else{
                //callFilterClaimItemByDateListAPI(date: filterText)
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




extension LostAndFoundViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cvItems{
            if btnLostSelected{
                if isSeraching{
                    return self.arrSearchLostItems.count > 0 ? self.arrSearchLostItems.count : 0
                }else{
                    return self.arrLostItems.count > 0 ? self.arrLostItems.count : 0
                }
            }else if btnFoundSelected{
                if isSeraching{
                    return self.arrSearchFoundItems.count > 0 ? self.arrSearchFoundItems.count : 0
                }else{
                    return self.arrFoundItems.count > 0 ? self.arrFoundItems.count : 0
                }
            }else{
                if isSeraching{
                    return self.arrSearchClaimedItems.count > 0 ? self.arrSearchClaimedItems.count : 0
                }else{
                    return self.arrClaimedItems.count > 0 ? self.arrClaimedItems.count : 0
                }
            }
        }else{
            return self.arrCategories.count > 0 ? self.arrCategories.count : 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.cvCategories{
            let catCell:CategoryCVCell = self.cvCategories.dequeueReusableCell(withReuseIdentifier: KCategoryCVCell, for: indexPath) as! CategoryCVCell
            catCell.setData(category: arrCategories[indexPath.item])
            return catCell
        }else{
            let itemCell:ItemCVCell = self.cvItems.dequeueReusableCell(withReuseIdentifier: KItemCVCell, for: indexPath) as! ItemCVCell
            if btnLostSelected{
                if isSeraching{
                    itemCell.setData(item: self.arrSearchLostItems[indexPath.item])
                }else{
                    itemCell.setData(item: self.arrLostItems[indexPath.item])
                }
            }else if btnFoundSelected{
                if isSeraching{
                    itemCell.setFoundData(item: self.arrSearchFoundItems[indexPath.item])
                }else{
                    itemCell.setFoundData(item: self.arrFoundItems[indexPath.item])
                }
            }else{
                if isSeraching{
                    itemCell.setClaimedData(item: self.arrSearchClaimedItems[indexPath.item])
                }else{
                    itemCell.setClaimedData(item: self.arrClaimedItems[indexPath.item])
                }
            }
            return itemCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.cvItems{
            self.showItemDetailView(index: indexPath.row)
        }else{
            if let category = arrCategories[indexPath.item].name{
                if btnLostSelected{
                    self.callFilterLostItemByCategoryListAPI(category: category)
                }else if btnFoundSelected{
                    self.callFilterFoundItemByCategoryListAPI(category: category)
                }else{}
            }
        }
    }
}
extension LostAndFoundViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.cvItems{
            let contentOffsetY = scrollView.contentOffset.y
            if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0)
            {
                if (scrollView.contentOffset.y == 0){
                    if self.vwCategories.isHidden == true{
                        self.vwCategories.isHidden = false
                    }
                }
            }
            else
            {
                if contentOffsetY == 0{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                        self.vwCategories.isHidden = false
                    }
              }else{
                    //hide the collection view here -- downscroll
                    if self.vwCategories.isHidden == false{
                        self.vwCategories.isHidden = true
                    }
                }
            }
        }
    }
}
extension LostAndFoundViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string.isEmpty
        {
            search = String(search.dropLast())
        }else
        {
            search=textField.text!+string
        }
        if search.count > 0{
            isSeraching = true
            if btnLostSelected{
                callSearchLostItemListAPI(searchValue: search)
            }else if btnFoundSelected{
                callSearchFoundItemListAPI(searchValue: search)
            }else{
                
            }
        }else{
            isSeraching = false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSearchCancel.isHidden = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        btnSearchCancel.isHidden = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

//MARK: - API Call
extension LostAndFoundViewController{
    
    fileprivate func callCategoriesAPI(){
        self.showProgressBar()
        categoryAPIManager.fetchCategoriesApiCall(params: [:], fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                self.callLostItemListAPI()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrCategories = result.data!
                            self.cvCategories.reloadData()
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
    
    //MARK: - Lost Items APIs
    
    fileprivate func callLostItemListAPI(){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue]
        lostItemAPIManager.fetchLostItemApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrLostItems = result.data!
                            self.cvItems.reloadData()
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
    
    fileprivate func callSearchLostItemListAPI(searchValue:String){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue,KSearchKey:searchValue]
        searchLostItemAPIManager.fetchSearchLostItemApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrSearchLostItems = result.data!
                            self.cvItems.reloadData()
                        }
                    }else{
                        self.arrSearchLostItems.removeAll()
                        self.cvItems.reloadData()
                        self.displayAlert(message: result.message ?? NoItem)
                    }
                case .failure(_):
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
    fileprivate func callFilterLostItemByLatestListAPI(){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue]
        filterLostItemByLatestAPIManager.fetchFilterLostItemByLatestApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                       if result.data != nil{
                            self.arrLostItems = result.data!
                            self.cvItems.reloadData()
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
    
    fileprivate func callFilterLostItemByOldestListAPI(){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue]
        filterLostItemByOldestAPIManager.fetchFilterLostItemByOldestApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrLostItems = result.data!
                            self.cvItems.reloadData()
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
    fileprivate func callFilterLostItemByCityListAPI(city:String){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue,KCity:city]
        filterLostItemByCityAPIManager.fetchFilterLostItemByCityApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrLostItems = result.data!
                            self.cvItems.reloadData()
                        }
                    }else{
                        self.arrLostItems.removeAll()
                        self.cvItems.reloadData()
                        self.displayAlert(message: result.message ?? NoItem)
                    }
                case .failure(_):
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
    
    fileprivate func callFilterLostItemByDateListAPI(date:String){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue,KDate:date]
        filterLostItemByDateAPIManager.fetchFilterLostItemByDateApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrLostItems = result.data!
                            self.cvItems.reloadData()
                        }
                    }else{
                        self.arrLostItems.removeAll()
                        self.cvItems.reloadData()
                        self.displayAlert(message: result.message ?? NoItem)
                    }
                case .failure(_):
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
    fileprivate func callFilterLostItemByCategoryListAPI(category:String){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue,KCategory:category]
        filterLostItemByCategoryAPIManager.fetchLostByCategoryApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrLostItems = result.data!
                            self.cvItems.reloadData()
                        }
                    }else{
                        self.arrLostItems.removeAll()
                        self.cvItems.reloadData()
                        self.displayAlert(message: result.message ?? NoItem)
                    }
                case .failure(_):
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
    
    //MARK: - Found Items APIs
    
    fileprivate func callFoundItemListAPI(){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue]
        foundItemAPIManager.fetchFoundItemApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrFoundItems = result.data!
                            self.cvItems.reloadData()
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
    
    fileprivate func callSearchFoundItemListAPI(searchValue:String){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue,KSearchKey:searchValue]
        searchFoundItemAPIManager.fetchSearchFoundItemApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrSearchFoundItems = result.data!
                            self.cvItems.reloadData()
                        }
                    }else{
                        self.arrSearchFoundItems.removeAll()
                        self.cvItems.reloadData()
                        self.displayAlert(message: result.message ?? NoItem)
                    }
                case .failure(_):
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
    
    fileprivate func callFilterFoundItemByLatestListAPI(){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue]
        filterFoundItemByLatestAPIManager.fetchFilterFoundItemByLatestApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrFoundItems = result.data!
                            self.cvItems.reloadData()
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
    fileprivate func callFilterFoundItemByOldestListAPI(){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue]
        filterFoundItemByOldestAPIManager.fetchFilterFoundItemByOldestApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrFoundItems = result.data!
                            self.cvItems.reloadData()
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
    fileprivate func callFilterFoundItemByCityListAPI(city:String){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue,KCity:city]
        filterFoundItemByCityAPIManager.fetchFilterFoundItemByCityApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrFoundItems = result.data!
                            self.cvItems.reloadData()
                        }
                    }else{
                        self.arrFoundItems.removeAll()
                        self.cvItems.reloadData()
                        self.displayAlert(message: result.message ?? NoItem)
                    }
                case .failure(_):
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
    
    fileprivate func callFilterFoundItemByDateListAPI(date:String){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue,KDate:date]
        filterFoundItemByDateAPIManager.fetchFilterFoundItemByDateApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrFoundItems = result.data!
                            self.cvItems.reloadData()
                        }
                    }else{
                        self.arrFoundItems.removeAll()
                        self.cvItems.reloadData()
                        self.displayAlert(message: result.message ?? NoItem)
                    }
                case .failure(_):
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
    fileprivate func callFilterFoundItemByCategoryListAPI(category:String){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue,KCategory:category]
        filterFoundItemByCategoryAPIManager.fetchFoundItemByCategoryApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrFoundItems = result.data!
                            self.cvItems.reloadData()
                        }
                    }else{
                        self.arrFoundItems.removeAll()
                        self.cvItems.reloadData()
                        self.displayAlert(message: result.message ?? NoItem)
                    }
                case .failure(_):
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
    
    //MARK: - My Items APIs
    fileprivate func callClaimedItemListAPI(){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue]
        claimedItemAPIManager.fetchClaimedItemApiCall(params: dicLostParams, fromVC:self,isClaimed: true) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrClaimedItems = result.data!
                            self.cvItems.reloadData()
                        }
                    }else{
                        self.displayAlert(message: result.message ?? NoItem)
                        self.cvItems.reloadData()
                    }
                case .failure(_):
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
    fileprivate func callFilterClaimItemByLatestListAPI(){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue]
        filterClaimItemByLatestAPIManager.fetchClaimByLatestApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrClaimedItems = result.data!
                            self.cvItems.reloadData()
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
    fileprivate func callFilterClaimItemByOldestListAPI(){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue]
        filterClaimItemByOldestAPIManager.fetchClaimByOldestApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrClaimedItems = result.data!
                            self.cvItems.reloadData()
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
    fileprivate func callFilterClaimItemByDateListAPI(date:String){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue,KDate:date]
        filterClaimItemByDateAPIManager.fetchClaimByDateApiCall(params: dicLostParams, fromVC:self) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        if result.data != nil{
                            self.arrClaimedItems = result.data!
                            self.cvItems.reloadData()
                        }
                    }else{
                        self.arrClaimedItems.removeAll()
                        self.cvItems.reloadData()
                        self.displayAlert(message: result.message ?? NoItem)
                    }
                case .failure(_):
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
}
