//
//  HotelSearchVC.swift
//  MaxPay
//
//  Created by india on 14/12/23.
//

import UIKit

class HotelSearchVC: BaseVC {

    @IBOutlet weak var tblHotelSearch: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblHotelSearch.register(
            UINib(nibName: "HotelSearchCell", bundle: nil),
            forCellReuseIdentifier: "HotelSearchCell")
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func didTapClickAddRoom(sender: UIButton) {
        let viewController = RoomListVC(nibName: "RoomListVC", bundle: nil)
        present(viewController, animated: true)
    }
    @objc func didTapClickSearchHotel(sender: UIButton) {
         let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
         let vc = storyBoard.instantiateViewController(withIdentifier: "HotelListVC") as! HotelListVC
         self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension HotelSearchVC:UITableViewDelegate,UITableViewDataSource{
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelSearchCell", for: indexPath) as! HotelSearchCell
        cell.selectionStyle = .none
        cell.btnAddRoom.addTarget(self, action: #selector(didTapClickAddRoom(sender:)), for: .touchUpInside)
        cell.btnSearchHotel.addTarget(self, action: #selector(didTapClickSearchHotel(sender:)), for: .touchUpInside)
        let date = Date()
//      cell.lblDepatureDate.text = Common.shared.showDate(date)
        return cell
    }
}
