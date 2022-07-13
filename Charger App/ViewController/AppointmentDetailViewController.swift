//
//  AppointmentDetailViewController.swift
//  Charger App
//
//  Created by Doğukan Inci on 11.07.2022.
//

import Foundation
import UIKit

class AppointmentDetailViewController: UIViewController {
    
    let tableView = UITableView()
    private let confirmDetailButton = UIButton()
    
    let appointmentDetailViewModel: AppointmentDetailViewModel
    
    private var constraints: [NSLayoutConstraint] = []
    
    init(station: StationElement, socketIndex: Int, timeSlot: String, appointmentDate: String) {
        self.appointmentDetailViewModel = AppointmentDetailViewModel(station: station, socketIndex: socketIndex, timeSlot: timeSlot, appointmentDate: appointmentDate)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        setupConstraints()
        setGradientBackground()
        delegation()
        setNavigationBarItems()
    }
    /// Adds subviews to the AppointmentDetailViewController's view
    private func setup() {
        view.addSubview(tableView)
        view.addSubview(confirmDetailButton)
        
        tableView.register(AddressCell.self, forCellReuseIdentifier: "addressCell")
        tableView.register(OtherCell.self, forCellReuseIdentifier: "otherCell")
        tableView.register(NotificationCell.self, forCellReuseIdentifier: "notificationCell")
        tableView.register(DurationCell.self, forCellReuseIdentifier: "durationCell")
        
        confirmDetailButton.addTarget(self, action: #selector(confirmButtonTapped(sender:)), for: .touchUpInside)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            tableView,
            confirmDetailButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.append(contentsOf: [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: confirmDetailButton.topAnchor, constant: -20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            confirmDetailButton.heightAnchor.constraint(equalToConstant: 44),
            confirmDetailButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            confirmDetailButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            confirmDetailButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate(constraints) // activates constraints array
    }
    private func style() {
        tableView.backgroundColor = .clear
        
        confirmDetailButton.setTitle("RANDEVUYU ONAYLA", for: .normal)
        confirmDetailButton.titleLabel?.font = Theme.fontBold(size: 15)
        confirmDetailButton.setTitleColor(Theme.darkColor(), for: .normal)
        confirmDetailButton.backgroundColor = Theme.colorWhite()
        confirmDetailButton.layer.cornerRadius = 20
    }
    /// add gradient background layer to view
    private func setGradientBackground() {
        let gl = CAGradientLayer()
        gl.colors = [ Theme.colorCharcoalGrey().cgColor, Theme.darkColor().cgColor]
        gl.locations = [ 0.0, 1.0]
        gl.frame = self.view.bounds
        self.view.layer.insertSublayer(gl, at:0)
    }
}
extension AppointmentDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "İSTASYON BİLGİLERİ"
        } else if section == 1 {
            return "SOKET BİLGİLERİ"
        } else {
            return "RANDEVU BİLGİLERİ"
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = Theme.colorGrayscale()
            headerView.textLabel?.font = Theme.fontBold(size: 15)
            headerView.textLabel?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
            headerView.backgroundView?.backgroundColor = .clear
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 100
            }
        }
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else if section == 1 {
            return 4
        } else {
            return 4
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressCell
                cell.addressLabel.text = appointmentDetailViewModel.cellText[indexPath.section][indexPath.row]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell", for: indexPath) as! OtherCell
                cell.detailLabel.text = appointmentDetailViewModel.cellText[indexPath.section][indexPath.row]
                cell.placeholderLabel.text = appointmentDetailViewModel.placeholderArray[indexPath.section][indexPath.row]
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell", for: indexPath) as! OtherCell
            cell.detailLabel.text = appointmentDetailViewModel.cellText[indexPath.section][indexPath.row]
            cell.placeholderLabel.text = appointmentDetailViewModel.placeholderArray[indexPath.section][indexPath.row]
            return cell
        } else {
            if indexPath.row < 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell", for: indexPath) as! OtherCell
                cell.detailLabel.text = appointmentDetailViewModel.cellText[indexPath.section][indexPath.row]
                cell.placeholderLabel.text = appointmentDetailViewModel.placeholderArray[indexPath.section][indexPath.row]
                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "durationCell", for: indexPath) as! DurationCell
                return cell
            }
        }
    }
}
extension AppointmentDetailViewController {
    /// Table View Delegation
    private func delegation() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}
extension AppointmentDetailViewController {
    @objc func confirmButtonTapped(sender: UIButton) {
        appointmentDetailViewModel.sendAppointmentRequest { [weak self] isSuccess in
            if isSuccess {
                NotificationCenter.default.post(name: NSNotification.Name("appointmentAdded"), object: nil)
                let appointmentsVC = AppointmentsViewController()
                appointmentsVC.modalPresentationStyle = .fullScreen
                self?.navigationController?.pushViewController(appointmentsVC, animated: true)
            }
        }
    }
}
extension AppointmentDetailViewController {
    /// Sets Navigation Bar styles and items
    private func setNavigationBarItems() {
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "Randevu Detayı"
        titleLabel.font = Theme.fontBold(size: 20)
        titleLabel.textColor = Theme.colorWhite()
        let subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = appointmentDetailViewModel.selectedStation!.stationName?.localizedUppercase
        subtitleLabel.font = Theme.fontNormal(size: 12)
        subtitleLabel.textColor = Theme.colorGrayscale()
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        
        navigationItem.titleView = stackView
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal

    }
}


