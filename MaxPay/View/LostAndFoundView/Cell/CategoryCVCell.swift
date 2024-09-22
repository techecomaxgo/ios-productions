//
//  CategoryCVCell.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 22/05/24.
//

import UIKit

class CategoryCVCell: UICollectionViewCell {
    @IBOutlet var lblCategoryTitle: UILabel!
    @IBOutlet var ivCategory: UIImageView!
    
    func setData(category:CategoryData){
        self.lblCategoryTitle.text = category.name
        ivCategory.contentMode = .scaleAspectFit
        if category.image_url?.count ?? 0 > 0 {
            ivCategory.sd_setImage(with: URL(string: (category.image_url)!),placeholderImage: UIImage(named: "itemPlaceholder"))
        }
    }
}
