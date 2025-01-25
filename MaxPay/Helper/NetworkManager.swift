//
//  NetworkManager.swift
//  MaxPay
//
//  Created by Ios Developer on 08/02/24.
//

import Foundation

class NetworkManager {
        
    static let shared = NetworkManager() // Singleton instance
    
    private init() {} // Private initializer to prevent external initialization
    
    // Example function to fetch OTP from the server
    func fetchOTP(completion: @escaping (String) -> Void) {
        // Simulate network request delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            // Assume you receive OTP as a string from the server
//            let otp = "123456"
            
            // Call the completion handler with the received OTP
//            completion(otp)
        }
    }
    
    
    
    /// Performs a GET request
    /// - Parameters:
    ///   - url: The URL to send the request to
    ///   - completion: A completion handler with the result as either data or an error
    func getRequest(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusError = NSError(domain: "NetworkError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])
                completion(.failure(statusError))
                return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                let noDataError = NSError(domain: "NetworkError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(noDataError))
            }
        }
        task.resume()
    }
    
    /// Performs a POST request
    /// - Parameters:
    ///   - url: The URL to send the request to
    ///   - body: A dictionary containing the POST parameters
    ///   - completion: A completion handler with the result as either data or an error
    func postRequest(to url: URL, body: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusError = NSError(domain: "NetworkError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])
                completion(.failure(statusError))
                return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                let noDataError = NSError(domain: "NetworkError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(noDataError))
            }
        }
        task.resume()
    }
    
    
    
    
    
}
