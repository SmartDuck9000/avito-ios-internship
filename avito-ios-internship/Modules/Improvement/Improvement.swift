//
//  Improvement.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import Foundation

struct ImprovementIcon: Codable {
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "52x52"
    }
}

class Improvement: Codable {
    var id: String
    var title: String
    var description: String?
    var icon: ImprovementIcon
    var price: String
    var isSelected: Bool
}

struct AdvertismentImprovement: Codable {
    var title: String
    var actionTitle: String
    var selectedActionTitle: String
    var improvements: [Improvement]
    
    enum CodingKeys: String, CodingKey {
        case title
        case actionTitle
        case selectedActionTitle
        case improvements = "list"
    }
}

struct StatusData: Codable {
    var status: String
    var result: AdvertismentImprovement
}
