//
//  RoomTableViewCell.swift
//  MaxPay
//
//  Created by Admin on 04/06/24.
//


protocol RoomCellDelegate: AnyObject {
    func updateRoom(at index: Int, room: Room)
}


import UIKit

class RoomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var adultCountLabel: UILabel!
    @IBOutlet weak var childCountLabel: UILabel!
    @IBOutlet weak var incrementAdultButton: UIButton!
    @IBOutlet weak var decrementAdultButton: UIButton!
    @IBOutlet weak var incrementChildButton: UIButton!
    @IBOutlet weak var decrementChildButton: UIButton!

    @IBOutlet weak var roomCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
