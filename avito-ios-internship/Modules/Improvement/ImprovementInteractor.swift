//
//  ImprovementInteractor.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import UIKit

protocol ImprovementInteractorProtocol: class {
    func loadData()
    func loadImage(from source: String, complition: @escaping (_ data: Data?) -> Void)
    func getIconData(at index: Int) -> Data?
    
    func improvementChanged(at index: Int)
    func improvementsCount() -> Int?
    
    func getImprovementTitle(at index: Int) -> String?
    func getImprovementDescription(at index: Int) -> String?
    func getImprovementPrice(at index: Int) -> String?
    func getImprovementIconURL(at index: Int) -> String?
    func isImprovementSelected(at index: Int) -> Bool?
    func isAnyImprovementSelected() -> Bool
    
    func getTitle() -> String?
    func getActionTitle() -> String?
    func getSelectedImprovementTitle() -> String?
    func getSelectedActionTitle() -> String?
}

class ImprovementInteractor: ImprovementInteractorProtocol {
    weak var presenter: ImprovementPresenterProtocol?
    
    private var advertismentImprovement: AdvertismentImprovement?
    private var selectedImprovement: Improvement?
    private var iconData: [String:Data?] = [:]
    
    var improvementsLoader: LoaderProtocol?
    var imageLoader: LoaderProtocol?
    var parser: ImprovementParserProtocol?
    
    init(presenter: ImprovementPresenterProtocol) {
        self.presenter = presenter
    }
    
    func loadData() {
        improvementsLoader?.load(from: "result", complition: { (data) in
            guard let jsonImprovementData = data else { return }
            self.advertismentImprovement = self.parser?.parse(from: jsonImprovementData)
            guard let improvements = self.advertismentImprovement?.improvements else { return }
            self.selectedImprovement = nil
            
            for improvement in improvements {
                self.loadImage(from: improvement.icon.url) { (data) in
                    self.iconData[improvement.id] = data
                }
            }
            
            var selected = improvements.filter({ $0.isSelected })
            if selected.count > 0 {
                self.selectedImprovement = selected.first
                if selected.count > 1 {
                    print("Warning: result.json contains more than one selected improvement!")
                    selected.removeFirst()
                    for improvement in selected {
                        improvement.isSelected = false
                    }
                }
            }
        })
    }
    
    func loadImage(from source: String, complition: @escaping (_ data: Data?) -> Void) {
        imageLoader?.load(from: source, complition: complition)
    }
    
    func getIconData(at index: Int) -> Data? {
        guard let improvementID = advertismentImprovement?.improvements[index].id else { return nil }
        guard let data = iconData[improvementID] else { return nil }
        return data
    }
    
    func improvementChanged(at index: Int) {
        guard let improvement = advertismentImprovement?.improvements[index] else { return }
        
        improvement.isSelected = !improvement.isSelected
        if let currentImprovement = selectedImprovement {
            currentImprovement.isSelected = false
        }
        
        if improvement.isSelected {
            selectedImprovement = improvement
        } else {
            selectedImprovement = nil
        }
    }
    
    func getImprovementTitle(at index: Int) -> String? {
        return advertismentImprovement?.improvements[index].title
    }
    
    func getImprovementDescription(at index: Int) -> String? {
        return advertismentImprovement?.improvements[index].description
    }
    
    func getImprovementPrice(at index: Int) -> String? {
        return advertismentImprovement?.improvements[index].price
    }
    
    func getImprovementIconURL(at index: Int) -> String? {
        return advertismentImprovement?.improvements[index].icon.url
    }
    
    func isImprovementSelected(at index: Int) -> Bool? {
        return advertismentImprovement?.improvements[index].isSelected
    }
    
    func isAnyImprovementSelected() -> Bool {
        return selectedImprovement != nil
    }
    
    func improvementsCount() -> Int? {
        return advertismentImprovement?.improvements.count
    }
    
    func getTitle() -> String? {
        return advertismentImprovement?.title
    }
    
    func getActionTitle() -> String? {
        return advertismentImprovement?.actionTitle
    }
    
    func getSelectedImprovementTitle() -> String? {
        return selectedImprovement?.title
    }
    
    func getSelectedActionTitle() -> String? {
        return advertismentImprovement?.selectedActionTitle
    }
}
