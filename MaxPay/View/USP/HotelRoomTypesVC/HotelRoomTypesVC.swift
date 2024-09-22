//
//  HotelRoomTypesVC.swift
//  MaxPay
//
//  Created by Admin on 05/06/24.
//

import UIKit
import SwiftLoader


class RoomTypeCategory {
    var categoryName: String?
    
    var mealType: [DeluxeDuplex]??
    
    
    init(categoryName: String, mealType: [DeluxeDuplex]) {
        self.categoryName = categoryName
        self.mealType = mealType
    }
    
    
    
    
}

class HotelRoomTypesVC: BaseVC {
    
    
    var roomTypeCategory = [RoomTypeCategory]()

    
    
    var checkInDate = ""
    var checkOutDate = ""
    var nightsStr = ""
    
    var adultsChildStr = ""
    var roomTypeStr = ""
    
    var selectedCity = ""
    var guestcountstr = ""

    
    private var hotelRoomTypesViewModel = HotelRoomTypes_ViewModel()


    @IBOutlet weak var lblHotleName: UILabel!
    
    @IBOutlet weak var tableViewRoomType: UITableView!
    
    
    @IBOutlet weak var lblLocation: UILabel!
    
    
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var lblDatetimeSum: UILabel!
    
    var SelectedRoomhotelsData : Hotellist?

    var totalHSRoomsStr = 0
    var totalHSAdultsStr = 2
    var totalHSChildrenStr = 0
    var childAgeArr : [String] = []
    
    var roomTypesdataDict : HotelRoomTypes_Data?
    
    
    var availableRoomDict : AvailableTypeRoom?
    
    
    var roomTypesArr : [String] = []
    
    var roomdisplayPicUrl = ""
    
    
    var deluxeDuplexArr : [DeluxeDuplex]?
    var executiveRoomArr : [ExecutiveRoom]?
    var suiteArr : [Suite]?
    
    var deluxeDuplexStr : DeluxeDuplex?

    
    var selectedRadioArr = [false,false,false,false,false,false]
    
    var heightForRowTablewView = 0

    @IBOutlet weak var viewForCard: CardView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // print(SelectedRoomhotelsData)
        
        lblDatetimeSum.text = guestcountstr
        lblLocation.text = selectedCity
        
        viewForCard.layer.applyCornerRadiusShadow()
        
        let roomDetails = createRoomDetails(numberOfAdults: totalHSAdultsStr, numberOfChildren: totalHSChildrenStr, childrenAges: childAgeArr)
        
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
        
            
            hotelRoomTypesViewModel.GetHotelTypeApiCall(skeyStr: "142418AgQWGaSEHXoQ58ae75c4", city: "New Delhi, India", CheckInDate: "2024-06-16", CheckOutDate: "2024-06-17", RoomCount: 1, hotelID: "101098017", engineID: 32, eMTCommonID: "EMTHOTEL-1134482", hotelName: "CALISTA RESORT", Adults: 2, Child: 0, Nights: 1, HotelCount: 30, RoomDetails: roomDetails, maxPrice: "100000", minPrice: "100", sorttype: "Popular|DESC")
           

            observeHotelRoomTypeApi()
            
        
            
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
        
        
        
