//
//  NotificationListModel.swift
//  MaxPay
//
//  Created by Ios Developer on 25/01/24.
//

import Foundation

struct NotificationListModel : Codable {
    
    var page               : Int?             = nil
    var totalNotifications : Int?             = nil
    var totalPages         : Int?             = nil
    var notifications      : [Notifications]? = []
    
    enum CodingKeys: String, CodingKey {
        
        case page               = "page"
        case totalNotifications = "totalNotifications"
        case totalPages         = "totalPages"
        case notifications      = "notifications"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        page               = try values.decodeIfPresent(Int.self             , forKey: .page               )
        totalNotifications = try values.decodeIfPresent(Int.self             , forKey: .totalNotifications )
        totalPages         = try values.decodeIfPresent(Int.self             , forKey: .totalPages         )
        notifications      = try values.decodeIfPresent([Notifications].self , forKey: .notifications      )
        
    }
    
    init() {
        
    }
    
}

struct Notifications: Codable {
    
    var id        : Int?    = nil
    var userId    : String? = nil
    var userPhone : String? = nil
    var tokenId   : String? = nil
    var title     : String? = nil
    var message   : String? = nil
    var isSent    : Bool?   = nil
    var sentAt    : String? = nil
    var createdAt : String? = nil
    var updatedAt : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case id        = "id"
        case userId    = "user_id"
        case userPhone = "user_phone"
        case tokenId   = "token_id"
        case title     = "title"
        case message   = "message"
        case isSent    = "isSent"
        case sentAt    = "sentAt"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id        = try values.decodeIfPresent(Int.self    , forKey: .id        )
        userId    = try values.decodeIfPresent(String.self , forKey: .userId    )
        userPhone = try values.decodeIfPresent(String.self , forKey: .userPhone )
        tokenId   = try values.decodeIfPresent(String.self , forKey: .tokenId   )
        title     = try values.decodeIfPresent(String.self , forKey: .title     )
        message   = try values.decodeIfPresent(String.self , forKey: .message   )
        isSent    = try values.decodeIfPresent(Bool.self   , forKey: .isSent    )
        sentAt    = try values.decodeIfPresent(String.self , forKey: .sentAt    )
        createdAt = try values.decodeIfPresent(String.self , forKey: .createdAt )
        updatedAt = try values.decodeIfPresent(String.self , forKey: .updatedAt )
        
    }
    
    init() {
        
    }
    
}

