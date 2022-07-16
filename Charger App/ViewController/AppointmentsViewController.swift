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
    
    private let tableView = UITableView()
    
    private let appointmentsViewModel: AppointmentsViewModel
    
    var constraints: [NSLayoutConstraint] = []
    
    init() {
        self.appointmentsViewModel = AppointmentsViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        style()
        setNavigationBarItems()
        delegation()
        initViewModel()
        addObserverForCreateAppointmenReload()
    }
    override func viewDidLayoutSubviews() {
        setGradientBackground()
    }
    /// Adds subviews to the AppointmentsViewController view
    private func setup() {
        view.addSubview(appointmentLabel)
        view.addSubview(appointmentDescriptionLabel)
        view.addSubview(logo)
        view.addSubview(createButton)
        view.addSubview(tableView)
        
        tableView.register(AppointmentsCell.self, forCellReuseIdentifier: "appointmentsCell")
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            appointmentLabel,
            appointmentDescriptionLabel,
            logo,
            createButton,
            tableView
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
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            createButton.heightAnchor.constraint(equalToConstant: 44),
            createButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            createButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            createButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
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
        if let appointmentLogo = UIImage(named: "appointmentLogo") {
            logo.image = appointmentLogo
        }
        
        appointmentLabel.text = "Henüz bir randevu oluşturmadınız."
        appointmentLabel.font = Theme.fontBold(size: 30)
        appointmentLabel.numberOfLines = 0
        appointmentLabel.textColor = Theme.colorWhite()
        appointmentLabel.textAlignment = .center
        
        appointmentDescriptionLabel.text = "Oluşturulan randevular burada listelenir."
        appointmentDescriptionLabel.textColor = Theme.colorGrayscale()
        appointmentDescriptionLabel.font = Theme.fontNormal(size: 15)
        appointmentDescriptionLabel.numberOfLines = 0
        appointmentDescriptionLabel.textAlignment = .center
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = Theme.colorGrayscale()
        // clear head inset
        tableView.separatorInset = .zero
        tableView.rowHeight = 44
        tableView.layer.cornerRadius = 7
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isHidden = true
        
        createButton.setTitle("RANDEVU OLUŞTUR", for: .normal)
        createButton.titleLabel?.font = Theme.fontBold(size: 15)
        createButton.setTitleColor(Theme.darkColor(), for: .normal)
        createButton.backgroundColor = Theme.colorWhite()
        createButton.layer.cornerRadius = 20
    }
    func initViewModel() {
        // Get notifications than stations 
        appointmentsViewModel.getLocalNotifications()
        
        // Reload TableView closure
        DispatchQueue.main.async {
            self.appointmentsViewModel.reloadTableView = { [weak self] in
                self?.appointmentsViewModel.getNotificationTime()
                self?.tableView.reloadData()
                if (self?.appointmentsViewModel.appointments[0].count != 0 || self?.appointmentsViewModel.appointments[1].count != 0 ) {
                    self?.tableView.isHidden = false
                    self?.appointmentLabel.isHidden = true
                    self?.appointmentDescriptionLabel.isHidden = true
                    self?.logo.isHidden = true
                    
                }
            }
        }
    }
}
extension AppointmentsViewController {
    /// Table View Delegation
    private func delegation() {
        tableView.dataSource = self
        tableView.delegate = self
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
        appearance.titleTextAttributes = [.foregroundColor: Theme.colorWhite(),.font: Theme.fontBold(size: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationItem.title = "Randevular"
        navigationItem.titleView?.tintColor = Theme.colorWhite()
        let profileBarButton = UIBarButtonItem(image: UIImage(named: "Users"),
                                               style: .plain,
                                               target: self,
                                               action: #selector(profileButtonTapped))
        navigationItem.leftBarButtonItem = profileBarButton
        navigationItem.titleView?.tintColor = Theme.colorWhite()
        self.navigationController?.navigationBar.tintColor = Theme.colorWhite()
    }
}
extension AppointmentsViewController {
    @objc func profileButtonTapped() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
extension AppointmentsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return appointmentsViewModel.appointments.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "GÜNCEL RANDEVULAR"
        } else {
            return "GEÇMİŞ RANDEVULAR"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentsViewModel.appointments[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentsCell", for: indexPath) as! AppointmentsCell
        let appointment = appointmentsViewModel.appointments[indexPath.section][indexPath.row]
        if indexPath.section == 0 {
            cell.stationName.text = appointment.stationName
            cell.socketTypeImageView.image = UIImage(named: findStationTypeImage(station: appointment))
            cell.dateLabel.text = appointment.date!.convertDate() + ","
            cell.timeLabel.text = appointment.time
            cell.powerLabel.isHidden = true
            cell.alertLabel.isHidden = false
            cell.alertImageView.isHidden = false
            cell.alertLabel.text = appointmentsViewModel.notificationString[indexPath.row]
            cell.socketNumberPlaceholderLabel.text = "Soket Numarası:"
            cell.socketNumberLabel.text = String(appointmentsViewModel.findSocketInfo(section: indexPath.section, row: indexPath.row).socketNumber!)
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped(sender:)), for: .touchUpInside)
            cell.deleteButton.tag = indexPath.row
            cell.socketTypeLabel.text = appointmentsViewModel.getSocketTypeInfo(section: indexPath.section, row: indexPath.row)
            cell.deleteButton.isHidden = false
            cell.selectionStyle = .none
            return cell
        } else {
            cell.stationName.text = appointment.stationName
            cell.socketTypeImageView.image = UIImage(named: findStationTypeImage(station: appointment))
            cell.dateLabel.text = appointment.date!.convertDate() + ","
            cell.timeLabel.text = appointment.time
            cell.alertLabel.isHidden = true
            cell.alertImageView.isHidden = true
            cell.powerLabel.text = appointmentsViewModel.getPowerInfo(section: indexPath.section, row: indexPath.row)
            cell.socketNumberPlaceholderLabel.text = "Soket Numarası:"
            cell.socketNumberLabel.text = String(appointmentsViewModel.findSocketInfo(section: indexPath.section, row: indexPath.row).socketNumber!)
            cell.socketTypeLabel.text = appointmentsViewModel.getSocketTypeInfo(section: indexPath.section, row: indexPath.row)
            cell.deleteButton.isHidden = true
            cell.selectionStyle = .none
            return cell
        }

    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = Theme.colorGrayscale()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
extension AppointmentsViewController {
    /// Find image by searching stations charge type array
    /// - Parameter station: StationElement
    /// - Returns: String
    private func findStationTypeImage(station: Appointment) -> String{
        if let stationClass = station.station {
            if let socket = stationClass.sockets {
                if(socket.contains(where: { $0.chargeType?.rawValue == "AC" })) {
                    if(socket.contains(where: { $0.chargeType?.rawValue == "DC" })) {
                        return "acdc"
                    }
                }
                if(socket.contains(where: { $0.chargeType?.rawValue == "AC" })) {
                    return "ac"
                }
            }
        }
        return "dc"
    }
}
extension AppointmentsViewController: CancelAppointmentVCProtocol {
    func isCancelButton(cancelButton: Bool) {
        if cancelButton {
            appointmentsViewModel.deleteAppointment(appointmentNumber: appointmentsViewModel.buttonTag) { [weak self] isSuccess in
                print(isSuccess)
                self?.appointmentsViewModel.getLocalNotifications()
            }
        }
    }
    
    @objc func deleteButtonTapped(sender: UIButton){
        appointmentsViewModel.deleteNotification(row: sender.tag)
        
        appointmentsViewModel.buttonTag = sender.tag
        let cancelAppointmentVC = CancelAppointmentViewController(appointment: appointmentsViewModel.appointments [0][appointmentsViewModel.buttonTag])
        cancelAppointmentVC.modalPresentationStyle = .overCurrentContext
        cancelAppointmentVC.buttonDelegate = self
        present(cancelAppointmentVC, animated: true)
    }
}
extension AppointmentsViewController {
    private func addObserverForCreateAppointmenReload() {
        // Notification Center observer adding process
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appointmentAdded),
                                               name: NSNotification.Name("appointmentAdded"),
                                               object: nil)
    }
}
extension AppointmentsViewController {
    @objc func appointmentAdded() {
        appointmentsViewModel.checkAppointments()
    }
}
