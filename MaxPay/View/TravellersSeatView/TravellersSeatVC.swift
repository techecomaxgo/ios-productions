//
//  TravellersSeatVC.swift
//  MaxPay
//
//  Created by Admin on 07/07/24.
//

import UIKit

class TravellersSeatVC: UIViewController {

    @IBOutlet weak var imgSeatBack: UIImageView!
    
    @IBOutlet weak var lblFarePrice: UILabel!
    
    var  bondsArr : [Bonds]?
    
    var legsArr : [Legs]?
    
    var fareDict : Fare?
    
    
    @IBOutlet weak var collectionViewBuSeats: UICollectionView!
    
    var seats: [FlightSeatTravellerModel] = []
    var selectedSeats: [FlightSeatTravellerModel] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        
        print("₹ \(fareDict?.totalTaxWithOutMarkUp ?? 0)")
        
        lblFarePrice.text = "₹ \(fareDict?.totalTaxWithOutMarkUp ?? 0)"

        //FlightSeatTravellerModel
        
        
        collectionViewBuSeats.dataSource = self
        collectionViewBuSeats.delegate = self
        
        // Initialize seats
        for i in 0..<21 {
            
            seats.append(FlightSeatTravellerModel(id: i, isSelected: false, price: 250))
            
        }
        
        collectionViewBuSeats.reloadData()

        
        
        
    }
    
    func updateTotalPrice() {
            let totalPrice = selectedSeats.reduce(0) { $0 + $1.price }
        lblFarePrice.text = "₹ \(totalPrice)"
        }
    
    

    @IBAction func btnBusinessClassSeatSelected(_ sender: UIButton) {
        
        
        
    }
    
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnContinueClicked(_ sender: UIButton) {
        
        
        //MealsAddOnView
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "MealsAddOnView") as! MealsAddOnView
////        vc.fareDict = fareDictDVC
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
        //FlightCheckoutViewController
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FlightCheckoutViewController") as! FlightCheckoutViewController
//        vc.fareDict = fareDictDVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
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



extension TravellersSeatVC: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TravellersCVC", for: indexPath) as! TravellersCVC
        let seat = seats[indexPath.row]
        
        cell.configure(with: seat)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var seat = seats[indexPath.row]
        seat.isSelected.toggle()
        seats[indexPath.row] = seat
        
        if seat.isSelected {
            selectedSeats.append(seat)
        } else {
            selectedSeats.removeAll { $0.id == seat.id }
        }
        
        collectionView.reloadItems(at: [indexPath])
        
        updateTotalPrice()
        
    }
    
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let padding: CGFloat = 0
            let collectionViewSize = collectionView.frame.size.width - padding
            
            let cellWidth = collectionViewSize / 7 // For example, 7 cells per row
            let cellHeight: CGFloat = 56 // Set the desired height
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    
    
    
}
