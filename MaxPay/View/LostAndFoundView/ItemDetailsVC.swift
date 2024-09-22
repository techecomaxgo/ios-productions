//
//  ItemDetailsVC.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 24/05/24.
//

import UIKit

class ItemDetailsVC: UIViewController {
    @IBOutlet var btnClaim: UIButton!
    @IBOutlet var vwContainer: UIView!
    @IBOutlet var lblItemTitle: UILabel!
    @IBOutlet var ivItem: UIImageView!
    @IBOutlet var lblItemTitle2: UILabel!
    @IBOutlet var lblItemSubTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblCategory: UILabel!
    
    var lostData:Item?
    var foundData:FoundItem?
    var claimedData:ClaimedItem?

    var isLost = true
    var isClaimed = false
    var claimItemAPIManager = ClaimItemAPIManager()
    var arrImgs = [String]()
    var curInd = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tittle2 = NSAttributedString(string: "Claim", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 12.0)!])
        btnClaim.setAttributedTitle(tittle2, for: .normal)
        setData()
    }
    // MARK: -  Custom Methods

    func setData(){
        if isLost{
            lblItemTitle.text = lostData?.item_name
            lblItemTitle2.text = lostData?.item_name
            lblItemSubTitle.text = lostData?.description
            lblDescription.text = lostData?.description
            if lostData?.lost_date_time?.count ?? 0 > 0{
                let strDate = Utils.convertStringToDate(selectedDateString: (lostData?.lost_date_time)!, andFormat: isoDateFormat)
                let finalDate = Utils.convertDateToString(selectedDate: strDate, andFormat: "dd MMM, YYYY")
                lblDate.text = finalDate
            }else{
                lblDate.text = ""
            }
            lblCategory.text = lostData?.category
            ivItem.contentMode = .scaleAspectFit
            if lostData?.image_url?.count ?? 0 > 0 {
                arrImgs = (lostData?.image_url)!
                ivItem.sd_setImage(with: URL(string: (lostData?.image_url?[0])!),placeholderImage: UIImage(named: "itemPlaceholder"))
            }
        }else if isClaimed{
            lblItemTitle.text = claimedData?.found_item_name
            lblItemTitle2.text = claimedData?.found_item_name
            lblItemSubTitle.text = claimedData?.description
            lblDescription.text = claimedData?.description
            lblDate.text = claimedData?.createdAt
            lblCategory.text = ""//claimedData?.category
            ivItem.contentMode = .scaleAspectFit
            if claimedData?.createdAt?.count ?? 0 > 0{
                let strDate = Utils.convertStringToDate(selectedDateString: (claimedData?.createdAt)!, andFormat: isoDateFormat)
                let finalDate = Utils.convertDateToString(selectedDate: strDate, andFormat: "dd MMM, YYYY")
                lblDate.text = finalDate
            }else{
                lblDate.text = ""
            }
            if claimedData?.image_url?.count ?? 0 > 0 {
                arrImgs = (claimedData?.image_url)!
                ivItem.sd_setImage(with: URL(string: (claimedData?.image_url?[0])!),placeholderImage: UIImage(named: "itemPlaceholder"))
            }
        }else{
            lblItemTitle.text = foundData?.item_name
            lblItemTitle2.text = foundData?.item_name
            lblItemSubTitle.text = foundData?.description
            lblDescription.text = foundData?.description
            lblDate.text = foundData?.found_date_time
            lblCategory.text = foundData?.category
            ivItem.contentMode = .scaleAspectFit
            if foundData?.found_date_time?.count ?? 0 > 0{
                let strDate = Utils.convertStringToDate(selectedDateString: (foundData?.found_date_time)!, andFormat: isoDateFormat)
                let finalDate = Utils.convertDateToString(selectedDate: strDate, andFormat: "dd MMM, YYYY")
                lblDate.text = finalDate
            }else{
                lblDate.text = ""
            }
            if foundData?.image_url?.count ?? 0 > 0 {
                arrImgs = (foundData?.image_url)!
                ivItem.sd_setImage(with: URL(string: (foundData?.image_url?[0])!),placeholderImage: UIImage(named: "itemPlaceholder"))
            }
        }
    }
    
    func claimItem(desc:String){
        self.callClaimItemAPI(desc: desc)
    }
    
    // MARK: -  Action Methods
    @IBAction func btnPreviousClicked(_ sender: UIButton) {
        if arrImgs.count > 0 && curInd > 0{
            curInd = curInd - 1
            ivItem.sd_setImage(with: URL(string: (arrImgs[curInd])),placeholderImage: UIImage(named: "itemPlaceholder"))
        }
    }
    @IBAction func btnNextClicked(_ sender: UIButton) {
        if arrImgs.count > 0 && curInd <= arrImgs.count - 2{
            curInd = curInd + 1
            ivItem.sd_setImage(with: URL(string: (arrImgs[curInd])),placeholderImage: UIImage(named: "itemPlaceholder"))
        }
    }
    @IBAction func btnShareClicked(_ sender: UIButton) {
        
    }
    @IBAction func btnBackClicked(_ sender: UIButton) {
        if self.children.count > 0{
            self.removeChild()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func btnClaimClicked(_ sender: UIButton) {
        if !isClaimed{
            let popUpView:ClaimPopUpVC = self.storyboard?.instantiateViewController(withIdentifier: KClaimPopUpVC) as! ClaimPopUpVC
            popUpView.parentVC = self
            configureChildViewController(childController: popUpView, onView: self.vwContainer)
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

// MARK: - API Calls

extension ItemDetailsVC{
    fileprivate func callClaimItemAPI(desc:String){
        self.showProgressBar()
        var cid = ""
        if isLost{
            cid = lostData?.id ?? "0"
        }else{
            cid = foundData?.id ?? "0"
        }
        
        let dicLostParams = [KSKEY:KSkeyValue,KId:cid,KDescription:desc]
       
        claimItemAPIManager.fetchClaimItemApiCall(params: dicLostParams, fromVC:self,isCalimed: true) { (resultInfo) in
            DispatchQueue.main.async(execute: {
                self.hideProgressBar()
                switch resultInfo {
                case .success(let result):
                    if result.status ==  Success {
                        self.displayAlert(message: result.message ?? ItemClaimed)
                        self.removeChild()
                    }else{
                        self.removeChild()
                        self.displayAlert(message: result.message ?? ItemNotClaimed)
                    }
                case .failure(_):
                    self.removeChild()
                    self.displayAlert(message: NoItem)
                }
            })
        }
    }
}
