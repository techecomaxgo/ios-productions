//
//  CategoriesDataModel.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 27/05/24.
//

import Foundation
struct CategoriesDataModel: Codable {
    let status: String?
    let message: String?
    let data: [CategoryData]?
}

// MARK: - Itemm
struct CategoryData: Codable {
    let id: String?
    let name: String?
    let image_url: String?
}
