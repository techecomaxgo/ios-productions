//
//  MyPostVC.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 22/05/24.
//

import UIKit

class MyPostVC: UIViewController {
    
    @IBOutlet var cvItems: UICollectionView!
    @IBOutlet var btnFoundItems: UIButton!
    @IBOutlet var btnLostItems: UIButton!
    @IBOutlet var btnMyItems: UIButton!
    @IBOutlet weak var vwMyItems: UIView!
    @IBOutlet weak var vwFoundItems: UIView!
    @IBOutlet weak var vwLostItems: UIView!
    @IBOutlet weak var btnSearchCancel: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
   
    var search:String=""
    var isSeraching:Bool = false
    
    var btnLostSelected = true
    var btnFoundSelected = false
    var btnMyItemSelected = false
    var arrSearchLostItems = [Item]()
    var arrSearchFoundItems = [FoundItem]()
    
    let getMyLostItemAPIManager = MyLostItemAPIManager()
    let getMyFoundItemAPIManager = MyFoundItemAPIManager()
    let claimedItemAPIManager = ClaimedItemListAPIManager()
    let searchLostItemAPIManager = SearchLostItemListAPIManager()
    let searchFoundItemAPIManager = SearchFoundItemAPIManager()
    
    var arrLostItems = [Item]()
    var arrFoundItems = [FoundItem]()
    var arrClaimedItems = [ClaimedItem]()
    var arrSearchClaimedItems = [ClaimedItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.delegate = self
        
        self.setupCollectionView()
        
        self.addSwipeGesture()
        self.setSelected()
        self.callLostClaimedItemListAPI()
    }
    
    // MARK: - Action Methods
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
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
    // MARK: - Custom Methods
    
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
        callFoundClaimedItemListAPI()
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
        
        callLostClaimedItemListAPI()
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
        layout.minimumLineSpacing = 0 //as per your requirement
        layout.minimumInteritemSpacing = 0 //as per your requirement
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.cvItems.frame.width - 16, height: 290)
        self.cvItems.collectionViewLayout = layout
        
        
    }
    
   
    func hidePostView(){
        self.navigationController?.popViewController(animated: false)
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension MyPostVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        }
        else{
            if isSeraching{
                return self.arrSearchFoundItems.count > 0 ? self.arrSearchClaimedItems.count : 0
            }else{
                return self.arrClaimedItems.count > 0 ? self.arrClaimedItems.count : 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell:ItemCVCell = self.cvItems.dequeueReusableCell(withReuseIdentifier: KItemCVCell, for: indexPath) as! ItemCVCell
        itemCell.parentVC = self
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
        }
        else{
            if isSeraching{
                itemCell.setClaimedData(item: self.arrSearchClaimedItems[indexPath.item])
            }else{
                itemCell.setClaimedData(item: self.arrClaimedItems[indexPath.item])
            }
        }
        return itemCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.showItemDetailView(index: indexPath.row)
        
    }
}

extension MyPostVC:UITextFieldDelegate{
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
        //isSeraching = false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

//MARK: - API Methods
extension MyPostVC{
    fileprivate func callLostClaimedItemListAPI(){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue]
        getMyLostItemAPIManager.fetchMyLostApiCall(params: dicLostParams, fromVC:self,isClaimed: true) { (resultInfo) in
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
                        self.cvItems.reloadData()
                    }
                case .failure(_):
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
    
    fileprivate func callFoundClaimedItemListAPI(){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue]
        getMyFoundItemAPIManager.fetchMyFoundApiCall(params: dicLostParams, fromVC:self,isClaimed: true) { (resultInfo) in
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
                        self.cvItems.reloadData()
                    }
                case .failure(_):
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
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
    fileprivate func callSearchLostItemListAPI(searchValue:String){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue,KSearchKey:searchValue]
        searchLostItemAPIManager.fetchSearchLostItemApiCall(params: dicLostParams, fromVC:self,isClaimed: true) { (resultInfo) in
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
    fileprivate func callSearchFoundItemListAPI(searchValue:String){
        self.showProgressBar()
        let dicLostParams = [KSKEY:KSkeyValue,KSearchKey:searchValue]
        searchFoundItemAPIManager.fetchSearchFoundItemApiCall(params: dicLostParams, fromVC:self,isClaimed: true) { (resultInfo) in
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
}
