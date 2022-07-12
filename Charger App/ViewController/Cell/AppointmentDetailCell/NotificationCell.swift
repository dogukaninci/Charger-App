//
//  StationInfoCell.swift
//  Charger App
//
//  Created by Doğukan Inci on 11.07.2022.
//

import Foundation
import UIKit

class NotificationCell: UITableViewCell {
    
    let placeholderLabel = UILabel()
    let onOffSwitch = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        contentView.addSubview(placeholderLabel)
        contentView.addSubview(onOffSwitch)
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        onOffSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        placeholderLabel.font = Theme.fontBold(size: 15)
        placeholderLabel.textColor = Theme.colorWhite()
        placeholderLabel.textAlignment = .left
        
        
        backgroundColor = Theme.colorCharcoalGrey()
        
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            placeholderLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            placeholderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            onOffSwitch.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            onOffSwitch.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            onOffSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}

