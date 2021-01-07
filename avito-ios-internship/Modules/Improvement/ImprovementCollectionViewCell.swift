//
//  ImprovementCollectionViewCell.swift
//  avito-ios-internship
//
//  Created by Георгий Куликов on 07.01.2021.
//

import UIKit

class ImprovementCollectionViewCell: UICollectionViewCell {
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var iconImageView = UIImageView()
    private var priceLabel = UILabel()
    private var selectImageView = UIImageView()
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: safeAreaLayoutGuide.layoutFrame.width)
        width.isActive = true
        return width
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = safeAreaLayoutGuide.layoutFrame.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 0))
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setDescription(_ description: String) {
        descriptionLabel.text = description
    }
    
    func setIcon(_ image: UIImage?) {
        iconImageView.image = image
    }
    
    func setPrice(_ price: String) {
        priceLabel.text = price
    }
    
    func setSelectedImage(_ image: UIImage?) {
        selectImageView.image = image
    }
    
    func setHiddenSelectImage(_ isHidden: Bool) {
        selectImageView.isHidden = isHidden
    }
    
    private func setupCell() {
        self.backgroundColor = UIColor(red: 240.0 / 255, green: 240.0 / 255, blue: 240.0 / 255, alpha: 1.0)
        self.layer.cornerRadius = 6
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setupIconImageView()
        setupSelectImageView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupPriceLabel()
        
        contentView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    private func setupIconImageView() {
        contentView.addSubview(iconImageView)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 55).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    private func setupSelectImageView() {
        contentView.addSubview(selectImageView)
        
        selectImageView.translatesAutoresizingMaskIntoConstraints = false
        selectImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        selectImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        selectImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        selectImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = .max
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "Verdana-Bold", size: 20.0)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: selectImageView.leftAnchor, constant: -10).isActive = true
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = .max
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = UIFont(name: "Verdana", size: 16.0)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: selectImageView.leftAnchor, constant: -10).isActive = true
    }
    
    private func setupPriceLabel() {
        contentView.addSubview(priceLabel)
        priceLabel.textAlignment = .left
        priceLabel.font = UIFont(name: "Verdana-Bold", size: 18.0)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: selectImageView.leftAnchor, constant: -10).isActive = true
    }
}
