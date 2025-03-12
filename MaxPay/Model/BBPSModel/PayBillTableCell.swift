// PayBillTableCell.swift

import UIKit

class PayBillTableCell: UITableViewCell {

    @IBOutlet weak var collVWFavourite: UICollectionView!
    @IBOutlet weak var titale: UILabel!
    
    var categories: [PayBillCategoriesModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collVWFavourite.delegate = self
        collVWFavourite.dataSource = self
    }
    
    func configureCell(withTitle title: String, categories: [PayBillCategoriesModel]) {
        self.titale.text = title
        self.categories = categories
        collVWFavourite.reloadData()
    }
}

extension PayBillTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PayBillListCollCell", for: indexPath) as! PayBillListCollCell
        
        let category = categories[indexPath.row]
        cell.lblName.text = category.name
        if let imageName = category.imageName {
            cell.img.image = UIImage(named: imageName)
        } else {
            cell.img.image = nil
        }
        
        cell.img.setImageColors(color: UIColor(named: "primary-green")!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 4
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size + 30)
    }
}
