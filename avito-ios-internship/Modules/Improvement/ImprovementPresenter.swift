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
        guard let selectedActionTitle = self.interactor?.getSelectedActionTitle() else { return }
        
        self.view?.setOfferTitle(title)
        self.view?.setSelectedActionTitle(selectedActionTitle)
    }
    
    func cellForItem(at index: Int, cell: ImprovementCollectionViewCell) {
        guard let title = interactor?.getImprovementTitle(at: index) else { return }
        var description = ""
        if let descr = interactor?.getImprovementDescription(at: index)  {
            description = descr
        }
        guard let price = interactor?.getImprovementPrice(at: index) else { return }
        guard let iconStrURL = interactor?.getImprovementIconURL(at: index) else { return }
        guard let iconURL = URL(string: iconStrURL) else { return }
        guard let isSelected = interactor?.isImprovementSelected(at: index) else { return }
        
        cell.setTitle(title)
        cell.setDescription(description)
        cell.setPrice(price)
        
        if isSelected {
            cell.setSelectedImage(UIImage(named: "checkmark.pdf"))
        } else {
            cell.setSelectedImage(nil)
        }
        
        URLSession.shared.dataTask(with: iconURL) { (data, response, error) in
            var icon: UIImage? = nil
            
            if let err = error {
                print(err.localizedDescription)
            }
            
            if let data = data {
                icon = UIImage(data: data)
            }
            
            DispatchQueue.main.async {
                cell.setIcon(icon)
            }
        }.resume()
    }
    
    func selectItemClicked(at index: Int) {
        interactor?.improvementChanged(at: index)
        guard let offset = view?.improvementsCollectionView.contentOffset else { return }
        view?.improvementsCollectionView.reloadData()
        view?.improvementsCollectionView.layoutIfNeeded()
        view?.improvementsCollectionView.setContentOffset(offset, animated: false)
    }
    
    func numberOfItemsInSection() -> Int {
        if let num = interactor?.improvementsCount() {
            return num
        }
        return 0
    }
    
    func selectButtonClicked() {
        guard let actionTitle = interactor?.getActionTitle() else { return }
        
        var selectedImprovementTitle = "Ничего не выбрано"
        if let title = interactor?.getSelectedImprovementTitle() {
            selectedImprovementTitle = title
        }
        
        router?.showAlert(title: selectedImprovementTitle, actionTitle: actionTitle)
    }
}
