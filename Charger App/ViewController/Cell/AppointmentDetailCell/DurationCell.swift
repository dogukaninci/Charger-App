//
//  StationInfoCell.swift
//  Charger App
//
//  Created by Doğukan Inci on 11.07.2022.
//

import Foundation
import UIKit

class DurationCell: UITableViewCell {
    
    let durationLabel = UILabel()
    let iconView = UIImageView()
    let bottomLine = CALayer()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        
        bottomLine.frame = CGRect(x: 15, y: self.frame.size.height - 1, width: self.frame.size.width + 5, height: 1)
        bottomLine.backgroundColor = Theme.colorGrayscale().cgColor

        contentView.addSubview(durationLabel)
        contentView.addSubview(iconView)
        contentView.layer.addSublayer(bottomLine)
        
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        durationLabel.font = Theme.fontNormal(size: 15)
        durationLabel.textColor = Theme.colorWhite()
        durationLabel.textAlignment = .left
        
        iconView.image = UIImage(systemName: "chevron.down")
        
        backgroundColor = Theme.colorCharcoalGrey()
        
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            durationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            durationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            iconView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}

