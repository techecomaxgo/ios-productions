//
//  FoundItemListDataModel.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 25/05/24.
//

import Foundation
// MARK: - FoundItemListDataModel

struct FoundItemListDataModel: Codable {
    let status: String?
    let message: String?
    let data: [FoundItem]?
}

// MARK: - Datum
struct FoundItem: Codable {
    let id: String?
    let user_id: String?
    let item_name: String?
    let category: String?
    let city: String?
    let found_date_time: String?
    let description: String?
    let location: String?
    let status: String?
    let image_url: [String]?
    let other_info: String?
    let createdAt: String?
    let updatedAt: String?
}

