//
//  StationInfoCell.swift
//  Charger App
//
//  Created by Doğukan Inci on 11.07.2022.
//

import Foundation
import UIKit

class AddressCell: UITableViewCell {
    
    let addressPlaceholderLabel = UILabel()
    let addressLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        contentView.addSubview(addressPlaceholderLabel)
        contentView.addSubview(addressLabel)
        
        addressPlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addressPlaceholderLabel.font = Theme.fontBold(size: 15)
        addressPlaceholderLabel.textColor = Theme.colorWhite()
        addressPlaceholderLabel.textAlignment = .left
        
        addressLabel.font = Theme.fontNormal(size: 15)
        addressLabel.textColor = Theme.colorGrayscale()
        addressLabel.textAlignment = .left
        addressLabel.numberOfLines = 0
        
        backgroundColor = Theme.colorCharcoalGrey()
        
        NSLayoutConstraint.activate([
            addressPlaceholderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            addressPlaceholderLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            addressPlaceholderLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            
            addressLabel.topAnchor.constraint(equalTo: addressPlaceholderLabel.bottomAnchor, constant: 5),
            addressLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            addressLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            addressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
        
        addressPlaceholderLabel.text = "Adres"
    }
}

