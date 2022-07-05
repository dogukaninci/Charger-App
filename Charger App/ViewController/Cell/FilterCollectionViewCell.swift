//
//  FilterCollectionViewCell.swift
//  Charger App
//
//  Created by Doğukan Inci on 3.07.2022.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    let filterTitle = UILabel()
    let seperatorLine = UIView()
    let cancelButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        contentView.addSubview(filterTitle)
        contentView.addSubview(seperatorLine)
        contentView.addSubview(cancelButton)
        
        filterTitle.translatesAutoresizingMaskIntoConstraints = false
        seperatorLine.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        filterTitle.font = Theme.fontNormal(size: 13)
        filterTitle.textColor = Theme.colorWhite()
        filterTitle.textAlignment = .center
        
        seperatorLine.backgroundColor = Theme.colorWhite()
        
        backgroundColor = Theme.darkColor()
        
        layer.cornerRadius = bounds.size.height / 2
        layer.borderWidth = 1
        layer.borderColor = Theme.colorPrimary().cgColor
        
        cancelButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        cancelButton.tintColor = Theme.colorGrayscale()

        
        NSLayoutConstraint.activate([
            filterTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            filterTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            filterTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 13),
            
            seperatorLine.heightAnchor.constraint(equalTo: filterTitle.heightAnchor),
            seperatorLine.widthAnchor.constraint(equalToConstant: 1),
            seperatorLine.leftAnchor.constraint(equalTo: filterTitle.rightAnchor, constant: 7),
            seperatorLine.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            cancelButton.heightAnchor.constraint(equalTo: filterTitle.heightAnchor, constant: -5),
            cancelButton.widthAnchor.constraint(equalTo: filterTitle.heightAnchor, constant: -5),
            cancelButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cancelButton.leftAnchor.constraint(equalTo: seperatorLine.rightAnchor, constant: 7)
        ])
    }
}

