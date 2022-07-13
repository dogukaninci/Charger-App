//
//  InvalidDateViewController.swift
//  Charger App
//
//  Created by Doğukan Inci on 13.07.2022.
//

import Foundation
import UIKit

/// Delegate Protocol
protocol InvalidVCProtocol {
    func isEditButton(editButton: Bool)
}

class InvalidDateViewController: UIViewController {
    
    var buttonDelegate: InvalidVCProtocol? = nil
    
    private let containerView = UIView()
    private let logo = UIImageView()
    private let invalidLabelPlaceholder = UILabel()
    private let invalidLabel = UILabel()
    private let editButton = UIButton()
    private let selectTodayButton = UIButton()
    
    var constraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        style()
    }
    /// Adds subviews to the InvalidDateViewController view
    private func setup() {
        containerView.addSubview(logo)
        containerView.addSubview(invalidLabelPlaceholder)
        containerView.addSubview(invalidLabel)
        containerView.addSubview(editButton)
        containerView.addSubview(selectTodayButton)
        view.addSubview(containerView)
        
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        selectTodayButton.addTarget(self, action: #selector(selectTodayButtonTapped), for: .touchUpInside)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            containerView,
            logo,
            invalidLabelPlaceholder,
            invalidLabel,
            editButton,
            selectTodayButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.append(contentsOf: [
            
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            logo.widthAnchor.constraint(equalToConstant: 120),
            logo.heightAnchor.constraint(equalToConstant: 120),
            logo.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50),
            logo.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            invalidLabelPlaceholder.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 50),
            invalidLabelPlaceholder.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            invalidLabel.topAnchor.constraint(equalTo: invalidLabelPlaceholder.bottomAnchor, constant: 20),
            invalidLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -50),
            invalidLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 50),
            
            editButton.heightAnchor.constraint(equalToConstant: 44),
            editButton.bottomAnchor.constraint(equalTo: selectTodayButton.topAnchor, constant: -20),
            editButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 50),
            editButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -50),
            
            selectTodayButton.heightAnchor.constraint(equalToConstant: 44),
            selectTodayButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -50),
            selectTodayButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 50),
            selectTodayButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate(constraints) // activates constraints array
    }
    private func style(){
        if let invalidLogo = UIImage(named: "invalid") {
            logo.image = invalidLogo
        }
        view.backgroundColor = Theme.darkColor().withAlphaComponent(0.9)
        containerView.backgroundColor = Theme.colorCharcoalGrey()
        containerView.layer.cornerRadius = 10
        
        invalidLabelPlaceholder.text = "Geçersiz Tarih"
        invalidLabelPlaceholder.font = Theme.fontBold(size: 18)
        invalidLabelPlaceholder.numberOfLines = 0
        invalidLabelPlaceholder.textColor = Theme.colorWhite()
        invalidLabelPlaceholder.textAlignment = .center
        
        invalidLabel.text = "Geçmiş bir tarihe randevu alamazsınız."
        invalidLabel.textColor = Theme.colorWhite()
        invalidLabel.font = Theme.fontNormal(size: 15)
        invalidLabel.numberOfLines = 2
        invalidLabel.textAlignment = .center
        
        editButton.setTitle("DÜZENLE", for: .normal)
        editButton.titleLabel?.font = Theme.fontBold(size: 15)
        editButton.setTitleColor(Theme.darkColor(), for: .normal)
        editButton.backgroundColor = Theme.colorWhite()
        editButton.layer.cornerRadius = 20
        
        selectTodayButton.setTitle("BUGÜNÜ SEÇ", for: .normal)
        selectTodayButton.titleLabel?.font = Theme.fontBold(size: 15)
        selectTodayButton.setTitleColor(Theme.colorWhite(), for: .normal)
        selectTodayButton.backgroundColor = .clear
        selectTodayButton.layer.cornerRadius = 20
        selectTodayButton.layer.borderWidth = 1
        selectTodayButton.layer.borderColor = Theme.colorGrayscale().cgColor
        
    }
}
extension InvalidDateViewController {
    @objc func editButtonTapped() {
        dismiss(animated: true) {
            self.buttonDelegate?.isEditButton(editButton: true)
        }
    }
    @objc func selectTodayButtonTapped() {
        dismiss(animated: true) {
            self.buttonDelegate?.isEditButton(editButton: false)
        }
    }
}

