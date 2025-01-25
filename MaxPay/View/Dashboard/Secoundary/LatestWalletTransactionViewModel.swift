//
//  LatestWalletTransactionViewModel.swift
//  MaxPay
//
//  Created by Admin on 01/09/24.
//

import Foundation



class LatestWalletTransactionViewModel {
    var responseMessage: String?
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
    
    
    var transactions: [LatestWalletTransactionResponse.data] = []
    var createdAtDates: [String] = []
    var updatedAtDates: [String] = []
    
    var onUpdate: (() -> Void)?
    var onErrors: ((Error) -> Void)?
      

    func fetchLatestWalletTransaction(skey: String) {
          guard let url = URL(string: "https://api.maxupi.in/api/v1/wallet/s-latest-wallet") else {
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
              if let jsonString = String(data: jsonData, encoding: .utf8) {
                  print("Request Body LatestWalletTransactionViewModel ====>> : \(jsonString)")
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
                  print("Response LatestWalletTransactionViewModel =====>> : \(responseString)")
              }

              do {
                  let response = try JSONDecoder().decode(LatestWalletTransactionResponse.self, from: data)
                  if response.status == "failed" {
                      self.onError?(response.message)
                  } else {
                    //  self.latestWalletTransactions = response // Save the response
                      self.transactions = response.data // Update transactions with response data
                      
                      // Extract createdAt and updatedAt values
                      self.createdAtDates = response.data.map { $0.createdAt }
                      self.updatedAtDates = response.data.map { $0.updatedAt }
                      
                      self.onSuccess?()
                  }
              } catch {
                  self.onError?("Failed to decode response")
              }
          }

          task.resume()
      }
    
    
    
    
    
    
    func fetchTransactions(skey: String, startDate: String, endDate: String) {
        let urlString = "https://api.maxupi.in/api/v1/wallet/s-by-date-range"
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
                    self?.onErrors?(error)
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
                let transactionResponse = try JSONDecoder().decode(LatestWalletTransactionResponse.self, from: data)
                self?.transactions = transactionResponse.data
            
                
                DispatchQueue.main.async {
                    self?.onUpdate?()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Decoding Error: \(error.localizedDescription)")
                    self?.onErrors?(error)
                }
            }
        }
        
        task.resume()
    }
    
    
    
    

    func fetchTransactionsByDate(skey: String, date: String) {
        let urlString = "https://api.maxupi.in/api/v1/wallet/s-by-date"
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
                    self?.onErrors?(error)
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
                let transactionResponse = try JSONDecoder().decode(LatestWalletTransactionResponse.self, from: data)
                self?.transactions = transactionResponse.data
                
                DispatchQueue.main.async {
                    self?.onUpdate?()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Decoding Error: \(error.localizedDescription)")
                    self?.onErrors?(error)
                }
            }
        }
        
        task.resume()
    }


    
    
    
    
    func fetchOldWalletTransactions(skey: String) {
        let urlString = "https://api.maxupi.in/api/v1/wallet/s-old-wallet"
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
                    self?.onErrors?(error)
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
                let transactionResponse = try JSONDecoder().decode(LatestWalletTransactionResponse.self, from: data)
                self?.transactions = transactionResponse.data
                
                DispatchQueue.main.async {
                    self?.onUpdate?()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Decoding Error: \(error.localizedDescription)")
                    self?.onErrors?(error)
                }
            }
        }
        
        task.resume()
    }
    
}


//==========

