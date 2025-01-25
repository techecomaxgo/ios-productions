//
//  FlightTwoWayViewController.swift
//  MaxPay
//
//  Created by Admin on 10/07/24.
//

import UIKit

import SwiftLoader

class FlightTwoWayViewController: BaseVC, flightfilterSelectedDelegate {
  
    

    private var searchFlightTwoVm =  FlightSearchTwo_ViewModel()


    @IBOutlet weak var viewForBottom: UIView!
    
    
    @IBOutlet weak var viewFilter: UIView!

    
    @IBOutlet weak var collectionCard: UICollectionView!
    
    @IBOutlet weak var leftTableView: UITableView!
    
    @IBOutlet weak var rightTableView: UITableView!
    
    @IBOutlet weak var lblFarePrice: UILabel!
    
    var journeysArr : [Journeys]?
    
    var segmentsArr : [Segments]?
 
    
    
    var segmentsLeftArr : [Segments]?

    var segmentsRightArr : [Segments]?
    
    
    var segmentsCardArr : [Segments]?

    var  departTwoDateStr = ""

    var  returnTwoDateStr = ""

    var departPrice = 0.0
    var returnPrice = 0.0
    
    var totalPrice = ""
    
    var originCode = ""
    var originCity = ""
    
    var destinationCode = ""
    var destinationCity = ""
    
    var fromCityIdStr = 0
    
    var toCityIdStr = 0
    
    @IBOutlet weak var lblFromToCodeDisplay: UILabel!
    
    @IBOutlet weak var lblToFromCodeDisplay: UILabel!
    

    
    var  bondsArr : [Bonds]?
    
    var  legsArr : [Legs]?
    
    var  fareDict : Fare?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        leftTableView.dataSource = self
        leftTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.delegate = self

//        collectionCard.delegate = self
//        collectionCard.dataSource = self
//        collectionCard.isPagingEnabled = true
        
        
        // FlightSearchTwo_ViewModel
        
        
        lblFromToCodeDisplay.text = "\(originCode) - \(destinationCode)"
        
        lblToFromCodeDisplay.text = "\(destinationCode) - \(originCode)"
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            
            DispatchQueue.main.async {
                SwiftLoader.show(animated: true)
                
            }
            
            searchFlightTwoVm.flightTwoSearchApiCall(skeyStr: "AVJQIdwn79iR0zlP0iKNKumME", travelDateStr: departTwoDateStr, returnDateStr: returnTwoDateStr, originStr: originCode, destinationStr: destinationCode, adultStr: 1, childStr: 0, infantStr: 0, tripTypeStr: 1, cabinStr: 0)
            
            
            /*
            (skeyStr: "142418AgQWGaSEHXoQ58ae75c4", travelDateStr: "2024-07-10", originStr: originCode, destinationStr: destinationCode, adultStr: 1, childStr: 0, infantStr: 0, tripTypeStr: 0, cabinStr: 0)
            */
            
