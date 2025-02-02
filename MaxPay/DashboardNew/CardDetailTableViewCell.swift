//
//  CardDetailTableViewCell.swift
//  MaxPay
//
//  Created by Admin on 29/01/25.
//

import UIKit
protocol AccountDetailDelegate: AnyObject {
    func buttonTag(index: Int)
}
class CardDetailTableViewCell: UITableViewCell {
    weak var delegate: AccountDetailDelegate? = nil
    @IBOutlet weak var btnAddAccount: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imgUpi: UIImageView!
    var cardsDetailArr:[AccountDetailsOnIIN] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        imgUpi.layer.shadowColor = UIColor.black.cgColor
//        imgUpi.layer.shadowOpacity = 0.3
//        imgUpi.layer.shadowOffset = CGSize(width: 1, height: 1)
//        imgUpi.layer.shadowRadius = 1
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CardDetaiilCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardDetaiilCollectionViewCell")
        collectionView.isUserInteractionEnabled = true
//        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .horizontal
//        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
extension CardDetailTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsDetailArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardDetaiilCollectionViewCell", for: indexPath) as! CardDetaiilCollectionViewCell
        cell.setValues(accountDetailsOnIIN: cardsDetailArr[indexPath.item])
        //cell.imgBankLogo.image = indexPath.row == 0 ? UIImage(named: "my-card-ic") : UIImage(named: "my-card2-ic")
        cell.contentView.isUserInteractionEnabled = true
        cell.btnTap.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func handleTap(_ sender: UIButton) {
        // handling code
        self.delegate?.buttonTag(index: sender.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.section == 0 {
//            let xPadding = 0
//            let spacing = 10
//            let rightPadding = 10
//            let width = (CGFloat(UIScreen.main.bounds.size.width - 10) - CGFloat(xPadding + spacing + rightPadding))/1.5
//            let height = CGFloat(200)
//            
//            return CGSize(width: width, height: height)
//        } else {
            let xPadding = 0
            let spacing = 10
            let rightPadding = 10
            let width = (CGFloat(UIScreen.main.bounds.size.width - 200)) //- CGFloat(xPadding + spacing + rightPadding))/2
            let height = CGFloat(240)
            
            return CGSize(width: 300, height: 180)
        //}180
        //return CGSize(width: 0, height: 0)
    }
    
}
