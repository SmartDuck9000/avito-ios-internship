//
//  ImprovementAssembly.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import UIKit

protocol ImprovementAssemblyProtocol: class {
    func assemble(with: ImprovementViewController)
}

class ImprovementAssembly: ImprovementAssemblyProtocol {
    func assemble(with viewController: ImprovementViewController) {
        let interactor = ImprovementInteractor()
        let router = ImprovementRouter(view: viewController)
        let presenter = ImprovementPresenter(view: viewController)
        presenter.interactor = interactor
        presenter.router = router
        presenter.configureView()
        
        interactor.presenter = presenter
        viewController.presenter = presenter
        viewController.improvementsCollectionView.delegate = viewController
        viewController.improvementsCollectionView.dataSource = viewController
    }
}
