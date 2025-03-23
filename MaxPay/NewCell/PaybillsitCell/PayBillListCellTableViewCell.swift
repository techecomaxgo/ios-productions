//
//  PayBillListCellTableViewCell.swift
//  MaxPay
//
//  Created by india on 20/03/25.
//

import UIKit
protocol PayBillListCellDelegate: AnyObject {
    func didSelectCategory(category: CategoryItem)
}

class PayBillListCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headelbl: UILabel!
    var categories: [CategoryItem] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    weak var delegate: PayBillListCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        collectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    
    func configure(with data: Paybildata) {
//        headelbl.text = data.headerName
        categories = data.categories
        collectionView.reloadData()
        DispatchQueue.main.async {
        self.updateCollectionViewHeight()
        }
    }
    private func updateCollectionViewHeight() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let itemsPerRow: CGFloat = 3  // ✅ 3 items ek row me
        let itemHeight: CGFloat = 100 // ✅ Har item ki height 100px
        let spacing: CGFloat = layout.minimumLineSpacing // ✅ Jo spacing aapne set ki hai
        
        let totalRows = ceil(CGFloat(categories.count) / itemsPerRow) // ✅ Total rows calculate
        let totalHeight = (totalRows * itemHeight) + ((totalRows - 1) * spacing) // ✅ Total height
        
        collectionViewHeightConstraint.constant = totalHeight  // ✅ Constraint update
        self.layoutIfNeeded()  // ✅ UI refresh karein
    }
}

extension PayBillListCellTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PayBillListCollCell", for: indexPath) as! PayBillListCollCell
        cell.configure(with: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 4  // ✅ 3 items in a row
        let padding: CGFloat = 10  // ✅ Spacing between items
        let totalSpacing = (itemsPerRow - 1) * padding  // ✅ Total spacing
        
        let availableWidth = collectionView.frame.width - totalSpacing  // ✅ Width available after spacing
        let itemWidth = availableWidth / itemsPerRow  // ✅ Width of each item
        
        return CGSize(width: itemWidth, height: 100)  // ✅ Square cells
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCategory(category: categories[indexPath.item])
//        let storyboard = UIStoryboard(name: "BBPS", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "CatagoryListVC") as! CatagoryListVC
//        vc.strCatagoryImg = categories[indexPath.item].imageName ?? ""  // Passing image name as a string
//        vc.strCatagoryName = categories[indexPath.item].name ?? ""
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
