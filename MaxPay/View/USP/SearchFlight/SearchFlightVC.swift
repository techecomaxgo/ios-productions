//
//  SearchFlightVC.swift
//  MaxPay
//
//  Created by india on 24/11/23.
//

import UIKit

class SearchFlightVC: BaseVC,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblSearchFlight: UITableView!
    @IBOutlet weak var segmentcontroller: CustomGradientSegmentedControl!
    @IBOutlet weak var btnFlight: UIButton!
    @IBOutlet weak var vwFlightBack: ShadowedView!
    var selectedWay:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
//        vwFlightBack.layer.cornerRadius = 18
//        vwFlightBack.layer.borderColor = UIColor.gray.cgColor
//        vwFlightBack.layer.borderWidth = 1
//        btnFlight.layer.cornerRadius = 12.5
//        btnFlight.layer.borderColor = UIColor(hexString: "9FC438").cgColor
//        btnFlight.layer.borderWidth = 1
        tblSearchFlight.register(
            UINib(nibName: "SearchFlightOneWayCell", bundle: nil),
            forCellReuseIdentifier: "SearchFlightOneWayCell")
        tblSearchFlight.register(
            UINib(nibName: "SearchFlightMultiCityCell", bundle: nil),
            forCellReuseIdentifier: "SearchFlightMultiCityCell")
        selectedWay = 0
    }
    @IBAction func segmentValueChange(_ sender: UISegmentedControl) {
            
            switch sender.selectedSegmentIndex {
            case 0:
                selectedWay = 0
            case 1:
                selectedWay = 1
            case 2:
                selectedWay = 2
            default:
                print("")
            }
        tblSearchFlight.reloadData()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0{
                if selectedWay == 2{
                    return 350
                }else{
                    return 460
                }
            }else{
                return 150
            }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if selectedWay == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFlightMultiCityCell", for: indexPath) as! SearchFlightMultiCityCell
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFlightOneWayCell", for: indexPath) as! SearchFlightOneWayCell
                cell.selectionStyle = .none
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchCell", for: indexPath) as! RecentSearchCell
            cell.selectionStyle = .none
            cell.collVW.reloadData()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SearchFlightListVC") as! SearchFlightListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
