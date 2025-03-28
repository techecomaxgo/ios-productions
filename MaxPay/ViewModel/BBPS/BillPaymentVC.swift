//
//  BillPaymentVC.swift
//  MaxPay
//
//  Created by india on 20/03/25.
//

import UIKit

class BillPaymentVC: UIViewController {

    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    struct TableViewValues {
        let title: String
        let desc: String
    }
    
    private var values: [TableViewValues] = []
    
    var providedData: FetchBillResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        amountTextfield.isEnabled = providedData?.paymentAmountExactness != "EXACT"
        amountTextfield.text = "\(providedData?.payload.amount ?? 0)"
        
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        setupValues()
    }
    
    private func setupValues() {
        if let providedData {
            values.append(.init(title: "Customer Name", desc: providedData.payload.accountHolderName ?? ""))
            if let billNumber = providedData.payload.billNumber { values.append(.init(title: "Bill Number", desc: billNumber)) }
            if let billerID = providedData.payload.billerId { values.append(.init(title: "Biller ID", desc: billerID)) }
            if let balance = providedData.payload.additionalParams.availableBalance { values.append(.init(title: "Available Balance", desc: balance)) }
            if let limit = providedData.payload.additionalParams.availableRechargeLimit { values.append(.init(title: "Available Recharge Limit", desc: limit)) }
            if let status = providedData.payload.additionalParams.status { values.append(.init(title: "Status", desc: status)) }
            if let tagID = providedData.payload.additionalParams.tagId { values.append(.init(title: "Tag ID", desc: tagID)) }
            if let vehicleClass = providedData.payload.additionalParams.vehicleClass { values.append(.init(title: "Vehicle Class", desc: vehicleClass)) }
            if let vehicleClassDesc = providedData.payload.additionalParams.vehicleClassDesc { values.append(.init(title: "Vehicle Type", desc: vehicleClassDesc)) }
            if let currentOutstanding = providedData.payload.additionalParams.currentOutstanding { values.append(.init(title: "Current Outstanding Amount", desc: currentOutstanding)) }
            if let minimumOutstanding = providedData.payload.additionalParams.minimumOutstanding { values.append(.init(title: "Minimum Amount Due", desc: minimumOutstanding)) }
        }
        tableView.reloadData()
    }
    
    
    @objc private func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension BillPaymentVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { values.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let value = values[indexPath.row]
        let titleLabel = cell.viewWithTag(1) as? UILabel
        let descLabel = cell.viewWithTag(2) as? UILabel
        titleLabel?.text = value.title
        descLabel?.text = value.desc
        return cell
    }
    
}
