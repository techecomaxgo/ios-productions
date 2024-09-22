//
//  HotelDetailsViewController.swift
//  MaxPay
//
//  Created by Admin on 03/06/24.
//

import UIKit
import Cosmos
import SwiftLoader

class HotelDetailsViewController: BaseVC {
    
    
    @IBOutlet weak var imageCollectionPageview: UICollectionView!
    
    
    
    
    private var hotelDetailVM = HotelDetails_ViewModel()
        
    var hotelsResultData : Hotels?
    
    var roomImageListArr : [RoomImageList]?
    
    var roomAmenitiesListArr : [HotelAmenitiesList]?

    
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblsearchDetails: UILabel!
    
    var SelectedhotelsData : Hotellist?
    
    let amenities = ["Free Toiletries", "Parking Facility", "Free WiFi", "Swimming Pool", "Gym", "Laundry", "Room Service", "Restaurant", "Bar", "Spa"]
    var isExpanded = false
    
//    lazy var collectionView: UICollectionView = {
//            let layout = UICollectionViewFlowLayout()
//            layout.itemSize = CGSize(width: 120, height: 40)
//            layout.minimumInteritemSpacing = 10
//            layout.minimumLineSpacing = 10
//            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//            collectionView.register(AmenityCell.self, forCellWithReuseIdentifier: AmenityCell.reuseIdentifier)
//            collectionView.dataSource = self
//            collectionView.delegate = self
//            collectionView.backgroundColor = .white
//            collectionView.translatesAutoresizingMaskIntoConstraints = false
//            return collectionView
//        }()

    
    
    
    @IBOutlet weak var collectionHotelView: UICollectionView!
    
    
    @IBOutlet weak var viewforSeeMore: UIView!
    
    @IBOutlet weak var viewForCollection: UIView!
    
   
    
    
    @IBOutlet weak var lblTotalPriceWithTax: UILabel!
    
    
    @IBOutlet weak var ViewCheckIn: UIView!
    
    @IBOutlet weak var viewCheckOut: UIView!
    
    @IBOutlet weak var viewGuestCount: UIView!
    
    
    var selectedCity = ""
    var guestcountstr = ""
    
    
    @IBOutlet weak var lblHotelname: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    
    @IBOutlet weak var lblcheckInDate: UILabel!
    
    @IBOutlet weak var lblGuestCount: UILabel!
    
    @IBOutlet weak var lblNightcount: UILabel!
    
    @IBOutlet weak var lblCheckoutDate: UILabel!
    
    @IBOutlet weak var txtViewHotelDetails: UITextView!
    
    @IBOutlet weak var cosmosViewHalf: CosmosView!
    
    
    @IBOutlet weak var viewBackCardView: CardView!
    
    @IBOutlet weak var lblCoupleFriendly: UILabel!
    
    @IBOutlet weak var lblNonfriendly: UILabel!
    
    @IBOutlet weak var lblPageCount: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        imageCollectionPageview.delegate = self
        imageCollectionPageview.dataSource = self
        imageCollectionPageview.isPagingEnabled = true

        collectionHotelView.delegate = self
        collectionHotelView.dataSource = self
        
        
        lblPageCount.isHidden = true
        lblPageCount.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        lblPageCount.layer.cornerRadius = 6
        lblPageCount.layer.masksToBounds = true
        
        lblNonfriendly.layer.cornerRadius = 2
        lblNonfriendly.layer.masksToBounds = true

        
        lblCoupleFriendly.layer.cornerRadius = 2
        lblCoupleFriendly.layer.masksToBounds = true


        
        
//        updatePageLabel(for: 0)
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            DispatchQueue.main.async {
                SwiftLoader.show(animated: true)
                
            }
            
            hotelDetailVM.GetHotelDetailsModelApiCall(skeyStr: "142418AgQWGaSEHXoQ58ae75c4", hotelIDStr: SelectedhotelsData?.hotelID ?? "", engineIDStr: SelectedhotelsData?.engineType ?? 0, eMTCommonIDStr: SelectedhotelsData?.eMTCommonID ?? "")
            
            observeSearchDetailsApi()
            
        
            
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
        
        
        
        
       // print(SelectedhotelsData)
       // print(hotelsResultData)
        
