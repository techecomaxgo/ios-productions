//
//  FilterDatePopUpVC.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 26/05/24.
//

import UIKit

class FilterDatePopUpVC: UIViewController {
    
    @IBOutlet weak var txtFilter: UITextField!
    @IBOutlet weak var dpDateTime: UIDatePicker!
    @IBOutlet var btnSubmit: UIButton!

    var parentVC:LostAndFoundViewController?
    
    let date = Date()
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       showDatePickerFrom()
        let tittle2 = NSAttributedString(string: "Submit", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark2) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 16.0)!])
        btnSubmit.setAttributedTitle(tittle2, for: .normal)
    }
    
    func showDatePickerFrom(){
        dpDateTime.datePickerMode = .dateAndTime
        formatter.dateFormat = isoDateFormat
        let result = formatter.string(from: date)
        let dateToday = formatter.date(from: result)
        dpDateTime.maximumDate = dateToday
        txtFilter.inputView = dpDateTime
        txtFilter.text = formatter.string(from: dpDateTime.date)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        txtFilter.text = formatter.string(from: sender.date)
        view.endEditing(true)
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        parentVC?.filterDateSubmit(filterText: txtFilter.text ?? "")
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
