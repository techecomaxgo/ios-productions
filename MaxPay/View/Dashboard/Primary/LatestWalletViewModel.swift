//
//  LatestWalletViewModel.swift
//  MaxPay
//
//  Created by Admin on 01/09/24.
//

import Foundation



class LatestWalletViewModel {
    var responseMessage: String?
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
    
   var transactions: [LatestWalletResponse.data] = []
    var transaction: [Transaction] = []
    var onTransactionsFetched: (() -> Void)?
    var onTransactionNotFound: (() -> Void)?
  
    
   
   // func fetchLatestWalletTransaction(skey: String) {
    func fetchLatestWalletTransaction(skey: String) {
        guard let url = URL(string: "https://uat.maxupi.in/api/v1/wallet/p-latest-wallet") else {
            onError?("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIyIiwicGhvbmUiOiI4MDc2Mzk2MjY3IiwidWlkIjoiYTFkYWZiZDYtZTA2ZC00ZmE0LWE5NzktOWRlMmFhMzI1ZGI5IiwiaWF0IjoxNzI1MjU3OTg5LCJleHAiOjE3MzMwMzM5ODl9.XGFhoKFB7Zy_uN_EUqwRDaRI0yXgGo4t5w9ZluUlwS4", forHTTPHeaderField: "Authorization")

        let parameters: [String: Any] = [
            "skey": skey
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
            
            // Print the request body
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request Body: \(jsonString)")
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

            // Print the HTTP response status and headers
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status Code: \(httpResponse.statusCode)")
                print("HTTP Response Headers: \(httpResponse.allHeaderFields)")
            }

            guard let data = data else {
                self.onError?("No data received")
                return
            }
            
            // Print the raw response data
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw Response: \(rawResponse)")
            }

            do {
                let response = try JSONDecoder().decode(LatestWalletResponse.self, from: data)
                if response.status == "failed" {
                    self.onError?(response.message)
                } else {
                    self.responseMessage = response.message
                    self.transactions = response.data // Store the transactions

                    // Extract the date for the startDate and endDate
                    if let latestTransaction = response.data.last {
                        let startDate = latestTransaction.createdAt
                        let endDate = latestTransaction.updatedAt
                        
                        // Now call the fetchTransactions method
                    } else {
                        self.onError?("No transactions found")
                    }
                }
            } catch {
                self.onError?("Failed to decode response")
            }
        }

        task.resume()
    }

    
    
    //-date-range
    func fetchTransactions(skey: String, startDate: String, endDate: String) {
        guard let url = URL(string: "https://uat.maxupi.in/api/v1/wallet/p-by-date-range") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIxIiwicGhvbmUiOiI4ODk2OTU4NDY2IiwidWlkIjoiMzNjZGMyYzgtMTQ5OC00ZjI3LTk5NTQtMDJiYzNmNjEyM2Y2IiwiaWF0IjoxNjk3NzE0NTcwfQ.O2qLtK0APjrkxqkDmJ7rJrxbqGgNojnbS7XUGrQh6ao", forHTTPHeaderField: "Authorization")
        
        let requestBody = [
            "skey": skey,
            "start_date": startDate,
            "end_date": endDate
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
            request.httpBody = jsonData
            
            // Print the request body
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request Body: \(jsonString)")
            }
            
        } catch {
            DispatchQueue.main.async {
                self.onError?("Failed to encode request body")
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.onError?("Failed to fetch transactions: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.onError?("No data received from server")
                }
                return
            }
            
            // Print the HTTP response status and headers
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status Code: \(httpResponse.statusCode)")
                print("HTTP Response Headers: \(httpResponse.allHeaderFields)")
            }
            
            // Print the raw response data
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw Response: \(rawResponse)")
            }
          //  LatestWalletResponse
            do {
                let response = try JSONDecoder().decode(LatestWalletResponse.self, from: data)
                if response.status == "success" {
                    self?.transactions = response.data
                    DispatchQueue.main.async {
                        self?.onTransactionsFetched?()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.onError?(response.message)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self?.onError?("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }

    
    
    //by-date
    
    func fetchTransactions(skey: String, date: String) {
        guard let url = URL(string: "https://uat.maxupi.in/api/v1/wallet/p-by-date") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIxIiwicGhvbmUiOiI4ODk2OTU4NDY2IiwidWlkIjoiMzNjZGMyYzgtMTQ5OC00ZjI3LTk5NTQtMDJiYzNmNjEyM2Y2IiwiaWF0IjoxNjk3NzE0NTcwfQ.O2qLtK0APjrkxqkDmJ7rJrxbqGgNojnbS7XUGrQh6ao", forHTTPHeaderField: "Authorization")
        
        let requestBody = [
            "skey": skey,
            "date": date
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
            request.httpBody = jsonData
            
            // Print the request body
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request Body: \(jsonString)")
            }
            
        } catch {
            DispatchQueue.main.async {
                self.onError?("Failed to encode request body")
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.onError?("Failed to fetch transactions: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.onError?("No data received from server")
                }
                return
            }
            
            // Print the HTTP response status and headers
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status Code: \(httpResponse.statusCode)")
                print("HTTP Response Headers: \(httpResponse.allHeaderFields)")
            }
            
            // Print the raw response data
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw Response: \(rawResponse)")
            }
            
            do {
                let response = try JSONDecoder().decode(LatestWalletResponse.self, from: data)
                if response.status == "success" {
                    self?.transactions = response.data
                    DispatchQueue.main.async {
                        self?.onTransactionsFetched?()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.onError?(response.message)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self?.onError?("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }

      
    
    //old-wallet
    func fetchOldWalletTransactions(skey: String) {
        guard let url = URL(string: "https://uat.maxupi.in/api/v1/wallet/p-old-wallet") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIxIiwicGhvbmUiOiI4ODk2OTU4NDY2IiwidWlkIjoiMzNjZGMyYzgtMTQ5OC00ZjI3LTk5NTQtMDJiYzNmNjEyM2Y2IiwiaWF0IjoxNjk3NzE0NTcwfQ.O2qLtK0APjrkxqkDmJ7rJrxbqGgNojnbS7XUGrQh6ao", forHTTPHeaderField: "Authorization")
        
        let requestBody = [
            "skey": skey
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
            request.httpBody = jsonData
            
            // Print the request body
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request Body: \(jsonString)")
            }
            
        } catch {
            self.onError?("Failed to encode request body")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.onError?("Failed to fetch transactions: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.onError?("No data received from server")
                }
                return
            }
            
            // Print the HTTP response status and headers
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status Code: \(httpResponse.statusCode)")
                print("HTTP Response Headers: \(httpResponse.allHeaderFields)")
            }
            
            // Print the raw response data
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw Response: \(rawResponse)")
            }
            
            do {
                let response = try JSONDecoder().decode(LatestWalletResponse.self, from: data)
                if response.status == "success" {
                    DispatchQueue.main.async {
                        self?.onSuccess?()
                    }
                } else if response.status == "failed" && response.message == "Transaction Not Found" {
                    DispatchQueue.main.async {
                        self?.onTransactionNotFound?()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.onError?(response.message)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self?.onError?("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }

    
    
}

