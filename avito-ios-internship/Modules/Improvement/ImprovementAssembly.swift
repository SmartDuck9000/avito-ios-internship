//
//  ImprovementAssembly.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import UIKit

protocol ImprovementAssemblyProtocol: class {
    func assemble(with: ImprovementViewProtocol)
}

class ImprovementAssembly: ImprovementAssemblyProtocol {
    func assemble(with viewController: ImprovementViewProtocol) {
        let interactor = ImprovementInteractor()
        let presenter = ImprovementPresenter(view: viewController, interactor: interactor)
        
        interactor.presenter = presenter
        viewController.presenter = presenter
        viewController.improvementsCollectionView.delegate = viewController
        viewController.improvementsCollectionView.dataSource = viewController
    }
}
