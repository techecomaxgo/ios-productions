//
//  ComplaintListModel.swift
//  MaxPay
//
//  Created by Ios Developer on 25/01/24.
//

import Foundation

struct ComplaintListModel : Codable {
    
    var status     : String?     = nil
    var message    : String?     = nil
    var data       : [ComplaintData]?     = []
    var pagination : Pagination? = Pagination()
    
    enum CodingKeys: String, CodingKey {
        
        case status     = "status"
        case message    = "message"
        case data       = "data"
        case pagination = "pagination"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        status     = try values.decodeIfPresent(String.self     , forKey: .status     )
        message    = try values.decodeIfPresent(String.self     , forKey: .message    )
        data       = try values.decodeIfPresent([ComplaintData].self     , forKey: .data       )
        pagination = try values.decodeIfPresent(Pagination.self , forKey: .pagination )
        
    }
    
    init() {
        
    }
    
}

struct ComplaintData: Codable {
    
    var txnId             : String? = nil
    var totalTxnAmt       : Int?    = nil
    var billCategory      : String? = nil
    var billerName        : String? = nil
    var transactionStatus : String? = nil
    var createdAt         : String? = nil
    var transType         : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case txnId             = "txn_id"
        case totalTxnAmt       = "total_txn_amt"
        case billCategory      = "bill_category"
        case billerName        = "biller_name"
        case transactionStatus = "transaction_status"
        case createdAt         = "createdAt"
        case transType         = "trans_type"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        txnId             = try values.decodeIfPresent(String.self , forKey: .txnId             )
        totalTxnAmt       = try values.decodeIfPresent(Int.self    , forKey: .totalTxnAmt       )
        billCategory      = try values.decodeIfPresent(String.self , forKey: .billCategory      )
        billerName        = try values.decodeIfPresent(String.self , forKey: .billerName        )
        transactionStatus = try values.decodeIfPresent(String.self , forKey: .transactionStatus )
        createdAt         = try values.decodeIfPresent(String.self , forKey: .createdAt         )
        transType         = try values.decodeIfPresent(String.self , forKey: .transType         )
        
    }
    
    init() {
        
    }
    
}

struct Pagination: Codable {
    
    var currentPage : Int? = nil
    var pageSize    : Int? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case currentPage = "currentPage"
        case pageSize    = "pageSize"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        currentPage = try values.decodeIfPresent(Int.self , forKey: .currentPage )
        pageSize    = try values.decodeIfPresent(Int.self , forKey: .pageSize    )
        
    }
    
    init() {
        
    }
    
}
