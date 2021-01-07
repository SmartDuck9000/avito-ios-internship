//
//  LoaderProtocol.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import Foundation

protocol LoaderProtocol {
    func load(from source: String, complition: @escaping (_ data: Data?) -> Void)
}
