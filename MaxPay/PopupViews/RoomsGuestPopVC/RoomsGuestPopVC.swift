//
//  RoomsGuestPopVC.swift
//  MaxPay
//
//  Created by Admin on 04/06/24.
//
protocol popRoomsSelectedDelegate {
    
    func popRoomsSelected(totalRooms:Int,totalAdults:Int,totalChildren:Int)
    
}



import UIKit

class RoomsGuestPopVC: UIViewController {
    
    
    var delegatePopupRoomsSelected : popRoomsSelectedDelegate?
    
    
    var totalRoomsStr = 0
    var totalAdultsStr = 0
    var totalChildrenStr = 0
    
    
    @IBOutlet weak var roomGuestCount: UILabel!
    
    @IBOutlet var bgView_ctrl: UIView!
    
    @IBOutlet weak var popView_Ctrl: UIView!
    
    
    @IBOutlet weak var tableRoomView: UITableView!
    
    
    @IBOutlet weak var addRoomButton: UIButton!
    @IBOutlet weak var removeRoomButton: UIButton!

    
    var rooms: [Room] = [Room(adults: 2, children: 0, childrenAges: [0])]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.bgView_ctrl.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        popView_Ctrl.layer.cornerRadius = 25
        popView_Ctrl.layer.borderWidth = 1.0
        popView_Ctrl.layer.borderColor = UIColor.white.cgColor
        popView_Ctrl.clipsToBounds = true

        // Add tap gesture recognizer to the background view
             let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        bgView_ctrl.addGestureRecognizer(tapGestureRecognizer)
        
        updateTotalCounts()

        
        
        
    }
    
    
    
    
    @IBAction func addRoom(_ sender: UIButton) {
        addNewRoom()
        
        
        updateTotalCounts()

    }

    @IBAction func removeRoom(_ sender: UIButton) {
        removeLastRoom()
        updateTotalCounts()

    }
    
    
    func addNewRoom() {
        
        rooms.append(Room(adults: 2, children: 0, childrenAges: []))
        
        tableRoomView.insertRows(at: [IndexPath(row: rooms.count - 1, section: 0)], with: .automatic)
        

        
    }

        func removeLastRoom() {
            
            guard !rooms.isEmpty else { return }
            rooms.removeLast()
            tableRoomView.deleteRows(at: [IndexPath(row: rooms.count, section: 0)], with: .automatic)
            
        }
    
    
    
    
    @objc func dismissPopup() {
            // Dismiss the popup and background view
           removeAnimate()
        }
    
    
    
    
    func showAnimate()
        
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations:
            {
                self.view.alpha = 1.0
                self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
        
    {
        UIView.animate(withDuration: 0.0, animations:
            {
                self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }

    
    @IBAction func btnDoneClicked(_ sender: UIButton) {
        
        print(rooms)
        
        delegatePopupRoomsSelected?.popRoomsSelected(totalRooms: totalRoomsStr, totalAdults: totalAdultsStr, totalChildren: totalChildrenStr)
        
        removeAnimate()
        
        
        
        
    }
    
    
    
    func updateTotalCounts() {
        
        let totalRooms = rooms.count
        let totalAdults = rooms.reduce(0) { $0 + $1.adults }
        let totalChildren = rooms.reduce(0) { $0 + $1.children }

        totalRoomsStr = totalRooms
        totalAdultsStr = totalAdults
        totalChildrenStr = totalChildren
        
        roomGuestCount.text = "Room & Guest : Rooms: \(totalRooms), Adults: \(totalAdults), Children: \(totalChildren)"
        
        
    }

    
    
    
    
    @objc func incrementAdult(sender: UIButton) {
        
        let rowIndex = sender.tag
        //rooms[rowIndex].room += 1
        rooms[rowIndex].adults += 1
        tableRoomView.reloadRows(at: [IndexPath(row: rowIndex, section: 0)], with: .none)
        
        updateTotalCounts()

    }

    @objc func decrementAdult(sender: UIButton) {
        let rowIndex = sender.tag
        if rooms[rowIndex].adults > 0 {
            rooms[rowIndex].adults -= 1
            tableRoomView.reloadRows(at: [IndexPath(row: rowIndex, section: 0)], with: .none)
            updateTotalCounts()
        }
    }

    @objc func incrementChild(sender: UIButton) {
        let rowIndex = sender.tag
        rooms[rowIndex].children += 1
        tableRoomView.reloadRows(at: [IndexPath(row: rowIndex, section: 0)], with: .none)
        updateTotalCounts()
    }

    @objc func decrementChild(sender: UIButton) {
        let rowIndex = sender.tag
        if rooms[rowIndex].children > 0 {
            rooms[rowIndex].children -= 1
            tableRoomView.reloadRows(at: [IndexPath(row: rowIndex, section: 0)], with: .none)
            updateTotalCounts()

        }
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


extension RoomsGuestPopVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableRoomView.dequeueReusableCell(withIdentifier: "RoomTableViewCell", for: indexPath) as! RoomTableViewCell
        
        let room = rooms[indexPath.row]
        
        cell.roomCount.text = "Room \(indexPath.row + 1)"
        
        
        cell.adultCountLabel.text = "\(room.adults)"
        cell.childCountLabel.text = "\(room.children)"
        
        // Add target actions for buttons
        cell.incrementAdultButton.tag = indexPath.row
        cell.incrementAdultButton.addTarget(self, action: #selector(incrementAdult), for: .touchUpInside)
        
        cell.decrementAdultButton.tag = indexPath.row
        cell.decrementAdultButton.addTarget(self, action: #selector(decrementAdult), for: .touchUpInside)
        
        cell.incrementChildButton.tag = indexPath.row
        cell.incrementChildButton.addTarget(self, action: #selector(incrementChild), for: .touchUpInside)
        
        cell.decrementChildButton.tag = indexPath.row
        cell.decrementChildButton.addTarget(self, action: #selector(decrementChild), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
