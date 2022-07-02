//
//  cityTableViewCell.swift
//  Charger App
//
//  Created by Doğukan Inci on 30.06.2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    let title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        
        contentView.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.font = Theme.fontNormal(size: 15)
        title.textColor = Theme.colorAux()
        
        backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            title.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -20),
            title.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
    }
}
