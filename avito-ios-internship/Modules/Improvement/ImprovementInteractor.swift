//
//  ImprovementInteractor.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import UIKit

protocol ImprovementInteractorProtocol: class {
    func improvementChanged(at index: Int)
    func improvementsCount() -> Int?
    
    func getImprovementTitle(at index: Int) -> String?
    func getImprovementDescription(at index: Int) -> String?
    func getImprovementPrice(at index: Int) -> String?
    func getImprovementIconURL(at index: Int) -> String?
    func isImprovementSelected(at index: Int) -> Bool?
    
    func getTitle() -> String?
    func getActionTitle() -> String?
    func getSelectedImprovementTitle() -> String?
    func getSelectedActionTitle() -> String?
}

class ImprovementInteractor: ImprovementInteractorProtocol {
    weak var presenter: ImprovementPresenterProtocol?
    
    private var advertismentImprovement: AdvertismentImprovement?
    private var selectedImprovement: Improvement?
    
    private var loader: LoaderProtocol = FileLoader()
    private var parser: ImprovementParserProtocol = ImprovementJSONParser()
    
    init() {
        guard let jsonImprovementData = loader.load(from: "result") else { return }
        advertismentImprovement = parser.parse(from: jsonImprovementData)
        let improvements = advertismentImprovement?.improvements
        if var selected = improvements?.filter({ $0.isSelected }), selected.count > 0 {
            selectedImprovement = selected.first
            if selected.count > 1 {
                print("Warning: result.json contains more than one selected improvement!")
                selected.removeFirst()
                for improvement in selected {
                    improvement.isSelected = false
                }
            }
        }
    }
    
    func improvementChanged(at index: Int) {
        guard let improvement = advertismentImprovement?.improvements[index] else { return }
        improvement.isSelected = !improvement.isSelected
        if let currentImprovement = selectedImprovement {
            currentImprovement.isSelected = false
        }
        selectedImprovement = improvement
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
