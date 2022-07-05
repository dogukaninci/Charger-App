//
//  FilterTableViewCell.swift
//  Charger App
//
//  Created by Doğukan Inci on 4.07.2022.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    let socketTypeImageView = UIImageView()
    let stationName = UILabel()
    let upperInfoContainerView = UIView()
    let lowerInfoContainerView = UIView()
    let avaibleTimePlaceholderLabel = UILabel()
    let avaibleTimeLabel = UILabel()
    let distanceLabel = UILabel()
    let avaibleSocketNumberPlaceholderLabel = UILabel()
    let avaibleSocketNumberLabel = UILabel()
    let allContainerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
        configureStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Adds subviews to the FilterTableViewCell
    private func setup() {
        allContainerView.addSubview(socketTypeImageView)
        allContainerView.addSubview(stationName)
        upperInfoContainerView.addSubview(avaibleTimePlaceholderLabel)
        upperInfoContainerView.addSubview(avaibleTimeLabel)
        upperInfoContainerView.addSubview(distanceLabel)
        lowerInfoContainerView.addSubview(avaibleSocketNumberPlaceholderLabel)
        lowerInfoContainerView.addSubview(avaibleSocketNumberLabel)
        allContainerView.addSubview(upperInfoContainerView)
        allContainerView.addSubview(lowerInfoContainerView)
        contentView.addSubview(allContainerView)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            socketTypeImageView,
            stationName,
            avaibleTimePlaceholderLabel,
            avaibleTimeLabel,
            distanceLabel,
            avaibleSocketNumberPlaceholderLabel,
            avaibleSocketNumberLabel,
            upperInfoContainerView,
            lowerInfoContainerView,
            allContainerView
        ].forEach {
          $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            socketTypeImageView.topAnchor.constraint(equalTo: allContainerView.topAnchor, constant: 5),
            socketTypeImageView.leftAnchor.constraint(equalTo: allContainerView.leftAnchor, constant: 5),
            socketTypeImageView.heightAnchor.constraint(equalToConstant: 60),
            socketTypeImageView.widthAnchor.constraint(equalToConstant: 60),
            
            stationName.leftAnchor.constraint(equalTo: socketTypeImageView.rightAnchor),
            stationName.centerYAnchor.constraint(equalTo: socketTypeImageView.centerYAnchor, constant: -6),
            
            upperInfoContainerView.leftAnchor.constraint(equalTo: allContainerView.leftAnchor, constant: 10),
            upperInfoContainerView.rightAnchor.constraint(equalTo: allContainerView.rightAnchor, constant: -15),
            upperInfoContainerView.heightAnchor.constraint(equalToConstant: 44),
            upperInfoContainerView.topAnchor.constraint(equalTo: socketTypeImageView.bottomAnchor, constant: 5),
            
            lowerInfoContainerView.leftAnchor.constraint(equalTo: allContainerView.leftAnchor, constant: 10),
            lowerInfoContainerView.rightAnchor.constraint(equalTo: allContainerView.rightAnchor, constant: -15),
            lowerInfoContainerView.heightAnchor.constraint(equalToConstant: 44),
            lowerInfoContainerView.topAnchor.constraint(equalTo: upperInfoContainerView.bottomAnchor, constant: 10),
            
            avaibleTimePlaceholderLabel.leftAnchor.constraint(equalTo: upperInfoContainerView.leftAnchor, constant: 15),
            avaibleTimePlaceholderLabel.centerYAnchor.constraint(equalTo: upperInfoContainerView.centerYAnchor),
            
            avaibleTimeLabel.leftAnchor.constraint(equalTo: avaibleTimePlaceholderLabel.rightAnchor, constant: 5),
            avaibleTimeLabel.centerYAnchor.constraint(equalTo: upperInfoContainerView.centerYAnchor),
            
            avaibleSocketNumberPlaceholderLabel.leftAnchor.constraint(equalTo: lowerInfoContainerView.leftAnchor, constant: 15),
            avaibleSocketNumberPlaceholderLabel.centerYAnchor.constraint(equalTo: lowerInfoContainerView.centerYAnchor),
            
            avaibleSocketNumberLabel.leftAnchor.constraint(equalTo: avaibleSocketNumberPlaceholderLabel.rightAnchor, constant: 5),
            avaibleSocketNumberLabel.centerYAnchor.constraint(equalTo: lowerInfoContainerView.centerYAnchor),
            
            distanceLabel.rightAnchor.constraint(equalTo: upperInfoContainerView.rightAnchor, constant:  -15),
            distanceLabel.centerYAnchor.constraint(equalTo: avaibleTimeLabel.centerYAnchor),
            
            allContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            allContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            allContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            allContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    private func configureStyle() {
        backgroundColor = .clear
        
        socketTypeImageView.contentMode = .scaleAspectFill
        
        stationName.font = Theme.fontBold(size: 20)
        stationName.textColor = Theme.colorWhite()
        
        upperInfoContainerView.backgroundColor = Theme.colorCharcoalGrey()
        upperInfoContainerView.layer.shadowColor = Theme.darkColor().cgColor
        upperInfoContainerView.layer.shadowOpacity = 0.2
        upperInfoContainerView.layer.shadowOffset = .zero
        upperInfoContainerView.layer.shadowRadius = 15
        upperInfoContainerView.layer.cornerRadius = 5
        
        lowerInfoContainerView.backgroundColor = Theme.colorCharcoalGrey()
        lowerInfoContainerView.layer.shadowColor = Theme.darkColor().cgColor
        lowerInfoContainerView.layer.shadowOpacity = 0.2
        lowerInfoContainerView.layer.shadowOffset = .zero
        lowerInfoContainerView.layer.shadowRadius = 15
        lowerInfoContainerView.layer.cornerRadius = 5
        
        avaibleTimePlaceholderLabel.font = Theme.fontNormal(size: 15)
        avaibleTimePlaceholderLabel.textColor = Theme.colorGrayscale()
        
        avaibleTimeLabel.font = Theme.fontNormal(size: 15)
        avaibleTimeLabel.textColor = Theme.colorWhite()
        
        avaibleSocketNumberPlaceholderLabel.font = Theme.fontNormal(size: 15)
        avaibleSocketNumberPlaceholderLabel.textColor = Theme.colorGrayscale()
        
        avaibleSocketNumberLabel.font = Theme.fontNormal(size: 15)
        avaibleSocketNumberLabel.textColor = Theme.colorWhite()
        
        distanceLabel.font = Theme.fontNormal(size: 15)
        distanceLabel.textColor = Theme.colorGrayscale()
        
        allContainerView.backgroundColor = Theme.colorCharcoalGrey()
        allContainerView.layer.cornerRadius = 7
    }

}
