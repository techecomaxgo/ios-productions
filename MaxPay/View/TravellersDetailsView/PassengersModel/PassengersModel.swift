//
//  PassengersModel.swift
//  MaxPay
//
//  Created by Admin on 07/07/24.
//

import Foundation


import UIKit

class PassengersModel :Equatable{
    
    
    
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var age: String
    var isSelected: Bool = false

    
    
    
    init(firstName: String, lastName: String, email: String, phone: String, age: String) {
       
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.age = age
        

    }
    
    static func == (lhs: PassengersModel, rhs: PassengersModel) -> Bool {
            return lhs.email == rhs.email && lhs.phone == rhs.phone
        }
    
    
}
