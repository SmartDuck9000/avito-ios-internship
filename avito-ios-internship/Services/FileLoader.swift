//
//  FileLoader.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import UIKit

class FileLoader: LoaderProtocol {
    func load(from source: String) -> Data? {
        if let url = Bundle.main.url(forResource: source, withExtension: "json") {
            do {
                let resData = try Data(contentsOf: url)
                return resData
            } catch {
                print(error)
            }
        }
        return nil
    }
}