       // print(Common.shared.convertshowHDate(hotelsResultData?.checkInDate ?? ""))
        

        lblcheckInDate.text = Common.shared.convertshowHDate(hotelsResultData?.checkInDate ?? "")
        
        lblCheckoutDate.text = Common.shared.convertshowHDate(hotelsResultData?.checkOutDate ?? "")
        
        lblNightcount.text = "\(hotelsResultData?.nights ?? 0) Nights"
        
        //txtViewHotelDetails.text = SelectedhotelsData?.d ?? ""
        
        print(SelectedhotelsData?.checkInTime ?? "")
        print(SelectedhotelsData?.checkOutTime ?? "")

    
        txtViewHotelDetails.layer.applyCornerRadiusShadow()
        viewBackCardView.layer.applyCornerRadiusShadow()
        ViewCheckIn.layer.applyCornerRadiusShadow()
        viewCheckOut.layer.applyCornerRadiusShadow()
        viewGuestCount.layer.applyCornerRadiusShadow()
        
        
        
        
        let currency = "₹"
        let amount = "\(SelectedhotelsData?.price ?? 0)/-"
        let taxes = "+\(SelectedhotelsData?.surchargeTotal ?? 0) Taxes & fees"

        
        // Create the main attributed string
        let mainString = "\(currency)\(amount) \(taxes)" 
        let attributedString = NSMutableAttributedString(string: mainString)

        // Define the range for the amount part
        let amountRange = (mainString as NSString).range(of: "\(currency)\(amount)")

        // Define the range for the taxes part
        let taxesRange = (mainString as NSString).range(of: taxes)

        // Apply bold font to the amount part
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: amountRange)

        // Apply lighter font to the taxes part
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 10), range: taxesRange)

        // Display the attributed string in a UILabel
        
        lblTotalPriceWithTax.attributedText = attributedString

        // Set number of lines to 0 for multi-line support
        lblTotalPriceWithTax.numberOfLines = 0

        // Optionally, set the text color
        lblTotalPriceWithTax.textColor = .black

        // Set the label's frame or use Auto Layout to position it
        lblTotalPriceWithTax.translatesAutoresizingMaskIntoConstraints = false
       
        
        lblCity.text = selectedCity
        
        lblsearchDetails.text = guestcountstr
        
        lblHotelname.text = SelectedhotelsData?.hotelName ?? ""
        lblLocation.text = "\(SelectedhotelsData?.location ?? ""),\(SelectedhotelsData?.city ?? "")"
       
