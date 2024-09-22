//
//  SearchFlightListVC.swift
//  MaxPay
//
//  Created by india on 24/11/23.
//

import UIKit

class SearchFlightListVC: BaseVC, UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tblSearchFlight: UITableView!
    @IBOutlet weak var vwTop: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        vwTop.layer.applyCornerRadiusShadow()
        vwTop.layer.cornerRadius = 4
        vwTop.layer.borderColor = UIColor.black.cgColor
        vwTop.layer.borderWidth = 1
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFlightListCell", for: indexPath) as! SearchFlightListCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FlightDetailsVC") as! FlightDetailsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
