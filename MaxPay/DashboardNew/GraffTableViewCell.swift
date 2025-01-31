//
//  GraffTableViewCell.swift
//  MaxPay
//
//  Created by Admin on 29/01/25.
//

import UIKit

class GraffTableViewCell: UITableViewCell {
   
    @IBOutlet weak var viewGraph: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //donutChartView.translatesAutoresizingMaskIntoConstraints = false
        //self.viewGraph.addSubview(donutChartView)
        // Configure the view for the selected state
    }
    
}
