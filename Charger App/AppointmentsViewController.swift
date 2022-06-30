//
//  AppointmentsViewController.swift
//  Charger App
//
//  Created by Doğukan Inci on 30.06.2022.
//

import UIKit

class AppointmentsViewController: UIViewController {
    
    private let appointmentLabel = UILabel()
    private let appointmentDescriptionLabel = UILabel()
    private let logo = UIImageView()
    private let createButton = UIButton()
    
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
        view.addSubview(appointmentLabel)
        view.addSubview(appointmentDescriptionLabel)
        view.addSubview(logo)
        view.addSubview(createButton)
        
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            appointmentLabel,
            appointmentDescriptionLabel,
            logo,
            createButton
        ].forEach {
          $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.append(contentsOf: [
            
            logo.widthAnchor.constraint(equalToConstant: 120),
            logo.heightAnchor.constraint(equalToConstant: 120),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            appointmentLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 50),
            appointmentLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            appointmentLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            appointmentDescriptionLabel.topAnchor.constraint(equalTo: appointmentLabel.bottomAnchor, constant: 20),
            appointmentDescriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            appointmentDescriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
    
            createButton.heightAnchor.constraint(equalToConstant: 44),
            createButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            createButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            createButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate(constraints) // activates constraints array
    }
    private func style(){
        if let backgroundImage = UIImage(named: "background") {
            view.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        if let appointmentLogo = UIImage(named: "appointmentLogo") {
            logo.image = appointmentLogo
        }
        
        appointmentLabel.text = "Henüz bir randevu oluşturmadınız."
        appointmentLabel.font = Theme.fontBold(size: 30)
        appointmentLabel.numberOfLines = 0
        appointmentLabel.textColor = Theme.colorMain()
        appointmentLabel.textAlignment = .center

        appointmentDescriptionLabel.text = "Oluşturulan randevular burada listelenir."
        appointmentDescriptionLabel.textColor = Theme.colorAux()
        appointmentDescriptionLabel.font = Theme.fontNormal(size: 15)
        appointmentDescriptionLabel.numberOfLines = 0
        appointmentDescriptionLabel.textAlignment = .center

        createButton.setTitle("RANDEVU OLUŞTUR", for: .normal)
        createButton.titleLabel?.font = Theme.fontBold(size: 15)
        createButton.setTitleColor(Theme.colorThird(), for: .normal)
        createButton.backgroundColor = Theme.colorMain()
        createButton.layer.cornerRadius = 20
    }
}
extension AppointmentsViewController {
    @objc func createButtonTapped() {
        let selectCityVC = SelectCityViewController()
        navigationController?.pushViewController(selectCityVC, animated: true)
    }
}
extension AppointmentsViewController {
    private func setNavigationBarItems() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Theme.navBarColor()
        appearance.titleTextAttributes = [.foregroundColor: Theme.colorMain(),.font: Theme.fontBold(size: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationItem.title = "Randevular"
        navigationItem.titleView?.tintColor = Theme.colorMain()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileButtonTapped))
        navigationItem.titleView?.tintColor = Theme.colorMain()
        self.navigationController?.navigationBar.tintColor = Theme.colorMain()
    }
}
extension AppointmentsViewController {
    @objc func profileButtonTapped() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
