//
//  FileLoader.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import UIKit

class FileLoader: LoaderProtocol {
    func load(from source: String, complition: @escaping (_ data: Data?) -> Void) {
        if let url = Bundle.main.url(forResource: source, withExtension: "json") {
            do {
                let resData = try Data(contentsOf: url)
                complition(resData)
            } catch {
                print(error)
            }
        }
        complition(nil)
    }
}
