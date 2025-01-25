//
//  WalletDetailsViewModel.swift
//  MaxPay
//
//  Created by Admin on 01/09/24.
//

import Foundation



class WalletDetailsViewModel {
    var onError: ((String) -> Void)?
    var onSuccess: ((String) -> Void)?
    private(set) var balance: String? // Property to store the balance
    
    func fetchWalletDetails(skey: String, phone: String) {
        guard let url = URL(string: "https://api.maxupi.in/api/v1/wallet/swallet/get-swallet-balance") else {
            onError?("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIyIiwicGhvbmUiOiI4MDc2Mzk2MjY3IiwidWlkIjoiYTFkYWZiZDYtZTA2ZC00ZmE0LWE5NzktOWRlMmFhMzI1ZGI5IiwiaWF0IjoxNzI1MjU3OTg5LCJleHAiOjE3MzMwMzM5ODl9.XGFhoKFB7Zy_uN_EUqwRDaRI0yXgGo4t5w9ZluUlwS4", forHTTPHeaderField: "Authorization")

        let parameters: [String: Any] = [
            "skey": skey,
            "phone": phone
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request Body WalletDetailsViewModel ==== : \(jsonString)")
            }
        } catch {
            onError?("Invalid parameters")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                self.onError?(error.localizedDescription)
                return
            }

            guard let data = data else {
                self.onError?("No data received")
                return
            }

            // Print the raw response data as a string
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response WalletDetailsViewModel =======>> : \(responseString)")
            }

            do {
                let response = try JSONDecoder().decode(WalletDetailsResponse.self, from: data)
                if response.status == "success" {
                    self.balance = response.data.balance // Store the balance
                    self.onSuccess?(self.balance ?? "0.0") // Pass balance to the success callback
                } else {
                    self.onError?(response.message)
                }
            } catch {
                self.onError?("Failed to decode response: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}
