//
//  FilterViewControllerCell.swift
//  Charger App
//
//  Created by Doğukan Inci on 6.07.2022.
//

import Foundation
import UIKit

class FilterViewControllerCell: UICollectionViewCell {
    
    let filterTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        contentView.addSubview(filterTitle)
        
        filterTitle.translatesAutoresizingMaskIntoConstraints = false
        
        filterTitle.font = Theme.fontNormal(size: 15)
        filterTitle.textColor = Theme.colorWhite()
        filterTitle.textAlignment = .center
        
        backgroundColor = Theme.darkColor()
        
        layer.cornerRadius = bounds.size.height / 2
        layer.borderWidth = 1
        layer.borderColor = Theme.colorPrimary().cgColor
        
        NSLayoutConstraint.activate([
            filterTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            filterTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            filterTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
