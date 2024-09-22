//
//  FlightOnwWayViewController.swift
//  MaxPay
//
//  Created by Admin on 05/07/24.
//

import UIKit
import SwiftLoader

class FlightOnwWayViewController: BaseVC, flightfilterSelectedDelegate {
   

    @IBOutlet weak var tableViewOne: UITableView!
    
    var  bondsArr : [Bonds]?
    
    var legsArr : [Legs]?
    
    var fareDict : Fare?

    
    var originCode = ""
    var originCity = ""
    
    var destinationCode = ""
    var destinationCity = ""
    
    
    var fromCityIdStr = 0
    
    var toCityIdStr = 0
    
    var  travelFDateStr = ""
    
    var  travelDateDispStr = ""

    
    @IBOutlet weak var topViewflightCard: UIView!
    
    @IBOutlet weak var viewFilter: UIView!
    
    @IBOutlet weak var viewForBottom: UIView!
    
    
    @IBOutlet weak var lblOriginTime: UILabel!
    
    @IBOutlet weak var lblOriginCity: UILabel!
    
    @IBOutlet weak var lblDestinTime: UILabel!
    
    @IBOutlet weak var lblDestinCity: UILabel!
    
    @IBOutlet weak var lblTotalTravelTime: UILabel!
    
    @IBOutlet weak var lblNoStops: UILabel!
    
    
    @IBOutlet weak var ViewflightTopCard: UIImageView!
    
    private var searchFlightOneVm =  SearchFlightOne_ViewModel()

    var journeysArr : [Journeys]?
    
    var segmentsArr : [Segments]?
    
    var filteredSegmentsArr: [Segments]? = []


    @IBOutlet weak var lblFlightName: UILabel!
    
    @IBOutlet weak var lblFare: UILabel!
    
    @IBOutlet weak var lblFarePrice: UILabel!
    
    var farePriceStr = ""
    
    
    @IBOutlet weak var lblTravelDate: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblTravelDate.text = travelDateDispStr
        
        
        topViewflightCard.isHidden = true
        viewFilter.isHidden = true
        tableViewOne.isHidden = true
        viewForBottom.isHidden = true
        
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            
            DispatchQueue.main.async {
                SwiftLoader.show(animated: true)
                
            }
            
            searchFlightOneVm.flightOneSearchApiCall(skeyStr: "142418AgQWGaSEHXoQ58ae75c4", travelDateStr: travelFDateStr, originStr: originCode, destinationStr: destinationCode, adultStr: 1, childStr: 0, infantStr: 0, tripTypeStr: 0, cabinStr: 0)
            
