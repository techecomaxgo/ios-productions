//
//  ItemCVCell.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 22/05/24.
//

import UIKit
import SDWebImage
class ItemCVCell: UICollectionViewCell {
    @IBOutlet var lblItemTitle: UILabel!
    @IBOutlet var ivItem: UIImageView!
    @IBOutlet var lblItemTitle2: UILabel!
    @IBOutlet var lblItemSubTitle: UILabel!

    var parentVC:MyPostVC?
    var curInd = 0
    var arrImgs = [String]()

    func setData(item:Item){
        self.lblItemTitle.text = item.item_name
        self.lblItemTitle2.text = item.item_name
        self.lblItemSubTitle.text = item.description
        //ivItem.contentMode = .scaleAspectFit
        if item.image_url?.count ?? 0 > 0 {
            arrImgs = (item.image_url)!
            ivItem.sd_setImage(with: URL(string: (item.image_url?[0])!),placeholderImage: UIImage(named: "itemPlaceholder"))
        }else{
            ivItem.image = UIImage(named: "itemPlaceholder")
        }
    }
    
    func setFoundData(item:FoundItem){
        self.lblItemTitle.text = item.item_name
        self.lblItemTitle2.text = item.item_name
        self.lblItemSubTitle.text = item.description
        //ivItem.contentMode = .scaleAspectFit
        if item.image_url?.count ?? 0 > 0 {
            arrImgs = (item.image_url)!
            ivItem.sd_setImage(with: URL(string: (item.image_url?[0])!),placeholderImage: UIImage(named: "itemPlaceholder"))
        }else{
            ivItem.image = UIImage(named: "itemPlaceholder")
        }
    }
    
    func setClaimedData(item:ClaimedItem){
        self.lblItemTitle.text = item.found_item_name
        self.lblItemTitle2.text = item.found_item_name
        self.lblItemSubTitle.text = item.description
        //ivItem.contentMode = .scaleAspectFit
        if item.image_url?.count ?? 0 > 0 {
            arrImgs = (item.image_url)!
            ivItem.sd_setImage(with: URL(string: (item.image_url?[0])!),placeholderImage: UIImage(named: "itemPlaceholder"))
        }else{
            ivItem.image = UIImage(named: "itemPlaceholder")
        }
    }
    
    // MARK: -  Action Method
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
    @IBAction func btnMenuClicked(_ sender: UIButton) {
        
    }
}
