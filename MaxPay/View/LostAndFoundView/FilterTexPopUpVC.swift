//
//  FilterTexPopUpVC.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 26/05/24.
//

import UIKit

class FilterTexPopUpVC: UIViewController {
    @IBOutlet weak var txtFilter: UITextField!
    @IBOutlet weak var lblFilterType: UILabel!
    @IBOutlet var btnSubmit: UIButton!

    var parentVC:LostAndFoundViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tittle2 = NSAttributedString(string: "Submit", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark2) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 16.0)!])
        btnSubmit.setAttributedTitle(tittle2, for: .normal)
    }
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        parentVC?.filterSubmit(filterText: txtFilter.text ?? "")
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
