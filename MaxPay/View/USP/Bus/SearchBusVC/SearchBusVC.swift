//
//  SearchBusVC.swift
//  MaxPay
//
//  Created by india on 05/12/23.
//

import UIKit
import SwiftLoader


class SearchBusVC: BaseVC,UITableViewDelegate,UITableViewDataSource,CustomSearchDelegate,DatePickerDelegate {
   
    
    
    func selectedDateonscroll(selectedSDate: Date) {
        
        print(selectedSDate)
    }
    
    
    @IBOutlet weak var tblSearchBus: UITableView!
    private var busSearchCityViewModel = BusSearchCityViewModel()
    var arrCity = [String]()
    var strFromCity = "",strToCity = ""
    var selectAddress:Int?
    var sourceID:Int?,destinationID:Int?
    var strJourneyDate = ""
    var isBolCity = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let  date = Date()
        strJourneyDate = Common.shared.dateApiAllowed(date)
        tblSearchBus.register(
            UINib(nibName: "SearchBusCell", bundle: nil),
            forCellReuseIdentifier: "SearchBusCell")
        configurationForCity()
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func showSearch(){
        let vw = CustomSearch()
        vw.frame = UIScreen.main.bounds
        //vw.cities = (busSearchCityViewModel.cityModel?.cities)!
        vw.delegate = self
        vw.arrCity = arrCity
        vw.setupUI()
        view.addSubview(vw)
    }
    func clickCity(_ selectedIndex: Int, _ strCityName: String) {
        let index = IndexPath(row: 0, section: 0)
        let cell: SearchBusCell = self.tblSearchBus.cellForRow(at: index) as! SearchBusCell
        if selectAddress == 0{
            sourceID =  self.busSearchCityViewModel.cityModel?.cities?[selectedIndex].id ?? 0
            cell.txtTo.text = strCityName
            strToCity = cell.txtTo.text ?? ""
        }else{
            cell.txtFrom.text = strCityName
            destinationID = self.busSearchCityViewModel.cityModel?.cities?[selectedIndex].id ?? 0
            strFromCity = cell.txtFrom.text ?? ""
        }
    }
 /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0{
                return 370
            }else{
                return 150
            }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBusCell", for: indexPath) as! SearchBusCell
                cell.selectionStyle = .none
                cell.btnSearchBus.addTarget(self, action: #selector(didTapBusSearchButton(sender:)), for: .touchUpInside)
                cell.btnTo.addTarget(self, action: #selector(didTapClickFrom(sender:)), for: .touchUpInside)
                cell.btnFrom.addTarget(self, action: #selector(didTapClickTo(sender:)), for: .touchUpInside)
                cell.btnDepature.addTarget(self, action: #selector(didTapClickDepature(sender:)), for: .touchUpInside)
                cell.btnTodayDate.addTarget(self, action: #selector(didTapClickTodatDate(sender:)), for: .touchUpInside)
                cell.btnTomorrowDate.addTarget(self, action: #selector(didTapClickTomorrowDate(sender:)), for: .touchUpInside)
                let date = Date()
                cell.lblDepatureDate.text = Common.shared.showDate(date)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchCell", for: indexPath) as! RecentSearchCell
                cell.selectionStyle = .none
                cell.collVW.reloadData()
                return cell
            }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SelectSeatsVC") as! SelectSeatsVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    } */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBusCell", for: indexPath) as! SearchBusCell
                cell.selectionStyle = .none
                cell.btnSearchBus.addTarget(self, action: #selector(didTapBusSearchButton(sender:)), for: .touchUpInside)
                cell.btnTo.addTarget(self, action: #selector(didTapClickFrom(sender:)), for: .touchUpInside)
                cell.btnFrom.addTarget(self, action: #selector(didTapClickTo(sender:)), for: .touchUpInside)
                cell.btnDepature.addTarget(self, action: #selector(didTapClickDepature(sender:)), for: .touchUpInside)
                cell.btnTodayDate.addTarget(self, action: #selector(didTapClickTodatDate(sender:)), for: .touchUpInside)
                cell.btnTomorrowDate.addTarget(self, action: #selector(didTapClickTomorrowDate(sender:)), for: .touchUpInside)
                let date = Date()
                cell.lblDepatureDate.text = Common.shared.showDate(date)
                return cell
    }
    @objc func didTapBusSearchButton(sender: UIButton) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "BusSearchListVC") as! BusSearchListVC
//        self.navigationController?.pushViewController(vc, animated: true)
        isBolCity = false
        configurationForCity()
    }
    @objc func didTapClickFrom(sender: UIButton) {
        selectAddress = 0
        showSearch()
    }
    @objc func didTapClickTo(sender: UIButton) {
        selectAddress = 1
        showSearch()
    }
    @objc func didTapClickDepature(sender: UIButton) {
        MyBasics.showDatePickerDropDown(PickerType: UIDatePicker.Mode.date, ParentViewC: self)
    }
    func selectedDate(selectedDate: Date) {
        let index = IndexPath(row: 0, section: 0)
        let cell: SearchBusCell = self.tblSearchBus.cellForRow(at: index) as! SearchBusCell
        cell.lblDepatureDate.text = Common.shared.showDate(selectedDate)
        strJourneyDate = Common.shared.dateApiAllowed(selectedDate)
    }
    @objc func didTapClickTodatDate(sender: UIButton) {
        let date = Date()
        let index = IndexPath(row: 0, section: 0)
        let cell: SearchBusCell = self.tblSearchBus.cellForRow(at: index) as! SearchBusCell
        cell.lblDepatureDate.text = Common.shared.showDate(date)
        strJourneyDate = Common.shared.dateApiAllowed(date)
    }
    @objc func didTapClickTomorrowDate(sender: UIButton) {
        let today = Date()
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)
        strJourneyDate = Common.shared.dateApiAllowed(tomorrow!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy" // Set your desired date format

        if let tomorrowDate = tomorrow {
            let formattedDate = dateFormatter.string(from: tomorrowDate)
            print("Tomorrow's date is: \(formattedDate)")
            let index = IndexPath(row: 0, section: 0)
            let cell: SearchBusCell = self.tblSearchBus.cellForRow(at: index) as! SearchBusCell
            cell.lblDepatureDate.text = formattedDate
        } else {
            print("Failed to calculate tomorrow's date")
        }
        
    }
    func apiCallForSearchBus(){
        configurationForBusList()
    }
}
extension SearchBusVC {
    //MARK: API Calling
    func configurationForCity() {
        SwiftLoader.show(animated: true)
        initViewModel()
        observeEvent()
    }
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            if isBolCity{
                busSearchCityViewModel.cityCall()
            }else{
                let index = IndexPath(row: 0, section: 0)
                let cell: SearchBusCell = self.tblSearchBus.cellForRow(at: index) as! SearchBusCell
                if cell.txtFrom.text != "" && cell.txtTo.text != ""{
                    busSearchCityViewModel.busListCall(sourceID!, destinationID!, strJourneyDate)
                }else{
                    showAlert(with: "Max", message: "Please add your journey address.")
                }
            }
            
        }else{
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    //MARK: Observing the data
    func observeEvent() {
        busSearchCityViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                SwiftLoader.hide()
            case .dataLoaded:
                print("Data loaded...")
                if self?.isBolCity == true{
                    if self?.busSearchCityViewModel.cityModel?.status == "success" {
                        SwiftLoader.hide()
                        for var i in 0..<(self?.busSearchCityViewModel.cityModel?.cities?.count ?? 0) {
                            self?.arrCity.append(self?.busSearchCityViewModel.cityModel?.cities?[i].name ?? "")
                        }
                        
                    }else{
                        self?.showErrorAlert("Error")
                    }
                    
                }else{
                    let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "BusSearchListVC") as! BusSearchListVC
                    vc.strFromCity = self?.strFromCity ?? ""
                    vc.strCityTo = self?.strToCity ?? ""
                    vc.strJourneyDate = self?.strJourneyDate ?? ""
                    vc.sourceID = self?.sourceID
                    vc.destinationID = self?.destinationID
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                SwiftLoader.hide()
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
    func configurationForBusList() {
        SwiftLoader.show(animated: true)
        initNetWorkChecking()
        observeEventForBusSearch()
    }
    //MARK Network checking
    func initNetWorkChecking() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            SwiftLoader.show(animated: true)
            let index = IndexPath(row: 0, section: 0)
            let cell: SearchBusCell = self.tblSearchBus.cellForRow(at: index) as! SearchBusCell
            if cell.txtFrom.text != "" && cell.txtTo.text != ""{
                busSearchCityViewModel.busListCall(sourceID!, destinationID!, strJourneyDate)
            }else{
                showAlert(with: "Max", message: "Please add your journey address.")
            }
        }else{
            //  ProgressHUD.remove()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    //MARK: Observing the data
    func observeEventForBusSearch() {
        SwiftLoader.show(animated: true)
        busSearchCityViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                SwiftLoader.hide()
            case .dataLoaded:
                print("Data loaded...")
                if self?.busSearchCityViewModel.busListModel?.status == "success" {
                    SwiftLoader.hide()
                    for var i in 0..<(self?.busSearchCityViewModel.cityModel?.cities?.count ?? 0) {
                        self?.arrCity.append(self?.busSearchCityViewModel.cityModel?.cities?[i].name ?? "")
                    }
                    
                    }else{
                        self?.showErrorAlert("Error")
                    }
                SwiftLoader.hide()
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
}
