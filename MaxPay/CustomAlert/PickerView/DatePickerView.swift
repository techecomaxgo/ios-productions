//
//  DatePickerView.swift

import UIKit

@objc protocol DatePickerDelegate {
    
    func selectedDate(selectedDate:Date)
    

}


class DatePickerView: UIView,UIPickerViewDelegate {
    

    private let calendar = Calendar.current
        private var dates: [Date] = []

    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    var delegate:DatePickerDelegate?
    @IBOutlet weak var dtPicker:UIDatePicker?
    //var selectedDate = Date()

    
  
    
    
    
    private func setupView() {
        

    }
    
    func ReloadDatePickerView() {
      
        dtPicker?.locale =  NSLocale.init(localeIdentifier: "en") as Locale
        
        dtPicker?.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)


        

    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("\(day) \(month) \(year)")
        }
    }
    
    
    
    @IBAction func barBtnAction(sender:UIBarButtonItem) {
        dtPicker?.locale = Locale(identifier: "en")
        if sender.tag == 1 {
            print(dtPicker?.date)
            delegate?.selectedDate(selectedDate: dtPicker!.date)
        }
        
        MyBasics.hideDatePickerView()
        
    }
    
   
    
    
    
}
