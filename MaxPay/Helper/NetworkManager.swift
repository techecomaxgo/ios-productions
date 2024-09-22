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
    
    
}
