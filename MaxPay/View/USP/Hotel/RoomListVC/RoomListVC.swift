//
//  RoomListVC.swift
//  MaxPay
//
//  Created by india on 14/12/23.
//
struct AddRoom {
      var Adults:Int
      var Child:Int
}

import UIKit

class RoomListVC: BaseVC {

    @IBOutlet weak var tblAddRoom: UITableView!
    var arrAddRoom = [AddRoom]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tblAddRoom.register(
            UINib(nibName: "AddRoomCell", bundle: nil),
            forCellReuseIdentifier: "AddRoomCell")
        tblAddRoom.register(
            UINib(nibName: "IncreaseRoomCell", bundle: nil),
            forCellReuseIdentifier: "IncreaseRoomCell")
        arrAddRoom.append(AddRoom(Adults: 1, Child: 0))
        
    }
    @objc func didTapClickAddRoomIncrease(sender: UIButton) {
        if arrAddRoom.count <= 8{
            arrAddRoom.append(AddRoom(Adults: 1, Child: 0))
            tblAddRoom.reloadData()
        }
    }
    @objc func didTapClickRemoveRoom(sender: UIButton) {
        if arrAddRoom.count >= 2{
            arrAddRoom.removeLast()
        }
        tblAddRoom.reloadData()
    }
    @objc func didTapClickAddAdult(sender: UIButton) {
//        let index = IndexPath(row:sender.tag, section: 0)
//        let cell: AddRoomCell = self.tblAddRoom.cellForRow(at: index) as! AddRoomCell
        var model = arrAddRoom[sender.tag]
        let add = model.Adults
        if add >= 1{
            arrAddRoom.insert(AddRoom(Adults: add+1, Child: model.Child), at: sender.tag)
        }
        tblAddRoom.reloadData()
    }
    @objc func didTapClickMinusAdult(sender: UIButton) {
        var model = arrAddRoom[sender.tag]
        if model.Adults >= 0{
            arrAddRoom.insert(AddRoom(Adults: model.Adults - 1, Child: model.Child), at: sender.tag)
        }
        tblAddRoom.reloadData()
    }
    @objc func didTapClickAddChild(sender: UIButton) {
        var model = arrAddRoom[sender.tag]
        let add = model.Adults
        if add >= 0{
            arrAddRoom.insert(AddRoom(Adults: add, Child: model.Child + 1), at: sender.tag)
        }
        tblAddRoom.reloadData()
    }
    @objc func didTapClickMinusChild(sender: UIButton) {
        var model = arrAddRoom[sender.tag]
        let add = model.Adults
        if add >= 0{
            arrAddRoom.insert(AddRoom(Adults: add, Child: model.Child - 1), at: sender.tag)
        }
        tblAddRoom.reloadData()
    }
    
}
extension RoomListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return arrAddRoom.count
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 140
        }else{
            return 40
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddRoomCell", for: indexPath) as! AddRoomCell
            cell.selectionStyle = .none
            let model = arrAddRoom[indexPath.row]
            cell.lblAdult.text = "\(model.Adults)"
            cell.lblChild.text = "\(model.Child)"
            cell.lblRoom.text = "Room \((indexPath.row)+1)"
            cell.btnAddAdult.addTarget(self, action: #selector(didTapClickAddAdult(sender:)), for: .touchUpInside)
            cell.btnAdultMinus.addTarget(self, action: #selector(didTapClickMinusAdult(sender:)), for: .touchUpInside)
            cell.btnAddChild.addTarget(self, action: #selector(didTapClickAddChild(sender:)), for: .touchUpInside)
            cell.btnChildMinus.addTarget(self, action: #selector(didTapClickMinusChild(sender:)), for: .touchUpInside)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "IncreaseRoomCell", for: indexPath) as! IncreaseRoomCell
            cell.selectionStyle = .none
            cell.btnAdd.tag = indexPath.row
            cell.btnAdd.addTarget(self, action: #selector(didTapClickAddRoomIncrease(sender:)), for: .touchUpInside)
            cell.btnRemoveRoom.addTarget(self, action: #selector(didTapClickRemoveRoom(sender:)), for: .touchUpInside)
            if arrAddRoom.count >= 2{
                cell.btnRemoveRoom.isHidden = false
            }else{
                cell.btnRemoveRoom.isHidden = true
            }
            return cell
        }
            
    }
}