            observeFlightOneApi()
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
        
        
        
        
    }
    
   
    
    
    //MARK: Observing the data
    func observeFlightOneApi() {
        
        searchFlightOneVm.eventHandler = { [weak self] event in
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
                                        
                  //  print((self?.searchFlightOneVm.flightSearchModelBase?.data?.journeys?.count)!)
                    
                    
                    
                    SwiftLoader.hide()
                    
                    if self?.searchFlightOneVm.flightSearchModelBase?.status == "success" {
                        
                        
                        self?.journeysArr = self?.searchFlightOneVm.flightSearchModelBase?.data?.journeys
                        
                        
                        self?.segmentsArr = self?.journeysArr?[0].segments
                        
                        print(self?.segmentsArr?.count)
                                          
                        self?.SetCardData(from: self?.originCity ?? "", to: self?.destinationCity ?? "", oneWayCardData: self?.segmentsArr?[0], indexStr: 0)

                        
                        //print(self?.rankVM.rankModelBase?.data?.allrank)
                        
                       // self?.addRankArr = self?.rankVM.rankModelBase?.data?.allrank
                        
                       // self?.operatorResData = self?.operatorVM.OperatorBaseModel?.responseData
                        
                        

                        DispatchQueue.main.async {
                            
                            
                            self?.tableViewOne.reloadData()

                            SwiftLoader.hide()
                            
                            self?.topViewflightCard.isHidden = false
                            self?.viewFilter.isHidden = false
                            self?.tableViewOne.isHidden = false
                            
                            self?.viewForBottom.isHidden = false
                            
                        }
                        
                    }else{
                        
                        self?.topViewflightCard.isHidden = true
                        self?.viewFilter.isHidden = true
                        self?.tableViewOne.isHidden = true
                        
                        self?.viewForBottom.isHidden = true
                        
                        self?.showErrorAlert(self?.searchFlightOneVm.flightSearchModelBase?.status ?? "")
                        
                    }
                    
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
    

    func SetCardData(from:String,to:String,oneWayCardData: Segments?,indexStr:Int) {
        
      //  print(oneWayCardData!)
        
        bondsArr = []
        legsArr =  []
        
        fareDict = oneWayCardData?.fare
        
        bondsArr = oneWayCardData?.bonds
        
        legsArr = bondsArr?[0].legs
            
        
        if legsArr?[0].numberOfStops == "0"{
            
            
            lblTotalTravelTime.text = legsArr?[0].duration ?? ""
            lblNoStops.text = "Non-Stop"
            
        } else if  legsArr?[indexStr].numberOfStops == "1"{
            
            lblTotalTravelTime.text = legsArr?[0].duration ?? ""
            lblNoStops.text = "1 Stop"

        } else if  legsArr?[indexStr].numberOfStops == "2"{
            
            lblTotalTravelTime.text = legsArr?[0].duration ?? ""
            lblNoStops.text = "2 Stop"

        }else if  legsArr?[indexStr].numberOfStops == "3"{
            
            lblTotalTravelTime.text = legsArr?[0].duration ?? ""
            lblNoStops.text = "3 Stop"


        }else if  legsArr?[indexStr].numberOfStops == "4"{
            
            lblTotalTravelTime.text = legsArr?[0].duration ?? ""
            lblNoStops.text = "4 Stop"

        }
        else{
            
            
        }
        
        
        lblOriginCity.text = from
        lblDestinCity.text = to
        lblOriginTime.text = legsArr?[0].departureTime ?? ""
        lblDestinTime.text = legsArr?[0].arrivalTime ?? ""
       
        lblFlightName.text = legsArr?[0].flightName ?? ""
        lblFare.text = "₹ \(fareDict?.totalTaxWithOutMarkUp ?? 0)"
        
        
        lblFarePrice.text = "₹ \(fareDict?.totalTaxWithOutMarkUp ?? 0)"

        
        
        
    }
    
    
    
    @IBAction func btnContinueClicked(_ sender: UIButton) {
        
        //TravellersDetailsVC
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TravellersDetailsVC") as! TravellersDetailsVC
        vc.fareDictDVC = fareDict
       
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func btnFilterClicked(_ sender: UIButton) {
         
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FlightFilterView") as! FlightFilterView

        vc.delegateFlightfilterSelected = self
       
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    func filterAndSortSegments(flightData: [Journeys], startTime: String, endTime: String) -> [Segments] {
        var filteredSegments = [Segments]()
        
        // Convert the string times to Date objects
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "HH:mm"

           // Helper function to convert date string to Date
           func dateFromString(_ timeString: String) -> Date? {
               return dateFormatter.date(from: String(timeString.prefix(5)))
           }

           guard let start = dateFromString(startTime), let end = dateFromString(endTime) else {
               return []
           }
        
        for journey in flightData {
            for segment in journey.segments! {
                var filteredBonds = [Bonds]()
                for bond in segment.bonds! {
                    let filteredLegs = bond.legs!.filter { leg in
                        if let departureTime = dateFormatter.date(from: String(leg.departureTime!.prefix(5))) {
                            return departureTime >= start && departureTime <= end
                        }
                        return false
                    }
                    if !filteredLegs.isEmpty {
                        var newBond = bond
                        newBond.legs = filteredLegs
                        filteredBonds.append(newBond)
                    }
                }
                if !filteredBonds.isEmpty {
                    var newSegment = segment
                    newSegment.bonds = filteredBonds
                    filteredSegments.append(newSegment)
                }
            }
        }
        
        
        // Flatten the list of legs and sort them
            var allLegs = [Legs]()
            for segment in filteredSegments {
                for bond in segment.bonds! {
                    allLegs.append(contentsOf: bond.legs!)
                }
            }
        
        allLegs.sort {
                let time1 = dateFromString($0.departureTime!) ?? Date()
                let time2 = dateFromString($1.departureTime!) ?? Date()
                return time1 < time2
            }
        
//        // Sort the legs by departure time within each bond
//            for i in 0..<filteredSegments.count {
//                for j in 0..<filteredSegments[i].bonds!.count {
//                    filteredSegments[i].bonds?[j].legs?.sort {
//                        let time1 = dateFromString($0.departureTime ?? "") ?? Date()
//                        let time2 = dateFromString($1.departureTime ?? "") ?? Date()
//                        return time1 < time2
//                    }
//                }
//            }
        
        
        // Sort the filtered segments by DepartureTime
        for i in 0..<filteredSegments.count {
            for j in 0..<filteredSegments[i].bonds!.count {
                filteredSegments[i].bonds![j].legs!.sort {
                    let time1 = dateFormatter.date(from: String($0.departureTime!.prefix(5))) ?? Date()
                    let time2 = dateFormatter.date(from: String($1.departureTime!.prefix(5))) ?? Date()
                    return time1 < time2
                }
            }
        }
        
        return filteredSegments
    }

   
    //arrivalTime
  
    func filterAndSortarrivalSegments(flightData: [Journeys], startTime: String, endTime: String) -> [Segments] {
        var filteredSegments = [Segments]()
        
        // Convert the string times to Date objects
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "HH:mm"

           // Helper function to convert date string to Date
           func dateFromString(_ timeString: String) -> Date? {
               return dateFormatter.date(from: String(timeString.prefix(5)))
           }

           guard let start = dateFromString(startTime), let end = dateFromString(endTime) else {
               return []
           }
        
        for journey in flightData {
            for segment in journey.segments! {
                var filteredBonds = [Bonds]()
                for bond in segment.bonds! {
                    let filteredLegs = bond.legs!.filter { leg in
                        if let arrivalTime = dateFormatter.date(from: String(leg.arrivalTime!.prefix(5))) {
                            return arrivalTime >= start && arrivalTime <= end
                        }
                        return false
                    }
                    if !filteredLegs.isEmpty {
                        var newBond = bond
                        newBond.legs = filteredLegs
                        filteredBonds.append(newBond)
                    }
                }
                if !filteredBonds.isEmpty {
                    var newSegment = segment
                    newSegment.bonds = filteredBonds
                    filteredSegments.append(newSegment)
                }
            }
        }
        
        
        // Flatten the list of legs and sort them
            var allLegs = [Legs]()
            for segment in filteredSegments {
                for bond in segment.bonds! {
                    allLegs.append(contentsOf: bond.legs!)
                }
            }
        
        allLegs.sort {
                let time1 = dateFromString($0.arrivalTime!) ?? Date()
                let time2 = dateFromString($1.arrivalTime!) ?? Date()
                return time1 < time2
            }
        
//        // Sort the legs by departure time within each bond
//            for i in 0..<filteredSegments.count {
//                for j in 0..<filteredSegments[i].bonds!.count {
//                    filteredSegments[i].bonds?[j].legs?.sort {
//                        let time1 = dateFromString($0.departureTime ?? "") ?? Date()
//                        let time2 = dateFromString($1.departureTime ?? "") ?? Date()
//                        return time1 < time2
//                    }
//                }
//            }
        
        
        // Sort the filtered segments by DepartureTime
        for i in 0..<filteredSegments.count {
            for j in 0..<filteredSegments[i].bonds!.count {
                filteredSegments[i].bonds![j].legs!.sort {
                    let time1 = dateFormatter.date(from: String($0.arrivalTime!.prefix(5))) ?? Date()
                    let time2 = dateFormatter.date(from: String($1.arrivalTime!.prefix(5))) ?? Date()
                    return time1 < time2
                }
            }
        }
        
        return filteredSegments
    }
    
    
    func filterAndSortStopSegments(flightData: [Journeys], startTime: String, endTime: String) -> [Segments] {
        var filteredSegments = [Segments]()
        
        // Convert the string times to Date objects
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "HH:mm"

           // Helper function to convert date string to Date
           func dateFromString(_ timeString: String) -> Date? {
               return dateFormatter.date(from: String(timeString.prefix(5)))
           }

           guard let start = dateFromString(startTime), let end = dateFromString(endTime) else {
               return []
           }
        
        for journey in flightData {
            for segment in journey.segments! {
                var filteredBonds = [Bonds]()
                for bond in segment.bonds! {
                    let filteredLegs = bond.legs!.filter { leg in
                        if let departureTime = dateFormatter.date(from: String(leg.numberOfStops!.prefix(5))) {
                            return departureTime >= start && departureTime <= end
                        }
                        return false
                    }
                    if !filteredLegs.isEmpty {
                        var newBond = bond
                        newBond.legs = filteredLegs
                        filteredBonds.append(newBond)
                    }
                }
                if !filteredBonds.isEmpty {
                    var newSegment = segment
                    newSegment.bonds = filteredBonds
                    filteredSegments.append(newSegment)
                }
            }
        }
        
        
        // Flatten the list of legs and sort them
            var allLegs = [Legs]()
            for segment in filteredSegments {
                for bond in segment.bonds! {
                    allLegs.append(contentsOf: bond.legs!)
                }
            }
        
        allLegs.sort {
                let time1 = dateFromString($0.numberOfStops!) ?? Date()
                let time2 = dateFromString($1.numberOfStops!) ?? Date()
                return time1 < time2
            }
        
//        // Sort the legs by departure time within each bond
//            for i in 0..<filteredSegments.count {
//                for j in 0..<filteredSegments[i].bonds!.count {
//                    filteredSegments[i].bonds?[j].legs?.sort {
//                        let time1 = dateFromString($0.departureTime ?? "") ?? Date()
//                        let time2 = dateFromString($1.departureTime ?? "") ?? Date()
//                        return time1 < time2
//                    }
//                }
//            }
        
        
        // Sort the filtered segments by DepartureTime
        for i in 0..<filteredSegments.count {
            for j in 0..<filteredSegments[i].bonds!.count {
                filteredSegments[i].bonds![j].legs!.sort {
                    let time1 = dateFormatter.date(from: String($0.numberOfStops!.prefix(5))) ?? Date()
                    let time2 = dateFormatter.date(from: String($1.numberOfStops!.prefix(5))) ?? Date()
                    return time1 < time2
                }
            }
        }
        
        return filteredSegments
    }
    
    func filterItemsSelected(filterItems: [String]) {
        
        print(filterItems)
        
        // ["Price - Low to High", "Early Departure", "Afternoon 12:00 to 18:00 (Boarding)", "Evening 18:00 to 00:00 (Boarding)", "Non-Stop"]
        
        for itemsFilter in filterItems {
            
            print("Each filter items :",itemsFilter)
            
            if  itemsFilter == "Price - Low to High" {
                
               // var segmentsArr: [Segments] = []
                
                segmentsArr = (self.journeysArr?[0].segments)!

                segmentsArr = segmentsArr?.sorted { $0.fare?.totalTaxWithOutMarkUp ?? 0 < $1.fare?.totalTaxWithOutMarkUp ?? 0 }

                print("segmentsArr after Filter",segmentsArr?.count)
                
                tableViewOne.reloadData()
                
                
            } else if  itemsFilter == "Morning 6:00 to 12:00 (Boarding)" {

                segmentsArr = []
                
                if self.journeysArr?.count ?? 0 > 0{
                    
                    segmentsArr = filterAndSortSegments(flightData: self.journeysArr!, startTime: "06:00", endTime: "12:00")
                   
                }
                
                // Use segmentsArr as needed
                for segment in segmentsArr! {
                        for bond in segment.bonds! {
                            for leg in bond.legs! {
                                print("Filtered and Sorted Flight Departure Time: \(leg.departureTime ?? "")")
                            }
                        }
                    }
                
              tableViewOne.reloadData()
                
            }
            else if  itemsFilter == "Afternoon 12:00 to 18:00 (Boarding)" {

                var segmentsArr: [Segments] = []

                if self.journeysArr?.count ?? 0 > 0{
                    
                    segmentsArr = filterAndSortSegments(flightData: self.journeysArr!, startTime: "12:00", endTime: "18:00")

                   
                }
                
                // Use segmentsArr as needed
                for segment in segmentsArr {
                        for bond in segment.bonds! {
                            for leg in bond.legs! {
                                print("Filtered and Sorted Flight Departure Time: \(leg.departureTime ?? "")")
                            }
                        }
                    }
                
                self.segmentsArr = segmentsArr

                
              tableViewOne.reloadData()
                
            }
            else if  itemsFilter == "Evening 18:00 to 00:00 (Boarding)" {

                var segmentsArr: [Segments] = []

                
                if self.journeysArr?.count ?? 0 > 0{
                    
                    segmentsArr = filterAndSortSegments(flightData: self.journeysArr!, startTime: "18:00", endTime: "00:00")
                   
                }
                
                // Use segmentsArr as needed
                for segment in segmentsArr {
                        for bond in segment.bonds! {
                            for leg in bond.legs! {
                                print("Filtered and Sorted Flight Departure Time: \(leg.departureTime ?? "")")
                            }
                        }
                    }
                
                self.segmentsArr = segmentsArr

                
              tableViewOne.reloadData()
                
            }

            else if  itemsFilter == "Night 00:00 to 06:00 (Boarding)" {

                var segmentsArr: [Segments] = []

                
                if self.journeysArr?.count ?? 0 > 0{
                    
                    segmentsArr = filterAndSortSegments(flightData: self.journeysArr!, startTime: "00:00", endTime: "06:00")

                   
                }
                
                // Use segmentsArr as needed
                for segment in segmentsArr {
                        for bond in segment.bonds! {
                            for leg in bond.legs! {
                                print("Filtered and Sorted Flight Departure Time: \(leg.departureTime ?? "")")
                            }
                        }
                    }
                
                self.segmentsArr = segmentsArr

                
              tableViewOne.reloadData()
                
            }
            
            else if  itemsFilter == "Morning 6:00 to 12:00 (Arrival)" {

                var segmentsArr: [Segments] = []

                
                if self.journeysArr?.count ?? 0 > 0{
                    
                    segmentsArr = filterAndSortarrivalSegments(flightData: self.journeysArr!, startTime: "6:00", endTime: "12:00")

                   
                }
                
                // Use segmentsArr as needed
                for segment in segmentsArr {
                        for bond in segment.bonds! {
                            for leg in bond.legs! {
                                print("Filtered and Sorted Flight Departure Time: \(leg.departureTime ?? "")")
                            }
                        }
                    }
                
                self.segmentsArr = segmentsArr

                
              tableViewOne.reloadData()
                
            }
            
            else if  itemsFilter == "Afternoon 12:00 to 18:00 (Arrival)" {

                var segmentsArr: [Segments] = []

                if self.journeysArr?.count ?? 0 > 0{
                    
                    segmentsArr = filterAndSortarrivalSegments(flightData: self.journeysArr!, startTime: "12:00", endTime: "18:00")

                   
                }
                
                // Use segmentsArr as needed
                for segment in segmentsArr {
                        for bond in segment.bonds! {
                            for leg in bond.legs! {
                                print("Filtered and Sorted Flight Departure Time: \(leg.departureTime ?? "")")
                            }
                        }
                    }
                
                self.segmentsArr = segmentsArr

                
              tableViewOne.reloadData()
                
            }
            
            else if  itemsFilter == "Evening 18:00 to 00:00 (Arrival)" {
                
                var segmentsArr: [Segments] = []


                if self.journeysArr?.count ?? 0 > 0{
                    
                    segmentsArr = filterAndSortarrivalSegments(flightData: self.journeysArr!, startTime: "18:00", endTime: "00:00")
                   
                }
                
                // Use segmentsArr as needed
                for segment in segmentsArr {
                        for bond in segment.bonds! {
                            for leg in bond.legs! {
                                print("Filtered and Sorted Flight Departure Time: \(leg.departureTime ?? "")")
                            }
                        }
                    }
                
                self.segmentsArr = segmentsArr

                
              tableViewOne.reloadData()
                
            }
            
            else if  itemsFilter == "Night 00:00 to 06:00 (Arrival)" {
                
                var segmentsArr: [Segments] = []


                if self.journeysArr?.count ?? 0 > 0{
                    
                    segmentsArr = filterAndSortarrivalSegments(flightData: self.journeysArr!, startTime: "00:00", endTime: "06:00")
                   
                }
                
                // Use segmentsArr as needed
                for segment in segmentsArr {
                        for bond in segment.bonds! {
                            for leg in bond.legs! {
                                
                                print("Filtered and Sorted Flight Departure Time: \(leg.departureTime ?? "")")
                                
                            }
                        }
                    }
                
                self.segmentsArr = segmentsArr

                
                
              tableViewOne.reloadData()
                
            }
            
            else if  itemsFilter == "Non-Stop" {
                
                
                var segmentsArr: [Segments] = []
              

                for journey in self.journeysArr! {
                           let filteredSegments = journey.segments!.filter { segment in
                               return segment.bonds!.contains { bond in
                                   bond.legs!.contains { leg in
                                       leg.numberOfStops == "0"
                                   }
                               }
                           }
                           segmentsArr.append(contentsOf: filteredSegments)
                       }
                self.segmentsArr = segmentsArr

                
              tableViewOne.reloadData()
                
            }
            
            else if  itemsFilter == "1 Stop" {

                var segmentsArr: [Segments] = []
              

                for journey in self.journeysArr! {
                           let filteredSegments = journey.segments!.filter { segment in
                               return segment.bonds!.contains { bond in
                                   bond.legs!.contains { leg in
                                       leg.numberOfStops == "1"
                                   }
                               }
                           }
                           segmentsArr.append(contentsOf: filteredSegments)
                       }
                
                self.segmentsArr = segmentsArr
                
              tableViewOne.reloadData()
                
            }
            
            else if  itemsFilter == "2+ Stop" {

                
                var segmentsArr: [Segments] = []
              

                for journey in self.journeysArr! {
                           let filteredSegments = journey.segments!.filter { segment in
                               return segment.bonds!.contains { bond in
                                   bond.legs!.contains { leg in
                                       leg.numberOfStops == "2"
                                   }
                               }
                           }
                           segmentsArr.append(contentsOf: filteredSegments)
                       }
                
                self.segmentsArr = segmentsArr
                
                
              tableViewOne.reloadData()
                
            }
            
            
        }
        
        
//        if filterItems == "Price - Low to High" {
//            
//            
//        }
        
        /*
         
         if priceButton.isSelected { filters.append("Price - Low to High") }
         if bestRatedButton.isSelected { filters.append("Best Rated first") }
         if earlyDepartureButton.isSelected { filters.append("Early Departure") }
         if lateDepartureButton.isSelected { filters.append("Late Departure") }
         
         if boardingMorningButton.isSelected { filters.append("Morning 6:00 to 12:00 (Boarding)") }
         if boardingAfternoonButton.isSelected { filters.append("Afternoon 12:00 to 18:00 (Boarding)") }
         if boardingEveningButton.isSelected { filters.append("Evening 18:00 to 00:00 (Boarding)") }
         if boardingNightButton.isSelected { filters.append("Night 00:00 to 06:00 (Boarding)") }
         
         if arrivalMorningButton.isSelected { filters.append("Morning 6:00 to 12:00 (Arrival)") }
         if arrivalAfternoonButton.isSelected { filters.append("Afternoon 12:00 to 18:00 (Arrival)") }
         if arrivalEveningButton.isSelected { filters.append("Evening 18:00 to 00:00 (Arrival)") }
         if arrivalNightButton.isSelected { filters.append("Night 00:00 to 06:00 (Arrival)") }
         
         if nonStopButton.isSelected { filters.append("Non-Stop") }
         if oneStopButton.isSelected { filters.append("1 Stop") }
         if twoPlusStopButton.isSelected { filters.append("2+ Stop") }
         
         */
        

//        print(segmentsArr?.count)
//
//        filteredSegmentsArr = segmentsArr?.sorted { $0.fare?.totalTaxWithOutMarkUp ?? 0 < $1.fare?.totalTaxWithOutMarkUp ?? 0 }

      //  print(filteredSegmentsArr?.count)
        
        
        // Print sorted segments to verify
//            if let filteredSegments = filteredSegmentsArr {
//                
//                for segment in filteredSegments {
//                    print(segment.fare?.totalTaxWithOutMarkUp ?? 0)
//                }
//                
//            }
        
        
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




extension FlightOnwWayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.segmentsArr?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableViewOne.dequeueReusableCell(withIdentifier: "FlightOneWayTVC") as! FlightOneWayTVC
        
        cell.setoneWayCellData(oneWayCellData: self.segmentsArr?[indexPath.row])
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        self.SetCardData(from: self.originCity, to: self.destinationCity, oneWayCardData: self.segmentsArr?[indexPath.row], indexStr: indexPath.row)
                
    }
    
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        tableView.deselectRow(at: indexPath, animated: true)
//        textfieldSearch.resignFirstResponder()
//
//        let contact = filteredContactList[indexPath.row]
//
//        if arrRecentContactList.count > 5 {
//            arrRecentContactList.removeLast()
//        }
//        arrRecentContactList.insert(contact, at: 0)
//
//        // Save cards to NSUserDefaults
//        do {
//            let contactData = try JSONEncoder().encode(arrRecentContactList)
//            Common.shared.recentContacts = contactData
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        // RechargePlanViewController
//
//        let vc = UIStoryboard(name: "USP", bundle: nil).instantiateViewController(withIdentifier: "RechargePlanViewController") as! RechargePlanViewController
//        vc.contactNo = contact.contactNumbers ?? ""
//       // vc.skeyStr = accountDetails
//        self.navigationController?.pushViewController(vc, animated: true)
//
//
//
//    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
    }
    
    
}



