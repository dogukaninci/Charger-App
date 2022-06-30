//
//  ProfileViewController.swift
//  Charger App
//
//  Created by Doğukan Inci on 30.06.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let logo = UIImageView()
    private let containerView = UIView()
    private let ePostaPlaceholderLabel = UILabel()
    private let iDPlaceholderLabel = UILabel()
    private let ePostaLabel = UILabel()
    private let iDLabel = UILabel()
    private let logoutButton = UIButton()
    
    var constraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        style()
        setNavigationBarItems()
    }
    /// Adds subviews to the AppointmentsViewController view
    private func setup() {
        containerView.addSubview(ePostaPlaceholderLabel)
        containerView.addSubview(iDPlaceholderLabel)
        containerView.addSubview(ePostaLabel)
        containerView.addSubview(iDLabel)
        view.addSubview(logo)
        view.addSubview(containerView)
        view.addSubview(logoutButton)
        
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            logo,
            containerView,
            ePostaPlaceholderLabel,
            iDPlaceholderLabel,
            ePostaLabel,
            iDLabel,
            logoutButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.append(contentsOf: [
            
            logo.widthAnchor.constraint(equalToConstant: 120),
            logo.heightAnchor.constraint(equalToConstant: 120),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            containerView.heightAnchor.constraint(equalToConstant: 100),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            ePostaPlaceholderLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            ePostaPlaceholderLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),

            iDPlaceholderLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            iDPlaceholderLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            
            ePostaLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            ePostaLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),

            iDLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            iDLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate(constraints) // activates constraints array
    }
    private func style(){
        if let backgroundImage = UIImage(named: "background") {
            view.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        if let profileLogo = UIImage(named: "profileLogo") {
            logo.image = profileLogo
        }
        
        ePostaPlaceholderLabel.text = "E-posta:"
        ePostaPlaceholderLabel.font = Theme.fontNormal(size: 15)
        ePostaPlaceholderLabel.numberOfLines = 1
        ePostaPlaceholderLabel.textColor = Theme.colorAux()
        ePostaPlaceholderLabel.textAlignment = .left

        iDPlaceholderLabel.text = "Cihaz ID:"
        iDPlaceholderLabel.textColor = Theme.colorAux()
        iDPlaceholderLabel.font = Theme.fontNormal(size: 15)
        iDPlaceholderLabel.numberOfLines = 1
        iDPlaceholderLabel.textAlignment = .left
        
        ePostaLabel.text = "dogukaninci93@gmail.com"
        ePostaLabel.font = Theme.fontBold(size: 15)
        ePostaLabel.numberOfLines = 1
        ePostaLabel.textColor = Theme.colorMain()
        ePostaLabel.textAlignment = .right

        iDLabel.text = "123456"
        iDLabel.textColor = Theme.colorMain()
        iDLabel.font = Theme.fontBold(size: 15)
        iDLabel.numberOfLines = 1
        iDLabel.textAlignment = .right

        logoutButton.setTitle("ÇIKIŞ YAP", for: .normal)
        logoutButton.titleLabel?.font = Theme.fontBold(size: 15)
        logoutButton.setTitleColor(Theme.colorThird(), for: .normal)
        logoutButton.backgroundColor = Theme.colorMain()
        logoutButton.layer.cornerRadius = 20
        
        containerView.backgroundColor = Theme.navBarColor()
        containerView.layer.cornerRadius = 10
    }
}
extension ProfileViewController {
    /// Sets Navigation Bar styles and items
    private func setNavigationBarItems() {
        navigationItem.title = "Profil"
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
extension ProfileViewController {
    /// Log out proccess
    @objc func logoutButtonTapped() {
    }
}