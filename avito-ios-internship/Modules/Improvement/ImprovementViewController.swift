//
//  ViewController.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import UIKit

class ImprovementViewController: UIViewController {
    var presenter: ImprovementPresenterProtocol?
    var assembly: ImprovementAssemblyProtocol = ImprovementAssembly()
    
    private var closeButton = UIButton()
    private var offerLabel = UILabel()
    
    var improvementsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var improvementsCollectionViewLayout = UICollectionViewFlowLayout()
    private var selectButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.createModule(with: self)
        setupView()
    }
    
    func setOfferTitle(_ title: String) {
        self.offerLabel.text = title
    }
    
    func setSelectButtonTitle(_ title: String) {
        self.selectButton.setTitle(title, for: .normal)
    }
    
    @objc
    private func selectButtonClicked() {
        presenter?.selectButtonClicked()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        setupCloseImageView()
        setupOfferLabel()
        setupSelectButton()
        setupImprovementsCollectionView()
    }
    
    private func setupCloseImageView() {
        self.view.addSubview(closeButton)
        
        let closeIconImage = UIImage(named: "CloseIconTemplate.pdf")
        closeButton.setImage(closeIconImage, for: .normal)
        closeButton.isEnabled = false
        
        let safeArea = view.safeAreaLayoutGuide
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        closeButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 15).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupOfferLabel() {
        self.view.addSubview(offerLabel)
        offerLabel.textAlignment = .left
        offerLabel.font = UIFont(name: "Verdana-Bold", size: 28.0)
        offerLabel.numberOfLines = .max
        
        let safeArea = view.safeAreaLayoutGuide
        offerLabel.translatesAutoresizingMaskIntoConstraints = false
        offerLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: 10).isActive = true
        offerLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 15).isActive = true
        offerLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15).isActive = true
        offerLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupSelectButton() {
        self.view.addSubview(selectButton)
        selectButton.addTarget(self, action: #selector(selectButtonClicked), for: .touchUpInside)
        
        selectButton.layer.cornerRadius = 6
        selectButton.backgroundColor = UIColor(red: 72.0 / 255.0,
                                               green: 172.0 / 255.0,
                                               blue: 1.0,
                                               alpha: 1.0)
        selectButton.titleLabel?.textColor = .white
        
        let safeArea = view.safeAreaLayoutGuide
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10).isActive = true
        selectButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 15).isActive = true
        selectButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupImprovementsCollectionView() {
        self.view.addSubview(improvementsCollectionView)
        improvementsCollectionView.backgroundColor = .white
        
        improvementsCollectionViewLayout.scrollDirection = .vertical
        improvementsCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        improvementsCollectionView.collectionViewLayout = improvementsCollectionViewLayout
        improvementsCollectionView.register(ImprovementCollectionViewCell.self, forCellWithReuseIdentifier: "ImprovementCell")
        
        let safeArea = view.safeAreaLayoutGuide
        improvementsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        improvementsCollectionView.topAnchor.constraint(equalTo: self.offerLabel.bottomAnchor, constant: 20).isActive = true
        improvementsCollectionView.bottomAnchor.constraint(equalTo: self.selectButton.topAnchor, constant: -20).isActive = true
        improvementsCollectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 15).isActive = true
        improvementsCollectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15).isActive = true
    }
}

extension ImprovementViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.selectItemClicked(at: indexPath.row)
    }
}

extension ImprovementViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let presenter = presenter {
            return presenter.numberOfItemsInSection()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImprovementCell", for: indexPath)
        if let improvementCell = cell as? ImprovementCollectionViewCell {
            presenter?.cellForItem(at: indexPath.row, cell: improvementCell)
            return improvementCell
        }
        
        return cell
    }
}
