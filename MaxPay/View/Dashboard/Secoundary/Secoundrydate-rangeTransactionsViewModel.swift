//
//  Secoundrydate-rangeTransactionsViewModel.swift
//  MaxPay
//
//  Created by Admin on 04/09/24.
//

import Foundation

import Foundation

class TransactionsViewModel {
    var transactions: [Transaction] = []
    var onUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    func fetchTransactions(skey: String, startDate: String, endDate: String) {
        let urlString = "https://uat.maxupi.in/api/v1/wallet/s-by-date-range"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIyIiwicGhvbmUiOiI4MDc2Mzk2MjY3IiwidWlkIjoiYTFkYWZiZDYtZTA2ZC00ZmE0LWE5NzktOWRlMmFhMzI1ZGI5IiwiaWF0IjoxNzI1MjU3OTg5LCJleHAiOjE3MzMwMzM5ODl9.XGFhoKFB7Zy_uN_EUqwRDaRI0yXgGo4t5w9ZluUlwS4", forHTTPHeaderField: "Authorization")

        
        let parameters: [String: Any] = [
            "skey": skey,
            "start_date": startDate,
            "end_date": endDate
        ]

        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error: \(error.localizedDescription)")
                    self?.onError?(error)
                }
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Print the raw response data
            print("Response Data: \(String(data: data, encoding: .utf8) ?? "No data")")
            
            do {
                let transactionResponse = try JSONDecoder().decode(TransactionsResponse.self, from: data)
                self?.transactions = transactionResponse.data
                
                DispatchQueue.main.async {
                    self?.onUpdate?()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Decoding Error: \(error.localizedDescription)")
                    self?.onError?(error)
                }
            }
        }
        
        task.resume()
    }
    
    
    
    

    func fetchTransactionsByDate(skey: String, date: String) {
        let urlString = "https://uat.maxupi.in/api/v1/wallet/s-by-date"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIyIiwicGhvbmUiOiI4MDc2Mzk2MjY3IiwidWlkIjoiYTFkYWZiZDYtZTA2ZC00ZmE0LWE5NzktOWRlMmFhMzI1ZGI5IiwiaWF0IjoxNzI1MjU3OTg5LCJleHAiOjE3MzMwMzM5ODl9.XGFhoKFB7Zy_uN_EUqwRDaRI0yXgGo4t5w9ZluUlwS4", forHTTPHeaderField: "Authorization")

        
        let parameters: [String: Any] = [
            "skey": skey,
           "date": date
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error: \(error.localizedDescription)")
                    self?.onError?(error)
                }
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Print HTTP response status code and headers
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                print("HTTP Headers: \(httpResponse.allHeaderFields)")
            }
            
            // Print the raw response data
            print("Response Data: \(String(data: data, encoding: .utf8) ?? "No data")")
            
            do {
                let transactionResponse = try JSONDecoder().decode(TransactionsResponse.self, from: data)
                self?.transactions = transactionResponse.data
                
                DispatchQueue.main.async {
                    self?.onUpdate?()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Decoding Error: \(error.localizedDescription)")
                    self?.onError?(error)
                }
            }
        }
        
        task.resume()
    }


    
    
    
    
    func fetchOldWalletTransactions(skey: String) {
        let urlString = "https://uat.maxupi.in/api/v1/wallet/s-old-wallet"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIyIiwicGhvbmUiOiI4MDc2Mzk2MjY3IiwidWlkIjoiYTFkYWZiZDYtZTA2ZC00ZmE0LWE5NzktOWRlMmFhMzI1ZGI5IiwiaWF0IjoxNzI1MjU3OTg5LCJleHAiOjE3MzMwMzM5ODl9.XGFhoKFB7Zy_uN_EUqwRDaRI0yXgGo4t5w9ZluUlwS4", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "skey": skey
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error: \(error.localizedDescription)")
                    self?.onError?(error)
                }
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Print the raw response data
            print("Response Data: \(String(data: data, encoding: .utf8) ?? "No data")")
            
            do {
                let transactionResponse = try JSONDecoder().decode(TransactionsResponse.self, from: data)
                self?.transactions = transactionResponse.data
                
                DispatchQueue.main.async {
                    self?.onUpdate?()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Decoding Error: \(error.localizedDescription)")
                    self?.onError?(error)
                }
            }
        }
        
        task.resume()
    }

    
}
