//
//  ImprovementAssembly.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import UIKit

protocol ImprovementAssemblyProtocol: class {
    func createModule(with: ImprovementViewController)
}

class ImprovementAssembly: ImprovementAssemblyProtocol {
    func createModule(with viewController: ImprovementViewController) {
        let router = ImprovementRouter(view: viewController)
        let presenter = ImprovementPresenter(view: viewController)
        let interactor = ImprovementInteractor(presenter: presenter)
        
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.improvementsLoader = FileLoader()
        interactor.imageLoader = ImageLoader()
        interactor.parser = ImprovementJSONParser()
        
        viewController.presenter = presenter
        viewController.improvementsCollectionView.delegate = viewController
        viewController.improvementsCollectionView.dataSource = viewController
        
        interactor.loadData()
        presenter.configureView()
    }
}