//        imgHotelPic.sd_setImage(with: URL(string: SelectedhotelsData?.imageThumbUrl ?? ""), placeholderImage: UIImage(named: "hotelsamplePic.png"))
//        
//        imgHotelPic.layer.applyCornerRadiusShadow()
        

        cosmosViewHalf.rating = Double(SelectedhotelsData?.rating ?? "") ?? 0.0
        
    }
    
    
    //MARK: Observing the data
    func observeSearchDetailsApi() {
        
        hotelDetailVM.eventHandler = { [weak self] event in
            guard self != nil else { return }

            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                SwiftLoader.hide()
            case .dataLoaded:
                
                print("Data loaded...")
                DispatchQueue.main.async {
                                        
                  //  print((self?.milesTotalViewModel.getMilesModel?.data)!)
                    
             
                    
                    if self?.hotelDetailVM.getHotelDetalsModel?.status == "success" {
                        
                       
                        
                        //self?.addRankArr = self?.rankVM.rankModelBase?.data?.allrank
                        
                       // self?.operatorResData = self?.operatorVM.OperatorBaseModel?.responseData
                        

                        DispatchQueue.main.async {
                            
                            self?.roomImageListArr = self?.hotelDetailVM.getHotelDetalsModel?.hotelDetail?.roomImageList
                            
                            self?.lblPageCount.text = "\(1) / \(String(describing: self?.roomImageListArr?.count ?? 0))"
                            self?.lblPageCount.isHidden = false
                            self?.roomAmenitiesListArr = self?.hotelDetailVM.getHotelDetalsModel?.hotelDetail?.hotelAmenitiesList
                            
                            if let attributedString = self?.htmlToAttributedString(html: self?.hotelDetailVM.getHotelDetalsModel?.hotelDetail?.description ?? "") {
                                
                                self?.txtViewHotelDetails.attributedText = attributedString

                                    }
                            
                            
                            self?.collectionHotelView.reloadData()
                            
                            self?.imageCollectionPageview.reloadData()
                            
                            SwiftLoader.hide()
                            
                            
                        }
                        
                    }else{
                        
                        self?.showErrorAlert(self?.hotelDetailVM.getHotelDetalsModel?.message ?? "")
                        
                    }
                    
                 
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
                
            }
        }
    }
    
    
    
    func htmlToAttributedString(html: String) -> NSAttributedString? {
            guard let data = html.data(using: .utf8) else { return nil }
            do {
                let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
                return attributedString
            } catch {
                print("Error converting HTML to NSAttributedString: \(error)")
                return nil
            }
        }
    

    
    @IBAction func btnBackClicked(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnSelectRoomClicked(_ sender: UIButton) {
        
        
        //HotelRoomTypesVC
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HotelRoomTypesVC") as! HotelRoomTypesVC
        
        vc.SelectedRoomhotelsData = SelectedhotelsData
        vc.checkInDate = lblcheckInDate.text ?? ""
        vc.checkOutDate = lblCheckoutDate.text ?? ""
        vc.nightsStr = lblNightcount.text ?? ""
        vc.guestcountstr = guestcountstr
        vc.selectedCity =  selectedCity
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
//    override func viewWillLayoutSubviews() {
//        
//        super.viewWillLayoutSubviews()
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 90, height: 30)
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
//        collectionHotelView.collectionViewLayout = layout
//        
//    }
//    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension HotelDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if(collectionView == self.imageCollectionPageview) {
            
            return self.roomImageListArr?.count ?? 0
        }else {
            
            return self.roomAmenitiesListArr?.count ?? 0

        }
            

        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if(collectionView == self.imageCollectionPageview) {
            
            let cell = imageCollectionPageview.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
            
            
            cell.imageHotel.isUserInteractionEnabled = true
            cell.imageHotel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTap)))

            
            cell.imageHotel.sd_setImage(with: URL(string: roomImageListArr?[indexPath.row].url ?? ""), placeholderImage: UIImage(named: "hotelsamplePic.png"))
            
            cell.imageHotel.layer.applyCornerRadiusShadow()
            
    
           
            return cell
            
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmenityCollectionViewCell", for: indexPath) as! AmenityCollectionViewCell
            
            cell.amenityLabel.layer.cornerRadius = 6
            cell.amenityLabel.layer.masksToBounds = true
            cell.amenityLabel.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
            
            cell.amenityLabel.text = self.roomAmenitiesListArr?[indexPath.row].amenity
            
    //        cell.amenityLabel
           
            return cell
        }
        
    }
    
    // Func in your UIViewController
    @objc func imageTap() {
        
        let vc = UIStoryboard(name: "USP", bundle: nil).instantiateViewController(withIdentifier: "PhotoGalleryVC") as! PhotoGalleryVC
        vc.ImagegalleryArr = self.roomImageListArr
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
    // Update the label when the user scrolls
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let visibleIndex = Int(scrollView.contentOffset.x / self.imageCollectionPageview.frame.width)
            updatePageLabel(for: visibleIndex)
        }
    
    
    
    func updatePageLabel(for index: Int) {
        lblPageCount.text = "\(index + 1) / \(String(describing: self.roomImageListArr?.count ?? 0))"
        }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if let collection = self.imageCollectionPageview {
//            
//            return UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
//        }
//        
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//        
//        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            if(collectionView == self.imageCollectionPageview) {
                           let width = collectionView.bounds.width
                           let height = collectionView.bounds.height
                           
                           return CGSize(width: width, height: height)
                           
                       } else {

                           
                           let width = collectionHotelView.frame.width / 3
                                   let height = collectionHotelView.frame.height
                                   return CGSize(width: width, height: height)

                           
                       }
            
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            
            if(collectionView == self.imageCollectionPageview) {
                return 0
            }
            return 10
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            
            if(collectionView == self.imageCollectionPageview) {
                return 0
            }
            
            return 10
        }
    
    
    
    
}
