//
//  FilterTableViewCell.swift
//  Charger App
//
//  Created by Doğukan Inci on 4.07.2022.
//

import UIKit

class AppointmentsCell: UITableViewCell {
    
    let socketTypeImageView = UIImageView()
    let deleteButton = UIButton()
    let stationName = UILabel()
    let upperInfoContainerView = UIView()
    let lowerInfoContainerView = UIView()
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    let alertImageView = UIImageView()
    let alertLabel = UILabel()
    let powerLabel = UILabel()
    let socketNumberPlaceholderLabel = UILabel()
    let socketNumberLabel = UILabel()
    let socketTypeLabel = UILabel()
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
        allContainerView.addSubview(deleteButton)
        upperInfoContainerView.addSubview(dateLabel)
        upperInfoContainerView.addSubview(timeLabel)
        upperInfoContainerView.addSubview(powerLabel)
        upperInfoContainerView.addSubview(alertImageView)
        upperInfoContainerView.addSubview(alertLabel)
        lowerInfoContainerView.addSubview(socketNumberPlaceholderLabel)
        lowerInfoContainerView.addSubview(socketNumberLabel)
        lowerInfoContainerView.addSubview(socketTypeLabel)
        allContainerView.addSubview(upperInfoContainerView)
        allContainerView.addSubview(lowerInfoContainerView)
        contentView.addSubview(allContainerView)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            socketTypeImageView,
            stationName,
            deleteButton,
            dateLabel,
            timeLabel,
            powerLabel,
            alertImageView,
            alertLabel,
            socketNumberPlaceholderLabel,
            socketNumberLabel,
            socketTypeLabel,
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
            
            deleteButton.rightAnchor.constraint(equalTo: allContainerView.rightAnchor, constant: -15),
            deleteButton.centerYAnchor.constraint(equalTo: stationName.centerYAnchor),
            
            upperInfoContainerView.leftAnchor.constraint(equalTo: allContainerView.leftAnchor, constant: 15),
            upperInfoContainerView.rightAnchor.constraint(equalTo: allContainerView.rightAnchor, constant: -15),
            upperInfoContainerView.heightAnchor.constraint(equalToConstant: 44),
            upperInfoContainerView.topAnchor.constraint(equalTo: socketTypeImageView.bottomAnchor, constant: 5),
            
            lowerInfoContainerView.leftAnchor.constraint(equalTo: allContainerView.leftAnchor, constant: 15),
            lowerInfoContainerView.rightAnchor.constraint(equalTo: allContainerView.rightAnchor, constant: -15),
            lowerInfoContainerView.heightAnchor.constraint(equalToConstant: 44),
            lowerInfoContainerView.topAnchor.constraint(equalTo: upperInfoContainerView.bottomAnchor, constant: 10),
            
            dateLabel.leftAnchor.constraint(equalTo: upperInfoContainerView.leftAnchor, constant: 15),
            dateLabel.centerYAnchor.constraint(equalTo: upperInfoContainerView.centerYAnchor),
            
            timeLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 5),
            timeLabel.centerYAnchor.constraint(equalTo: upperInfoContainerView.centerYAnchor),
            
            socketNumberPlaceholderLabel.leftAnchor.constraint(equalTo: lowerInfoContainerView.leftAnchor, constant: 15),
            socketNumberPlaceholderLabel.centerYAnchor.constraint(equalTo: lowerInfoContainerView.centerYAnchor),
            
            socketNumberLabel.leftAnchor.constraint(equalTo: socketNumberPlaceholderLabel.rightAnchor, constant: 5),
            socketNumberLabel.centerYAnchor.constraint(equalTo: lowerInfoContainerView.centerYAnchor),
            
            socketTypeLabel.rightAnchor.constraint(equalTo: lowerInfoContainerView.rightAnchor, constant:  -15),
            socketTypeLabel.centerYAnchor.constraint(equalTo: socketNumberLabel.centerYAnchor),
            
            alertImageView.heightAnchor.constraint(equalToConstant: 15),
            alertImageView.widthAnchor.constraint(equalToConstant: 14),
            alertImageView.centerYAnchor.constraint(equalTo: alertLabel.centerYAnchor),
            alertImageView.rightAnchor.constraint(equalTo: alertLabel.leftAnchor, constant: -5),
            
            alertLabel.rightAnchor.constraint(equalTo: upperInfoContainerView.rightAnchor, constant: -15),
            alertLabel.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            
            powerLabel.rightAnchor.constraint(equalTo: upperInfoContainerView.rightAnchor, constant:  -15),
            powerLabel.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            
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
        
        deleteButton.tintColor = Theme.colorGrayscale()
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        
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
        
        dateLabel.font = Theme.fontNormal(size: 15)
        dateLabel.textColor = Theme.colorWhite()
        
        timeLabel.font = Theme.fontNormal(size: 15)
        timeLabel.textColor = Theme.colorWhite()
        
        socketNumberPlaceholderLabel.font = Theme.fontNormal(size: 15)
        socketNumberPlaceholderLabel.textColor = Theme.colorGrayscale()
        
        socketNumberLabel.font = Theme.fontNormal(size: 15)
        socketNumberLabel.textColor = Theme.colorWhite()
        
        socketTypeLabel.font = Theme.fontNormal(size: 15)
        socketTypeLabel.textColor = Theme.colorGrayscale()
        
        alertImageView.image = UIImage(systemName: "alarm")
        alertImageView.tintColor = Theme.colorGrayscale()
        
        alertLabel.font = Theme.fontNormal(size: 15)
        alertLabel.textColor = Theme.colorWhite()
        
        powerLabel.font = Theme.fontNormal(size: 15)
        powerLabel.textColor = Theme.colorGrayscale()
        
        allContainerView.backgroundColor = Theme.colorCharcoalGrey()
        allContainerView.layer.cornerRadius = 7
        
    }

}
