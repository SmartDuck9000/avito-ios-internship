//
//  ParserProtocol.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import Foundation

protocol ImprovementParserProtocol {
    func parse(from data: Data) -> AdvertismentImprovement?
}
