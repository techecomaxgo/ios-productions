//
//  OliveClass.swift
//  MaxPay
//
//  Created by Admin on 25/01/25.
//

import Foundation
import OlivePayLibrary

class OliveApiCall{
    func checkBalance(string: String) async throws -> Any? {
        
        OliveUpiManager.fetchMyAccounts { data, error in
            
            if let err = error {
                
                if err.code == 102 { // VPA not allowed for this customer
                    
                } else if err.code == 401 || err.code == 107 {
                    
                    return
                }
                
                
            } else {
                
                return data as! ()
            }
        } as AnyObject
    }
}
