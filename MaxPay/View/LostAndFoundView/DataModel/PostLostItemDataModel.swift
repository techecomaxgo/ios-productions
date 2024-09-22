//
//  PostLostItemDataModel.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 27/05/24.
//

import Foundation

struct PostLostItemDataModel: Codable {
    let status: String?
    let message: String?
    let data: PostLostItem?
    
    // MARK: - Itemm
    struct PostLostItem: Codable {
        let id: String?
        let user_id: String?
        let category: String?
        let item_name: String?
        let city: String?
        let lost_date_time: String?
        let description: String?
        let location: String?
        let status: String?
        let image_url: [String]?
        let other_info: String?
        let createdAt: String?
        let updatedAt: String?
    }

}
