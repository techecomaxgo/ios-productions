//
//  FlightDetailsVC.swift
//  MaxPay
//
//  Created by india on 24/11/23.
//

import UIKit

class FlightDetailsVC: BaseVC {

    @IBOutlet weak var vwWay: UIView!
    @IBOutlet weak var vwContinueBooking: UIView!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var vwTime: UIView!
    @IBOutlet weak var collVWClaim: UICollectionView!
    @IBOutlet weak var vwPayment: UIView!
    @IBOutlet weak var vwFlightDetails: UIView!
    @IBOutlet weak var vwDetails: UIView!
    @IBOutlet weak var vwTop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vwWay.layer.applyCornerRadiusShadow()
        vwWay.layer.cornerRadius = 4
        vwWay.layer.borderColor = UIColor.lightGray.cgColor
        vwWay.layer.borderWidth = 1
        
        vwTop.layer.applyCornerRadiusShadow()
        vwTop.layer.cornerRadius = 4
        vwTop.layer.borderColor = UIColor.lightGray.cgColor
        vwTop.layer.borderWidth = 1
        
        vwTime.layer.applyCornerRadiusShadow()
        vwTime.layer.cornerRadius = 4
        vwTime.layer.borderColor = UIColor.lightGray.cgColor
        vwTime.layer.borderWidth = 1
        
        vwFlightDetails.layer.applyCornerRadiusShadow()
        vwFlightDetails.layer.cornerRadius = 4
        vwFlightDetails.layer.borderColor = UIColor.lightGray.cgColor
        vwFlightDetails.layer.borderWidth = 1
        
        vwDetails.layer.applyCornerRadiusShadow()
        vwDetails.layer.cornerRadius = 4
        vwDetails.layer.borderColor = UIColor.lightGray.cgColor
        vwDetails.layer.borderWidth = 1
        
        vwPayment.layer.applyCornerRadiusShadow()
        vwPayment.layer.cornerRadius = 4
        vwPayment.layer.borderColor = UIColor.lightGray.cgColor
        vwPayment.layer.borderWidth = 1
        
        vwContinueBooking.clipsToBounds = true
        vwContinueBooking.layer.cornerRadius = 10
        vwContinueBooking.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnContinueBookingAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FlightReviewVC") as! FlightReviewVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class CollVWClaimCell : UICollectionViewCell {
    @IBOutlet weak var vwBack: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vwBack.layer.applyCornerRadiusShadow()
        vwBack.layer.cornerRadius = 4
        vwBack.layer.borderColor = UIColor.lightGray.cgColor
        vwBack.layer.borderWidth = 1
        
    }
}
extension FlightDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollVWClaimCell", for: indexPath) as! CollVWClaimCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10.0
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 4

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size , height: size + 30)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "BBPS", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CatagoryListVC") as! CatagoryListVC
        self.navigationController?.pushViewController(vc,animated: true)
    }
}

extension CALayer {
    func applySketchShadow(
      color: UIColor = .black,
      alpha: Float = 0.5,
      x: CGFloat = 0,
      y: CGFloat = 2,
      blur: CGFloat = 4,
      spread: CGFloat = 0)
    {
      masksToBounds = false
      shadowColor = color.cgColor
      shadowOpacity = alpha
      shadowOffset = CGSize(width: x, height: y)
      shadowRadius = blur / 2.0
      if spread == 0 {
        shadowPath = nil
      } else {
        let dx = -spread
        let rect = bounds.insetBy(dx: dx, dy: dx)
        shadowPath = UIBezierPath(rect: rect).cgPath
      }
    }
  }
