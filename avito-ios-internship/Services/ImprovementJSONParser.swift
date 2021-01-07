//
//  ImprovementJSONParser.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import UIKit

class ImprovementJSONParser: ImprovementParserProtocol {
    func parse(from data: Data) -> AdvertismentImprovement? {
        do {
            let statusData = try JSONDecoder().decode(StatusData.self, from: data)
            if statusData.status == "ok" {
                return statusData.result
            }
        } catch {
            print(error.localizedDescription)
            print(error)
        }
        
        return nil
    }
}
