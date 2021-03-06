//
//  ImprovementRouter.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import UIKit

protocol ImprovementRouterProtocol {
    var view: ImprovementViewController { get set }
    func showAlert(title: String, actionTitle: String)
}

class ImprovementRouter: ImprovementRouterProtocol {
    var view: ImprovementViewController
    
    init(view: ImprovementViewController) {
        self.view = view
    }
    
    func showAlert(title: String, actionTitle: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        view.present(alertController, animated: true)
    }
}
