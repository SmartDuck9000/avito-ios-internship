//
//  ImprovementPresenter.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import UIKit

protocol ImprovementPresenterProtocol: class {
    func cellForItem(at index: Int, cell: ImprovementCollectionViewCell)
    func selectItemClicked(at index: Int)
    func reloadActionTitle()
    func numberOfItemsInSection() -> Int
    func selectButtonClicked()
}

class ImprovementPresenter: ImprovementPresenterProtocol {
    weak var view: ImprovementViewController?
    var interactor: ImprovementInteractorProtocol?
    var router: ImprovementRouterProtocol?
    
    init(view: ImprovementViewController) {
        self.view = view
    }
    
    func configureView() {
        guard let title = self.interactor?.getTitle() else { return }
        self.view?.setOfferTitle(title)
        reloadActionTitle()
    }
    
    func cellForItem(at index: Int, cell: ImprovementCollectionViewCell) {
        guard let title = interactor?.getImprovementTitle(at: index) else { return }
        var description = ""
        if let descr = interactor?.getImprovementDescription(at: index)  {
            description = descr
        }
        guard let price = interactor?.getImprovementPrice(at: index) else { return }
        guard let iconStrURL = interactor?.getImprovementIconURL(at: index) else { return }
        guard let isSelected = interactor?.isImprovementSelected(at: index) else { return }
        
        cell.setTitle(title)
        cell.setDescription(description)
        cell.setPrice(price)
        cell.setSelectedImage(UIImage(named: "checkmark.pdf"))
        cell.setHiddenSelectImage(!isSelected)
        
        interactor?.loadImage(from: iconStrURL, complition: { (data) in
            let iconImage: UIImage?
            if let imageData = data {
                iconImage = UIImage(data: imageData)
            } else {
                iconImage = nil
            }
            
            DispatchQueue.main.async {
                cell.setIcon(iconImage)
            }
        })
    }
    
    func selectItemClicked(at index: Int) {
        interactor?.improvementChanged(at: index)
        reloadActionTitle()
        guard let offset = view?.improvementsCollectionView.contentOffset else { return }
        view?.improvementsCollectionView.reloadData()
        view?.improvementsCollectionView.layoutIfNeeded()
        view?.improvementsCollectionView.setContentOffset(offset, animated: false)
    }
    
    func reloadActionTitle() {
        guard let interactor = interactor else { return }
        let selectButtonTitle: String
        
        if interactor.isAnyImprovementSelected() {
            guard let title = interactor.getSelectedActionTitle() else { return }
            selectButtonTitle = title
        } else {
            guard let title = interactor.getActionTitle() else { return }
            selectButtonTitle = title
        }
        
        self.view?.setSelectButtonTitle(selectButtonTitle)
    }
    
    func numberOfItemsInSection() -> Int {
        if let num = interactor?.improvementsCount() {
            return num
        }
        return 0
    }
    
    func selectButtonClicked() {
        var selectedImprovementTitle = "Ничего не выбрано"
        if let title = interactor?.getSelectedImprovementTitle() {
            selectedImprovementTitle = title
        }
        
        router?.showAlert(title: selectedImprovementTitle, actionTitle: "OK")
    }
}
