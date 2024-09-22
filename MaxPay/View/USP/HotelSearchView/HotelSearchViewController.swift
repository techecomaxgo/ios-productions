//
//  HotelSearchViewController.swift
//  MaxPay
//
//  Created by Admin on 03/06/24.
//


// Define a struct for the Child details



import UIKit
import SwiftLoader

class HotelSearchViewController: BaseVC {
    
    
    
    
    @IBOutlet weak var lblTotalHotelsCountShow: UILabel!
    
   private var hotelSearchVM = HotelSearchViewModel()
    
    var hotelListArr : [Hotellist] = []
    
    var hotelsResult : Hotels?

    var totalHSRoomsStr = 0
    var totalHSAdultsStr = 0
    var totalHSChildrenStr = 0
    var childAgeArr : [String] = []
    
    var selectedCity = ""
    var guestcountstr = ""
    
    
    var checkOutDateStr = ""
    var checkInDateStr = ""
    
    @IBOutlet weak var tableHotelistView: UITableView!
    
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var btnEditSEarch: UIButton!
    
    @IBOutlet weak var lblsearchDetails: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
       // let room1 = createRoomDetail(numberOfAdults: 2, numberOfChildren: 1, childAges: [5])
      //  let room2 = createRoomDetail(numberOfAdults: 1, numberOfChildren: 0, childAges: [])

       // roomDetails.append(room1)
       // roomDetails.append(room2)
        
       // childAgeArr = ["8"]
        
        
        lblCity.text = selectedCity
        
        lblsearchDetails.text = guestcountstr
        
        print(totalHSRoomsStr)
        print(totalHSAdultsStr)
        print(totalHSChildrenStr)
        print(childAgeArr)
        
        // createRoomDetails
        
        if totalHSRoomsStr == 0 && totalHSAdultsStr == 0{
            
            totalHSRoomsStr = 1
            totalHSAdultsStr = 1
            
            
        }
    
       
        SwiftLoader.show(animated: true)
        
        let roomDetails = createRoomDetails(numberOfAdults: totalHSAdultsStr, numberOfChildren: totalHSChildrenStr, childrenAges: childAgeArr)
      
        print(roomDetails)
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
           
            hotelSearchVM.GetHotelSearchModelApiCall(skeyStr: "142418AgQWGaSEHXoQ58ae75c4", city: selectedCity, CheckInDate: checkInDateStr, CheckOutDate: checkOutDateStr, RoomCount: totalHSRoomsStr, Adults: totalHSAdultsStr, Child: totalHSChildrenStr, Nights: 1, HotelCount: 30, RoomDetails: roomDetails, maxPrice: "100000", minPrice: "100", sorttype: "Popular|DESC")
            
            
            //milesTotalViewModel.GetMilesApiCall(skeyStr: "142418AgQWGaSEHXoQ58ae75c4")

            observeSearchHotelListApi()
            
        
            
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
        
        
        
        
    }
    
    
    @IBAction func btnEditSearchClicked(_ sender: UIButton) {
        
        
        self.navigationController?.popViewController(animated: true)

        
    }
    
    
    @IBAction func btnShareClicked(_ sender: UIButton) {
        
        
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
    
    
    
    

    
    
    
    //MARK: Observing the data
    func observeSearchHotelListApi() {
        
        hotelSearchVM.eventHandler = { [weak self] event in
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
                    
             
                    
                    if self?.hotelSearchVM.getHotelSearchModel?.status == "success" {
                        
                       
                        
                        //self?.addRankArr = self?.rankVM.rankModelBase?.data?.allrank
                        
                       // self?.operatorResData = self?.operatorVM.OperatorBaseModel?.responseData
                        
                        

                        DispatchQueue.main.async {
                            
                            self?.hotelsResult = self?.hotelSearchVM.getHotelSearchModel?.hotels
                            self?.hotelListArr  =  self?.hotelSearchVM.getHotelSearchModel?.hotels?.hotellist ?? []
                          //  print(self?.hotelSearchVM.getHotelSearchModel?.hotels?.hotellist?.count)
                            
                            self?.lblTotalHotelsCountShow.text = "\(String(describing: self?.hotelListArr.count ?? 0)) Properties Available"
                            
                           
                            
                          
                            self?.tableHotelistView.reloadData()

                            SwiftLoader.hide()
                            
                            
                        }
                        
                    }else{
                        
                        self?.showErrorAlert(self?.hotelSearchVM.getHotelSearchModel?.message ?? "")
                        
                    }
                    
                    
                    
                        
      
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
                
            }
        }
    }
    
//    func createRoomDetail(numberOfAdults: Int, numberOfChildren: Int, childAges: [Int]) -> [String: Any] {
//        var childDetails: [String: Any] = [:]
//        
//        if numberOfChildren > 0 {
//            var ageDict: [String: Any] = [:]
//            for (index, age) in childAges.enumerated() {
//                ageDict["age\(index + 1)"] = age
//            }
//            childDetails = [
//                "NumberOfChild": numberOfChildren,
//                "childAge": ageDict
//            ]
//        } else {
//            childDetails = [
//                "NumberOfChild": numberOfChildren,
//                "childAge": [:]
//            ]
//        }
//        
//        return [
//            "NumberOfAdults": numberOfAdults,
//            "Child": childDetails
//        ]
//    }

    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        
        self.navigationController?.popViewController(animated: true)
        
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



extension HotelSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.hotelListArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableHotelistView.dequeueReusableCell(withIdentifier: "HotelSearchTVC") as! HotelSearchTVC
        
        
        cell.setHotelListData(hotelListData: self.hotelListArr[indexPath.row])
        //cell.cosmosViewHalf.rating = 3
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 320
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HotelDetailsViewController") as! HotelDetailsViewController
        
        vc.SelectedhotelsData =  self.hotelListArr[indexPath.row]
        vc.hotelsResultData = self.hotelsResult
        
        vc.selectedCity = selectedCity
        vc.guestcountstr = guestcountstr
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
