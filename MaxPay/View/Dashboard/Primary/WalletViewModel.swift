//
//  WalletViewModel.swift
//  MaxPay
//
//  Created by Admin on 01/09/24.
//


//
//import Foundation
//
//class CardDetailsViewModel {
//    var cardDetails: CardDetailsMessage?
//    var onError: ((String) -> Void)?
//    var onSuccess: (() -> Void)?
//
//    func fetchCardDetails(skey: String) {
//        guard let url = URL(string: "https://uat.maxupi.in/api/v1/wallet/get-card-details") else {
//            onError?("Invalid URL")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIyIiwicGhvbmUiOiI4MDc2Mzk2MjY3IiwidWlkIjoiYTFkYWZiZDYtZTA2ZC00ZmE0LWE5NzktOWRlMmFhMzI1ZGI5IiwiaWF0IjoxNzI1MjU3OTg5LCJleHAiOjE3MzMwMzM5ODl9.XGFhoKFB7Zy_uN_EUqwRDaRI0yXgGo4t5w9ZluUlwS4", forHTTPHeaderField: "Authorization")
//
//        let parameters: [String: Any] = [
//            "skey": skey
//        ]
//
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//            request.httpBody = jsonData
//        } catch {
//            onError?("Invalid parameters")
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//            guard let self = self else { return }
//
//            if let error = error {
//                self.onError?(error.localizedDescription)
//                return
//            }
//
//            guard let data = data else {
//                self.onError?("No data received")
//                return
//            }
//
//            // Print the raw response data as a string
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("Response: \(responseString)")
//            }
//
//            do {
//                let response = try JSONDecoder().decode(CardDetailsResponse.self, from: data)
//                if response.status.lowercased() == "success" { // Adjust the status comparison as needed
//                    self.cardDetails = response.message
//                    self.onSuccess?()
//                } else {
//                    self.onError?("Failed to fetch card details: Invalid status")
//                }
//            } catch {
//                self.onError?("Failed to decode response")
//            }
//        }
//
//        task.resume()
//    }
//}



import Foundation

class CardDetailsViewModel {
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    var cardDetails: CardDetailsResponse?

    func fetchCardDetails(skey: String) {
        guard let url = URL(string: "https://uat.maxupi.in/api/v1/wallet/get-card-details") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIyIiwicGhvbmUiOiI4MDc2Mzk2MjY3IiwidWlkIjoiYTFkYWZiZDYtZTA2ZC00ZmE0LWE5NzktOWRlMmFhMzI1ZGI5IiwiaWF0IjoxNzI1MjU3OTg5LCJleHAiOjE3MzMwMzM5ODl9.XGFhoKFB7Zy_uN_EUqwRDaRI0yXgGo4t5w9ZluUlwS4", forHTTPHeaderField: "Authorization")

        let body = ["skey": skey]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.onError?("Network error: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                self.onError?("Invalid response from server")
                return
            }

            if (200...299).contains(httpResponse.statusCode) {
                // Parse successful response
                if let data = data {
//                    do {
//                        let decoder = JSONDecoder()
//                        self.cardDetails = try decoder.decode(CardDetailsResponse.self, from: data)
//                        self.onSuccess?()
//                    } catch {
//                        self.onError?("Failed to decode response: \(error.localizedDescription)")
//                    }
                    
                    
                    
                    
                    do {
                        let decoder = JSONDecoder()
                        self.cardDetails = try decoder.decode(CardDetailsResponse.self, from: data)
                        self.onSuccess?()
                    } catch {
                        print("Decoding Error: \(error.localizedDescription)")
                        self.onError?("Failed to decode response: \(error.localizedDescription)")
                    }

                    
                    
                }
                
                
                
             
                
                
            } else {
                
                
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response Data: \(responseString)")
                }
                
                
                // Log status code and response for debugging
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Failed with status code: \(httpResponse.statusCode)")
                    print("Response: \(responseString)")
                    self.onError?("Failed to fetch card details. Status code: \(httpResponse.statusCode), Response: \(responseString)")
                } else {
                    self.onError?("Failed with status code: \(httpResponse.statusCode)")
                }
            }
        }
        task.resume()
    }
}
