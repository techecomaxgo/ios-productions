//
//  UPIFeature.swift
//  MaxPay
//
//  Created by Admin on 24/06/24.
//

import Foundation
import UIKit

//UPIFeature

enum UPIFeature {
    
    case deactive
    case addPriv
    
    
    var image: UIImage? {
        switch self {
        case .deactive:
            return .init(named: "deactivePhone")
        case .addPriv:
            return .init(named: "addpriv")
        
        }
    }
    
    var title: String {
        switch self {
        case .deactive:
            return "Deactivate mobile number"
        case .addPriv:
            return "Add a private UPI number"
        
        }
    }
}

