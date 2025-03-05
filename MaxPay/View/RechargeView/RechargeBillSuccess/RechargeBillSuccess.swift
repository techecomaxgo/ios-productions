//
//  RechargeBillSuccess.swift
//  MaxPay
//
//  Created by Ios Developer on 22/05/24.
//

import UIKit
import Foundation

class RechargeBillSuccess: UIViewController {

    @IBOutlet weak var lblAmount: UILabel!
    
    var amountStr = ""
    var transactionData: [String: Any]?
    
    @IBOutlet weak var lblBillersName: UILabel!
    
    @IBOutlet weak var lblrecieverName: UILabel!
    
    @IBOutlet weak var lblConsumerName: UILabel!
    
    
    var consumerName = ""
    
    var receiverName = ""
    
    @IBOutlet weak var viewBannerBack: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeSecureAPICall()
        
        viewBannerBack.layer.applyCornerRadiusShadow()

        
        lblAmount.text = "₹\(amountStr)"
        
        lblBillersName.text = Common.shared.userMobile_NUMBER ?? ""
        
        lblrecieverName.text = receiverName
        
        lblConsumerName.text = consumerName
        
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        
        if let viewControllers = navigationController?.viewControllers {
                   for viewController in viewControllers {
                       if let viewControllerA = viewController as? RechargeViewController {
                           navigationController?.popToViewController(viewControllerA, animated: true)
                           break
                       }
                   }
               }
    }

    func makeSecureAPICall() {
        // Construct URL
        let urlString = "\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.UpiUserTxnStatus)"
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            return
        }

        // Secure Transaction Data
       // let secureTransactionData = (transactionData as? [String: Any]) ?? [:]
        let secureTransactionData = transactionData ?? [:]

        // Prepare Parameters
        let parameters: [String: Any] = [
            "device_id": Common.shared.getDeviceID(),
            "latitude": "123456789",
            "longitude": "77.391029",
            "txnrecord": secureTransactionData
        ]

        // Convert Parameters to JSON Data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            print("Error: Unable to serialize parameters to JSON")
            return
        }

        // Create Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        // Set Secure Headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = Common.shared.token, !token.isEmpty {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            print("Warning: No Authorization token available")
        }

        request.setValue(KSkeyValue, forHTTPHeaderField: KSKEY)

        // Create URLSession Task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle Network Error
            if let error = error {
                print("Network Error: \(error.localizedDescription)")
                return
            }

            // Validate HTTP Response
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Invalid HTTP response")
                return
            }

            if !(200...299).contains(httpResponse.statusCode) {
                print("Server Error: HTTP Status Code \(httpResponse.statusCode)")
                return
            }

            // Parse JSON Response
            guard let data = data else {
                print("Error: No data received from server")
                return
            }

            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                print("Response JSON: \(jsonResponse)")

                guard let jsonDict = jsonResponse as? [String: Any] else {
                    print("Error: JSON response is not in expected dictionary format")
                    return
                }

                let status = jsonDict["status"] as? String ?? "failed"
                let transactionID = jsonDict["transaction_id"] as? String ?? "N/A"
                let message = jsonDict["message"] as? String ?? "No message"

                print("Status: \(status), Transaction ID: \(transactionID), Message: \(message)")

                DispatchQueue.main.async {
                    if status == "success" {
                        print("Transaction Successful")
                        // Handle successful transaction (e.g., UI update, navigation)
                    } else {
                        print("Transaction Failed: \(message)")
                        // Handle failure case (e.g., show error alert)
                    }
                }
            } catch {
                print("JSON Parsing Error: \(error.localizedDescription)")
            }
        }

        // Start Task
        task.resume()
    }

}
