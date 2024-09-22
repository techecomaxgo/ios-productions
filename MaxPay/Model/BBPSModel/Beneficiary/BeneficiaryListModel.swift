//
//  BeneficiaryListModel.swift
//  MaxPay
//
//  Created by Ios Developer on 29/01/24.
//

import Foundation


struct BeneficiaryListModel: Codable {
    
    var input: String?
    var name: String?
    var nickname: String?
    var vpa: String?
    
    enum CodingKeys: CodingKey {
        case input
        case name
        case nickname
        case vpa
    }
}


struct PendingNotificationsListModel: Codable {

    var amount: String?      // = "5.00";
    var beneName: String?        // = "HAKIM MARUFA MOHAMMAD AMIN";
    var expdate: String?         // = "01-02-2024 14:28:05";
    var input: String?       // = "AXI7A948CB31E91490693CD81D9FE7178A2nulltestP917007439651dfgk@axismadhu@axisHAKIM MARUFA MOHAMMAD AMIN5.0001-02-2024 14:28:05403187043896";
    var invoiceurl: String?      // = "http://axisbank.com/upi";
    var merchantflag: String?        // = N;
    var mobile: String?      // = 917007439651;
    var name: String?        // = "<null>";
    var notes: String?       // = test;
    var payeeVpa: String?        // = "madhu@axis";
    var payeecode: String?       // = "<null>";
    var payerVpa: String?        // = "dfgk@axis";
    var purpose: String?         // = 00;
    var refCategory: String?         // = 00;
    var refid: String?       // = 403187043896;
    var status: String?      // = P;
    var txnid: String?       // = AXI7A948CB31E91490693CD81D9FE7178A2;

    enum CodingKeys: CodingKey {
        case amount
        case beneName
        case expdate
        case input
        case invoiceurl
        case merchantflag
        case mobile
        case name
        case notes
        case payeeVpa
        case payeecode
        case payerVpa
        case purpose
        case refCategory
        case refid
        case status
        case txnid
    }
    
}
