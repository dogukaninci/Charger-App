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
        showCred()
    }
    override func viewDidLayoutSubviews() {
        setGradientBackground()
    }
    /// Adds subviews to the ProfileViewController view
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
            
            logo.widthAnchor.constraint(equalToConstant: 170),
            logo.heightAnchor.constraint(equalToConstant: 170),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.bottomAnchor.constraint(equalTo: iDPlaceholderLabel.bottomAnchor, constant: 25),
            
            ePostaPlaceholderLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 25),
            ePostaPlaceholderLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
            
            iDPlaceholderLabel.topAnchor.constraint(equalTo: ePostaPlaceholderLabel.bottomAnchor, constant: 25),
            iDPlaceholderLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
            
            ePostaLabel.centerYAnchor.constraint(equalTo: ePostaPlaceholderLabel.centerYAnchor),
            ePostaLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
            
            iDLabel.centerYAnchor.constraint(equalTo: iDPlaceholderLabel.centerYAnchor, constant: 1),
            iDLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
            
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate(constraints) // activates constraints array
    }
    /// add gradient background layer to view
    private func setGradientBackground() {
        let gl = CAGradientLayer()
        gl.colors = [ Theme.colorCharcoalGrey().cgColor, Theme.darkColor().cgColor]
        gl.locations = [ 0.0, 1.0]
        gl.frame = self.view.bounds
        self.view.layer.insertSublayer(gl, at:0)
    }
    private func style(){
        if let profileLogo = UIImage(named: "profile") {
            logo.image = profileLogo
        }
        
        ePostaPlaceholderLabel.text = "E-posta:"
        ePostaPlaceholderLabel.font = Theme.fontNormal(size: 15)
        ePostaPlaceholderLabel.numberOfLines = 1
        ePostaPlaceholderLabel.textColor = Theme.colorGrayscale()
        ePostaPlaceholderLabel.textAlignment = .left
        
        iDPlaceholderLabel.text = "Cihaz ID:"
        iDPlaceholderLabel.textColor = Theme.colorGrayscale()
        iDPlaceholderLabel.font = Theme.fontNormal(size: 15)
        iDPlaceholderLabel.numberOfLines = 1
        iDPlaceholderLabel.textAlignment = .left
        
        ePostaLabel.text = ""
        ePostaLabel.font = Theme.fontBold(size: 15)
        ePostaLabel.numberOfLines = 1
        ePostaLabel.textColor = Theme.colorWhite()
        ePostaLabel.textAlignment = .right
        
        iDLabel.text = TokenManager.shared.deviceUDID
        iDLabel.textColor = Theme.colorWhite()
        iDLabel.font = Theme.fontBold(size: 11)
        iDLabel.numberOfLines = 1
        iDLabel.textAlignment = .right
        
        logoutButton.setTitle("ÇIKIŞ YAP", for: .normal)
        logoutButton.titleLabel?.font = Theme.fontBold(size: 15)
        logoutButton.setTitleColor(Theme.darkColor(), for: .normal)
        logoutButton.backgroundColor = Theme.colorWhite()
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
        ChargerService.shared.logout { isSuccess in
            if isSuccess {
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                print("Logout success")
                
            } else {
                print("Logout Error")
            }
        }
    }
}
extension ProfileViewController {
    // Read Credential from User Defaults
    private func showCred() {
        if let cred = TokenManager.shared.getCredential() {
            ePostaLabel.text = cred.email ?? ""
        }

    }
}
