//
//  ClaimedItemListDataModel.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 25/05/24.
//

import Foundation
// MARK: - ClaimedItemListDataModel

struct ClaimedItemListDataModel: Codable {
    let status: String?
    let message: String?
    let data: [ClaimedItem]?
}

// MARK: - Datum
struct ClaimedItem: Codable {
    let id: String?
    let found_user_id: String?
    let found_user_phone: String?
    let claim_user_id: String?
    let claim_user_phone: String?
    let found_item_id: String?
    let found_item_name: String?
    let description: String?
    let image_url: [String]?
    let status: String?
    let createdAt: String?
    let updatedAt: String?
}
