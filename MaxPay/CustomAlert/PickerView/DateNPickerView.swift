//
//  DateNPickerView.swift
//  MaxPay
//
//  Created by Admin on 14/06/24.
//

import Foundation
import UIKit

// Define the protocol to handle date selection
protocol DatePickerViewDelegate: AnyObject {
    func datePickerView(_ datePickerView: DateNPickerView, didSelectDate date: Date)
}

class DateNPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: DatePickerViewDelegate?
    
    private let pickerView = UIPickerView()
    private let calendar = Calendar.current
    private var dates: [Date] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupDates()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupDates()
    }
    
    private func setupView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupDates() {
        var date = Date()
        for _ in 0..<365 { // Adding dates for 1 year
            dates.append(date)
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dates.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let date = dates[row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedDate = dates[row]
        delegate?.datePickerView(self, didSelectDate: selectedDate)
    }
}
