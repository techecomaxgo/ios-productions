//
//  BusFIlterVC.swift
//  MaxPay
//
//  Created by Ios Developer on 02/02/24.
//

import UIKit
import DatePicker

class BusFIlterVC: UIViewController {

    @IBOutlet weak var btnLast7Days: UIButton!
    @IBOutlet weak var btnLast30Days: UIButton!
    
    @IBOutlet weak var btnPaymentSourceBank1: UIButton!
    @IBOutlet weak var btnPaymentSourceBank2: UIButton!
    @IBOutlet weak var btnPaymentSourceWallet: UIButton!
    
    @IBOutlet weak var btnStatusSuccess: UIButton!
    @IBOutlet weak var btnStatusPending: UIButton!
    @IBOutlet weak var btnStatusFailed: UIButton!
    
    @IBOutlet weak var btnTypePaid: UIButton!
    @IBOutlet weak var btnTypeReceived: UIButton!
    @IBOutlet weak var btnTypeAdded: UIButton!
    @IBOutlet weak var btnTypeTransfer: UIButton!
    
    @IBOutlet weak var btnFilterDateFrom: DesignableButton!
    @IBOutlet weak var btnFilterDateTo: DesignableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    
    
    
    @IBAction func btnClearAllFilter(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btnApplyFilter(_ sender: Any) {
        dismiss(animated: true)
        
        print(btnFilterDateFrom.titleLabel?.text)
        print(btnFilterDateTo.titleLabel?.text)
    }
    
    @IBAction func btnDateFrom(_ sender: UIButton) {
        let minDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2021)!
        let maxDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2024)!
        let today = Date()
        
        let datePicker = DatePicker()
        
        datePicker.setup(beginWith: today, min: minDate, max: maxDate) { (selected, date) in
            if selected, let selectedDate = date {
                print(selectedDate.string())
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                self.btnFilterDateFrom.setTitle("\(formatter.string(from: selectedDate))", for: .normal)
            } else {
                print("Cancelled")
            }
        }
        // Display
        datePicker.show(in: self, on: sender)
    }
    
    @IBAction func btnToFrom(_ sender: UIButton) {
        let minDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2021)!
        let maxDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2024)!
        let today = Date()
        
        let datePicker = DatePicker()
        
        datePicker.setup(beginWith: today, min: minDate, max: maxDate) { (selected, date) in
            if selected, let selectedDate = date {
                print(selectedDate.string())
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                self.btnFilterDateTo.setTitle("\(formatter.string(from: selectedDate))", for: .normal)
            } else {
                print("Cancelled")
            }
        }
        // Display
        datePicker.show(in: self, on: sender)
    }
    
}