        tableViewRoomType.delegate = self
        tableViewRoomType.dataSource = self
        
        
        
    }
    
    
    
    //MARK: Observing the data
    func observeHotelRoomTypeApi() {
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        hotelRoomTypesViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }

            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                SwiftLoader.hide()
            case .dataLoaded:
                
                print("Data loaded...")
                DispatchQueue.main.async { [self] in
                                        
                  //  print((self?.milesTotalViewModel.getMilesModel?.data)!)
                                        
                    if self?.hotelRoomTypesViewModel.getHotelTypeModel?.status == "success" {
                        
                       // print(self?.hotelRoomTypesViewModel.getHotelTypeModel?.data)
                        
                        self?.roomTypesdataDict = self?.hotelRoomTypesViewModel.getHotelTypeModel?.data
                        
                       // print(self?.roomTypesdataArr)
                        
                        self?.roomdisplayPicUrl = self?.roomTypesdataDict?.imageThumbUrl ?? ""
                        
                        self?.availableRoomDict = self?.roomTypesdataDict?.availableRoom
                        
                      //  print(self?.availableRoomDict)
                        
                        
//                        let availableRoomKeys = Array(self?.roomTypesdataDict?.availableRoom.keys)
//                        print(availableRoomKeys)  // Output: ["Deluxe Duplex", "Suite"]

                    
                        
                        
                        let keys = AvailableTypeRoom.nonStringKeys()
                        print(keys)
                        
                        self?.roomTypesArr = keys
                        
                        self?.deluxeDuplexArr = self?.availableRoomDict?.deluxeDuplex
                        self?.executiveRoomArr = self?.availableRoomDict?.executiveRoom
                        self?.suiteArr = self?.availableRoomDict?.suite
                        
                        print(self?.deluxeDuplexArr?.count)
                        print(self?.executiveRoomArr?.count)
                        print(self?.suiteArr?.count)
                        print(self?.deluxeDuplexArr)
                        
                        //self?.addRankArr = self?.rankVM.rankModelBase?.data?.allrank
                        
                       // self?.operatorResData = self?.operatorVM.OperatorBaseModel?.responseData
                        
                        if self?.deluxeDuplexArr?.count ?? 0 > 0 {
                                                            
                            self!.roomTypeCategory.append(RoomTypeCategory(categoryName: "Deluxe Duplex", mealType:(self?.deluxeDuplexArr)!))
                            
                        }
                        
                        if self?.executiveRoomArr?.count ?? 0 > 0 {
                            
                           // self!.roomTypeCategory.append(RoomTypeCategory(categoryName: "Executive Room", mealType:(self?.executiveRoomArr)!))
                            
                        }
                        
                        if self?.suiteArr?.count ?? 0 > 0 {
                            
                            
                        }
                        

                        DispatchQueue.main.async {
                            
//                            self?.hotelsResult = self?.hotelSearchVM.getHotelSearchModel?.hotels
//                            self?.hotelListArr  =  self?.hotelSearchVM.getHotelSearchModel?.hotels?.hotellist ?? []
//                          //  print(self?.hotelSearchVM.getHotelSearchModel?.hotels?.hotellist?.count)
//                            
//                            self?.lblTotalHotelsCountShow.text = "\(String(describing: self?.hotelListArr.count ?? 0)) Properties Available"
//                            
                            self?.tableViewRoomType.reloadData()

                           SwiftLoader.hide()
                            
                            
                        }
                        
                    }else{
                        
                        self?.showErrorAlert(self?.hotelRoomTypesViewModel.getHotelTypeModel?.message ?? "")
                        
                    }
                    
                    
                    
                        
      
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
                
            }
        }
    }
    
    // Function to create RoomDetails dictionary
    
    func createRoomDetails(numberOfAdults: Int, numberOfChildren: Int, childrenAges: [String]) -> [String: Any] {
        
        let child = Child(numberOfChild: numberOfChildren, childAge: childrenAges)
        let roomDetails = RoomDetails(numberOfAdults: numberOfAdults, child: child)
        
        let roomDetailsDict: [String: Any] = [
            "NumberOfAdults": roomDetails.numberOfAdults,
            "Child": [
                "NumberOfChild": roomDetails.child.numberOfChild,
                "childAge": roomDetails.child.childAge
            ]
        ]
        
        return roomDetailsDict
    }
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnEditHotelSearch(_ sender: UIButton) {
        
        // HotelCheckoutViewController
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HotelCheckoutViewController") as! HotelCheckoutViewController
        
//        vc.SelectedRoomhotelsData = SelectedhotelsData
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btnShareClicked(_ sender: UIButton) {
        
        
        
        
        
    }
    
    //HotelRoomTypesTVC
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

    
extension HotelRoomTypesVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.roomTypesArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableViewRoomType.dequeueReusableCell(withIdentifier: "HotelRoomTypesTVC") as! HotelRoomTypesTVC
        
        cell.viewBackCell.layer.applyCornerRadiusShadow()
        
        cell.btnSelectViewOne.addTarget(self, action: #selector(self.buttonViewOneClicked(sender:)), for: .touchUpInside)
        cell.btnSelectViewTwo.addTarget(self, action: #selector(self.buttonViewOneClicked(sender:)), for: .touchUpInside)
        cell.btnSelectViewThree.addTarget(self, action: #selector(self.buttonViewOneClicked(sender:)), for: .touchUpInside)
        cell.btnSelectViewFour.addTarget(self, action: #selector(self.buttonViewOneClicked(sender:)), for: .touchUpInside)

        
        if roomTypesArr[indexPath.row] == "Deluxe Duplex" {
            
            cell.setRoomTypeData(roomTypeData: roomTypesArr[indexPath.row], duplexData: self.deluxeDuplexArr)

            
        } else if roomTypesArr[indexPath.row] == "Executive Room"{
            
            cell.setRoomTypeData(roomTypeData: roomTypesArr[indexPath.row], executiveData: self.executiveRoomArr)
            
        } else if roomTypesArr[indexPath.row] == "Suite"{
            
            cell.setRoomTypeData(roomTypeData: roomTypesArr[indexPath.row], suitsData: self.suiteArr)
            
        }else{
            
            
        }
        
        //HotelRoomTypesVC
        
        cell.imgForRoom.sd_setImage(with: URL(string: roomdisplayPicUrl), placeholderImage: UIImage(named: "hotelsamplePic.png"))
        
        cell.imgForRoom.layer.applyCornerRadiusShadow()

        
      //cell.setHotelListData(hotelListData: self.hotelListArr[indexPath.row])
     //cell.cosmosViewHalf.rating = 3 roomTypesArr
        
        return cell
        
    }
    
    
    
    @objc func buttonViewOneClicked(sender:UIButton) {
        
        print("Button \(sender.tag) clicked")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HotelCheckoutViewController") as! HotelCheckoutViewController
        
        vc.checkInDate = checkInDate
        vc.checkOutDate = checkOutDate
        vc.nightsStr = nightsStr
        vc.guestcountstr = guestcountstr
        vc.selectedCity =  selectedCity
        vc.hotelName = SelectedRoomhotelsData?.hotelName ?? ""
        vc.hotelLocation = SelectedRoomhotelsData?.location ?? ""
        vc.roomTypeStr = "Executive Room"
        
       vc.RoomhotelsData = SelectedRoomhotelsData
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if executiveRoomArr?.count == 2{
            
            heightForRowTablewView = 300
            
        }else if executiveRoomArr?.count == 4 {
            
            heightForRowTablewView = 480
        }
        
        return CGFloat(heightForRowTablewView)
        
    }
    
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "HotelDetailsViewController") as! HotelDetailsViewController
//        
//        vc.SelectedhotelsData =  self.hotelListArr[indexPath.row]
//        vc.hotelsResultData = self.hotelsResult
//        
//        vc.selectedCity = selectedCity
//        vc.guestcountstr = guestcountstr
//        
//        
//        self.navigationController?.pushViewController(vc, animated: true)
//        
//    }
    
    
   
    
}



extension AvailableTypeRoom {
    static func nonStringKeys() -> [String] {
        let allKeys: [CodingKeys: Any.Type] = [
            .deluxeDuplex: [DeluxeDuplex].self,
            .executiveRoom: [ExecutiveRoom].self,
            .suite: [Suite].self,
            
        ]

        return allKeys
            .filter { $0.value != String.self }
            .map { $0.key.rawValue }
    }
}
