//
//  Receipt.swift
//  WannaEat
//
//  Created by 18579118 on 25.09.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

typealias Receipts = [Receipt]

struct Receipt: Codable {
    let title, receiptDescription, image, videoUlr: String
    let creator, category, productList: Int
    let cookingSteps: String

    enum CodingKeys: String, CodingKey {
        case title
        case receiptDescription = "description"
        case image
        case videoUlr = "video_ulr"
        case creator, category
        case productList = "product_list"
        case cookingSteps = "cooking_steps"
    }
}