            observeFlightTwoApi()
            
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
        
        
    }
    
    
    
    
    //MARK: Observing the data
    func observeFlightTwoApi() {
        
        searchFlightTwoVm.eventHandler = { [weak self] event in
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
                    
                    if self?.searchFlightTwoVm.flightSearchModelBase?.status == "success" {
                        
                        
                        self?.journeysArr = self?.searchFlightTwoVm.flightSearchModelBase?.data?.journeys
                        
                        self?.segmentsLeftArr = []
                        
                        self?.segmentsRightArr =  []
                        
                        self?.segmentsCardArr =  []
                        
                        
                        
//                        self?.segmentsArr = self?.journeysArr?[0].segments
                        
                        if let journeys = self?.journeysArr, journeys.count > 0 {
                            
                            print(journeys.count)
                            
                            if journeys.count == 1{
                              
                                if journeys[0].segments!.count  > 0 {
                                    
                                    self?.segmentsLeftArr =  self?.journeysArr?[0].segments
                                    
                                    self?.segmentsCardArr?.append((self?.segmentsLeftArr![0])!)
                                    
                                    
                                   // let departFlightPrice = self?.segmentsLeftArr

                               
                                }
                                
                            }else if journeys.count == 2{
                                
                                
                                if journeys[0].segments!.count  > 0 {
                                    
                                    self?.segmentsLeftArr =  self?.journeysArr?[0].segments
                                    
                                    self?.segmentsCardArr?.append((self?.segmentsLeftArr![0])!)
                               
                                }
                                
                                if journeys[1].segments!.count  > 0 {
                                    
                                    self?.segmentsRightArr =  self?.journeysArr?[1].segments
                                    
                                    self?.segmentsCardArr?.append((self?.segmentsRightArr![0])!)

                               
                                }
                                
                                
                                
                            }else{
                                
                                
                            }
                            
                            
                        }

               

                        
                      //  print(self?.segmentsLeftArr?.count)
                        
                      //  print(self?.segmentsRightArr?.count)
                        
                      //  print(self!.segmentsCardArr?.count)
                        
                       // print(self?.segmentsCardArr?[0].fare?.totalTaxWithOutMarkUp ?? 0)
                        //print(self?.segmentsCardArr?[1].fare?.totalTaxWithOutMarkUp ?? 0)

                        self?.departPrice = Double(self?.segmentsCardArr?[0].fare?.totalTaxWithOutMarkUp ?? 0)
                        
                        self?.returnPrice = Double(self?.segmentsCardArr?[1].fare?.totalTaxWithOutMarkUp ?? 0)

                        
                    
                        //let departFlightPrice = self?.segmentsLeftArr
           
                        // fareDict?.totalTaxWithOutMarkUp ?? 0
                        
                        //leftTableCellData?.fare
                        

                        DispatchQueue.main.async {
                            
                           // print("Total Price :", "₹ \((self?.departPrice ?? 0.0) + (self?.returnPrice ?? 0.0))")
                            
                            self?.lblFarePrice.text = "₹ \((self?.departPrice ?? 0.0) + (self?.returnPrice ?? 0.0))"
                            
                            
                          //  let addPrice = self?.departPrice ?? 0.0 + self!.returnPrice

                            self?.totalPrice =  "\((self?.departPrice ?? 0.0) + (self?.returnPrice ?? 0.0))"
                            
                            self?.leftTableView.reloadData()

                            self?.rightTableView.reloadData()

                            self?.collectionCard.reloadData()

                            SwiftLoader.hide()
                            
                            //self?.topViewflightCard.isHidden = false
                            self?.viewFilter.isHidden = false
                            self?.leftTableView.isHidden = false
                            
                            self?.rightTableView.isHidden = false
                            
                            self?.viewForBottom.isHidden = false
                            
                        }
                        
                        
                    }else{
                        
                       // self?.topViewflightCard.isHidden = true
                      
                        self?.viewFilter.isHidden = true

                        self?.leftTableView.isHidden = true
                        
                        self?.rightTableView.isHidden = true
                                                
                        self?.viewForBottom.isHidden = true

                        self?.showErrorAlert(self?.searchFlightTwoVm.flightSearchModelBase?.status ?? "")
                        
                    }
                    
                    
                    
                        
      
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
    
    
    
    func SetTwoWayCardData(from:String,to:String,oneWayCardData: Segments?,indexStr:Int) {
        
        print(oneWayCardData!)
        
        /*
        
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

        */
        
        
    }
    
    
    @IBAction func btnBookClicked(_ sender: UIButton) {
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TravellersDetailsVC") as! TravellersDetailsVC
        vc.totalfarePrice = self.totalPrice
       
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btnFilterClicked(_ sender: UIButton) {
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FlightFilterView") as! FlightFilterView

        vc.delegateFlightfilterSelected = self
       
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
    func filterItemsSelected(filterItems: [String]) {
        
        
        
    }
    
    
    
    
    
    
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



extension FlightTwoWayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if tableView == leftTableView {
            
            return segmentsLeftArr?.count ?? 0
            
        } else {
            
            return segmentsRightArr?.count ?? 0
            
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == leftTableView {
        
            
            let cell = leftTableView.dequeueReusableCell(withIdentifier: "LeftTableTVC") as! LeftTableTVC
            
           // cell.setoneWayCellData(oneWayCellData: self.segmentsArr?[indexPath.row])
            
            cell.setLeftCellData(leftTableCellData: self.segmentsLeftArr?[indexPath.row])
            
            return cell
            
            
        } else {
           
            
            
            let cell = rightTableView.dequeueReusableCell(withIdentifier: "RightTableTVC") as! RightTableTVC
            

            
            cell.setRightCellData(rightTableCellData: self.segmentsRightArr?[indexPath.row])
            
            
            return cell
           
        }
        
        DispatchQueue.main.async {
            
            self.collectionCard.reloadData()
            
        }
        
        
        
        }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == leftTableView {
            
            print(segmentsCardArr)
            
          //  segmentsCardArr?.insert(segmentsCardArr![indexPath.row], at: 0)
            
           // segmentsCardArr?.append(segmentsCardArr![indexPath.row])
            
        }else{
            
           // segmentsCardArr?.insert(segmentsRightArr![indexPath.row], at: 1)
            
            
        }

      //  self.SetCardData(from: self.originCity, to: self.destinationCity, oneWayCardData: self.segmentsArr?[indexPath.row], indexStr: indexPath.row)

        
       // print("segmentsCardArr",segmentsCardArr?.count)

        
    }
    

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 110
    }
    
    
}


extension FlightTwoWayViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return self.segmentsCardArr?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
                
            let cell = collectionCard.dequeueReusableCell(withReuseIdentifier: "FlightTwoWayCVC", for: indexPath) as! FlightTwoWayCVC
                
        // cell.setoneWayCellData(oneWayCellData: self.segmentsArr?[indexPath.row])

        cell.setTopCardellData(twoWayCellData: self.segmentsCardArr?[indexPath.row])
        
        if indexPath.row == 0 {
            
           // cardRBack
           // oneWayCellData?.bonds[0].legs[0].flightName ?? ""
            
            let flightName = self.segmentsCardArr?[indexPath.row].bonds?[0].legs?[0].flightName ?? ""
            
           if flightName == "SpiceJet" {
                
               cell.imgCardBackPic.image = UIImage(named: "cardGrBack")


           }else{
               cell.imgCardBackPic.image = UIImage(named: "cardGrBack")

           }
            
            
            cell.lblFromCity.text = originCode
            cell.lblToCity.text = destinationCode
            
            
        }else if indexPath.row == 1 {
            
            //cardBBack
            //oneWayCellData?.bonds[0].legs[0].flightName ?? ""
            
            let flightName = self.segmentsCardArr?[indexPath.row].bonds?[0].legs?[0].flightName ?? ""
            
            if flightName == "SpiceJet" {
                 
                cell.imgCardBackPic.image = UIImage(named: "cardGrBack")


            }else{
                
                cell.imgCardBackPic.image = UIImage(named: "cardGrBack")
            }
            
            
            cell.lblFromCity.text = destinationCode
            cell.lblToCity.text = originCode
             
            
        }else{
            
            
        }
        
        
            return cell
            
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        
        return CGSize(width: width, height: height)
        
     
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
       
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
        
        return 10
    }

    
   

    
    
    
}
