//
//  ImageLoader.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import UIKit

class ImageLoader: LoaderProtocol {
    func load(from source: String, complition: @escaping (_ data: Data?) -> Void) {
        guard let url = URL(string: source) else {
            complition(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
                complition(nil)
            }

            if let data = data {
                complition(data)
            }
        }.resume()
    }
}
