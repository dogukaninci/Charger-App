//
//  SelectDateViewController.swift
//  Charger App
//
//  Created by Doğukan Inci on 8.07.2022.
//

import Foundation
import UIKit

// Time Label View Class for decleration using for loop
class TimeLabelView: UIView {
    
    let timeLabel = UILabel()
    
    init(timeSlot: String) {
        super.init(frame: .zero)
        timeLabel.text = timeSlot
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func commonInit() {
        timeLabel.font = Theme.fontNormal(size: 15)
        timeLabel.textColor = Theme.colorWhite()
        timeLabel.backgroundColor = Theme.colorCharcoalGrey()
        timeLabel.layer.cornerRadius = 5
        timeLabel.layer.borderWidth = 1
        timeLabel.layer.borderColor = Theme.colorCharcoalGrey().cgColor
        timeLabel.clipsToBounds = true
        timeLabel.textAlignment = .center
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

class SelectDateAndSlotViewController: UIViewController {
    
    private var timeClassArraySocket1 = [TimeLabelView]()
    private var timeClassArraySocket2 = [TimeLabelView]()
    private var timeClassArraySocket3 = [TimeLabelView]()
    
    private let appointmentDateLabel = UILabel()
    private let datePickerLabel = UILabel()
    private let socket1Label = UILabel()
    private let type1Label = UILabel()
    private let socket2Label = UILabel()
    private let type2Label = UILabel()
    private let socket3Label = UILabel()
    private let type3Label = UILabel()
    private let socket1ContainerView = UIView()
    private let socket2ContainerView = UIView()
    private let socket3ContainerView = UIView()
    
    private let stackViewHeaders = UIStackView()
    private let stackView1Vertical = UIStackView()
    private let stackView2Vertical = UIStackView()
    private let stackView3Vertical = UIStackView()
    private let stackViewHorizontal = UIStackView()
    
    private let scrollView = UIScrollView()
    private let timeLabelArray = [UILabel]()
    
    private let confirmButton = UIButton()
    
    var selectedView: TimeLabelView? = nil
    
    private let selectDateAndSlotViewModel: SelectDateAndSlotViewModel
    
    private var constraints: [NSLayoutConstraint] = []
    
    init(viewModel: StationElement) {
        // Create SelectDateViewModel with station info coming from
        //SelectStationViewController to SelectDateViewController seque
        self.selectDateAndSlotViewModel = SelectDateAndSlotViewModel(station: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        setGradientBackground()
        setNavigationBarItems()
        initViewModel()
    }
    override func viewDidLayoutSubviews() {
        setupConstraints()
    }
    /// Adds subviews to the SelectDateViewController view
    private func setup() {
        view.addSubview(appointmentDateLabel)
        view.addSubview(datePickerLabel)
        // Add Soket number and socket type to container view
        socket1ContainerView.addSubview(socket1Label)
        socket1ContainerView.addSubview(type1Label)
        socket2ContainerView.addSubview(socket2Label)
        socket2ContainerView.addSubview(type2Label)
        socket3ContainerView.addSubview(socket3Label)
        socket3ContainerView.addSubview(type3Label)
        //
        stackViewHeaders.addArrangedSubview(socket1ContainerView)
        stackViewHeaders.addArrangedSubview(socket2ContainerView)
        stackViewHeaders.addArrangedSubview(socket3ContainerView)
        
        stackViewHorizontal.addArrangedSubview(stackView1Vertical)
        stackViewHorizontal.addArrangedSubview(stackView2Vertical)
        stackViewHorizontal.addArrangedSubview(stackView3Vertical)
        view.addSubview(stackViewHeaders)
        scrollView.addSubview(stackViewHorizontal)
        view.addSubview(scrollView)
        view.addSubview(confirmButton)
        datePickerLabel.isUserInteractionEnabled = true
        datePickerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(datePickerTapped(sender:))))
        confirmButton.addTarget(self, action: #selector(confirmTapped(sender:)), for: .touchUpInside)
        
        for index in 0...23 {
            let timeLabelView = TimeLabelView(timeSlot: selectDateAndSlotViewModel.timeArray[index])
            timeLabelView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewInStack1Tapped(sender:))))
            timeClassArraySocket1.append(timeLabelView)
            stackView1Vertical.addArrangedSubview(timeLabelView)
            NSLayoutConstraint.activate([
                timeLabelView.widthAnchor.constraint(equalTo: stackView1Vertical.widthAnchor),
                timeLabelView.heightAnchor.constraint(equalToConstant: 50)
            ])
            NSLayoutConstraint.activate([
                timeLabelView.timeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 3, constant: -15),
                timeLabelView.timeLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
            let timeLabelView2 = TimeLabelView(timeSlot: selectDateAndSlotViewModel.timeArray[index])
            timeLabelView2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewInStack2Tapped(sender:))))
            timeClassArraySocket2.append(timeLabelView2)
            stackView2Vertical.addArrangedSubview(timeLabelView2)
            NSLayoutConstraint.activate([
                timeLabelView2.widthAnchor.constraint(equalTo: stackView2Vertical.widthAnchor),
                timeLabelView2.heightAnchor.constraint(equalToConstant: 50)
            ])
            NSLayoutConstraint.activate([
                timeLabelView2.timeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 3, constant: -15),
                timeLabelView2.timeLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
            let timeLabelView3 = TimeLabelView(timeSlot: selectDateAndSlotViewModel.timeArray[index])
            timeLabelView3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewInStack3Tapped(sender:))))
            timeClassArraySocket3.append(timeLabelView3)
            stackView3Vertical.addArrangedSubview(timeLabelView3)
            NSLayoutConstraint.activate([
                timeLabelView3.widthAnchor.constraint(equalTo: stackView3Vertical.widthAnchor),
                timeLabelView3.heightAnchor.constraint(equalToConstant: 50)
            ])
            NSLayoutConstraint.activate([
                timeLabelView3.timeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 3, constant: -15),
                timeLabelView3.timeLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            appointmentDateLabel,
            datePickerLabel,
            stackViewHeaders,
            stackView1Vertical,
            stackView2Vertical,
            stackView3Vertical,
            stackViewHorizontal,
            scrollView,
            socket1ContainerView,
            socket1Label,
            type1Label,
            socket2ContainerView,
            socket2Label,
            type2Label,
            socket3ContainerView,
            socket3Label,
            type3Label,
            confirmButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.append(contentsOf: [
            appointmentDateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            appointmentDateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            datePickerLabel.centerYAnchor.constraint(equalTo: appointmentDateLabel.centerYAnchor),
            datePickerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            stackViewHeaders.topAnchor.constraint(equalTo: datePickerLabel.bottomAnchor, constant: 30),
            stackViewHeaders.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackViewHeaders.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackViewHeaders.heightAnchor.constraint(equalToConstant: 50),
            
            scrollView.topAnchor.constraint(equalTo: stackViewHeaders.bottomAnchor, constant: 5),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            stackViewHorizontal.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackViewHorizontal.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackViewHorizontal.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackViewHorizontal.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackViewHorizontal.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            stackView1Vertical.widthAnchor.constraint(equalTo: stackViewHorizontal.widthAnchor, multiplier: 1 / 3),
            stackView2Vertical.widthAnchor.constraint(equalTo: stackViewHorizontal.widthAnchor, multiplier: 1 / 3),
            stackView3Vertical.widthAnchor.constraint(equalTo: stackViewHorizontal.widthAnchor, multiplier: 1 / 3),
            
            socket1ContainerView.widthAnchor.constraint(equalTo: stackViewHeaders.widthAnchor, multiplier: 1 / 3),
            socket1ContainerView.heightAnchor.constraint(equalTo: stackViewHeaders.heightAnchor),
            
            socket2ContainerView.widthAnchor.constraint(equalTo: stackViewHeaders.widthAnchor, multiplier: 1 / 3),
            socket2ContainerView.heightAnchor.constraint(equalTo: stackViewHeaders.heightAnchor),
            
            socket3ContainerView.widthAnchor.constraint(equalTo: stackViewHeaders.widthAnchor, multiplier: 1 / 3),
            socket3ContainerView.heightAnchor.constraint(equalTo: stackViewHeaders.heightAnchor),
            
            socket1Label.bottomAnchor.constraint(equalTo: type1Label.topAnchor, constant: -3),
            socket1Label.centerXAnchor.constraint(equalTo: socket1ContainerView.centerXAnchor),
            type1Label.bottomAnchor.constraint(equalTo: socket1ContainerView.bottomAnchor, constant: -2),
            type1Label.centerXAnchor.constraint(equalTo: socket1ContainerView.centerXAnchor),
            
            socket2Label.bottomAnchor.constraint(equalTo: type2Label.topAnchor, constant: -3),
            socket2Label.centerXAnchor.constraint(equalTo: socket2ContainerView.centerXAnchor),
            type2Label.bottomAnchor.constraint(equalTo: socket2ContainerView.bottomAnchor, constant: -2),
            type2Label.centerXAnchor.constraint(equalTo: socket2ContainerView.centerXAnchor),
            
            socket3Label.bottomAnchor.constraint(equalTo: type3Label.topAnchor, constant: -3),
            socket3Label.centerXAnchor.constraint(equalTo: socket3ContainerView.centerXAnchor),
            type3Label.bottomAnchor.constraint(equalTo: socket3ContainerView.bottomAnchor, constant: -2),
            type3Label.centerXAnchor.constraint(equalTo: socket3ContainerView.centerXAnchor),
            
            confirmButton.heightAnchor.constraint(equalToConstant: 44),
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate(constraints) // activates constraints array
    }
    private func style() {
        appointmentDateLabel.text = "Randevu Tarihi"
        appointmentDateLabel.textColor = Theme.colorWhite()
        appointmentDateLabel.textAlignment = .left
        appointmentDateLabel.font = Theme.fontBold(size: 17)
        
        datePickerLabel.text = selectDateAndSlotViewModel.dateForDisplay
        datePickerLabel.textColor = Theme.colorWhite()
        datePickerLabel.textAlignment = .right
        datePickerLabel.font = Theme.fontNormal(size: 17)
        
        stackView1Vertical.axis = .vertical
        stackView1Vertical.distribution = .fill
        
        stackView2Vertical.axis = .vertical
        stackView2Vertical.distribution = .fill
        
        stackView3Vertical.axis = .vertical
        stackView3Vertical.distribution = .fill
        
        stackViewHeaders.axis = .horizontal
        stackViewHeaders.distribution = .fillEqually
        stackViewHeaders.alignment = .center
        
        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.distribution = .fillEqually
        stackViewHorizontal.alignment = .center
        
        socket1Label.font = Theme.fontBold(size: 17)
        socket1Label.textColor = Theme.colorWhite()
        socket1Label.text = "Soket 1"
        type1Label.font = Theme.fontNormal(size: 12)
        type1Label.textColor = Theme.colorWhite()
        
        socket2Label.font = Theme.fontBold(size: 17)
        socket2Label.textColor = Theme.colorWhite()
        socket2Label.text = "Soket 2"
        type2Label.font = Theme.fontNormal(size: 12)
        type2Label.textColor = Theme.colorWhite()
        
        socket3Label.font = Theme.fontBold(size: 17)
        socket3Label.textColor = Theme.colorWhite()
        socket3Label.text = "Soket 3"
        type3Label.font = Theme.fontNormal(size: 12)
        type3Label.textColor = Theme.colorWhite()
        
        confirmButton.setTitle("TARİH VE SAATİ ONAYLA", for: .normal)
        confirmButton.titleLabel?.font = Theme.fontBold(size: 15)
        confirmButton.setTitleColor(Theme.darkColor(), for: .normal)
        confirmButton.backgroundColor = Theme.colorCharcoalGrey()
        confirmButton.isUserInteractionEnabled = false
        confirmButton.layer.cornerRadius = 20
    }
    
    func initViewModel() {
        // Get stations data
        selectDateAndSlotViewModel.fetchAvaibleTimes()
        
        // Reload slots closure
        DispatchQueue.main.async {
            self.selectDateAndSlotViewModel.reloadSlots = { [weak self] in
                self?.updateSlots(slots: (self?.selectDateAndSlotViewModel.slots)!)
                self?.datePickerLabel.text = self?.selectDateAndSlotViewModel.dateForDisplay
            }
            self.selectDateAndSlotViewModel.reFetchData = { [weak self] in
                self?.confirmButton.backgroundColor = Theme.colorCharcoalGrey()
                self?.confirmButton.isUserInteractionEnabled = false
                self?.selectDateAndSlotViewModel.fetchAvaibleTimes()
            }
        }
    }
    func updateSlots(slots: [[Bool]]) {
        if(selectDateAndSlotViewModel.selectedStation.sockets?.count == 1) {
            socket2Label.isHidden = true
            type2Label.isHidden = true
            socket3Label.isHidden = true
            type3Label.isHidden = true
            stackView2Vertical.arrangedSubviews.forEach({ $0.alpha = 0 })
            stackView3Vertical.arrangedSubviews.forEach({ $0.alpha = 0 })
        }
        if(selectDateAndSlotViewModel.selectedStation.sockets?.count == 2) {
            socket3Label.isHidden = true
            type3Label.isHidden = true
            stackView3Vertical.arrangedSubviews.forEach({ $0.alpha = 0 })
        }
        
        for (index, item) in slots.enumerated() {
            if(index == 0 && item.count != 0) {
                type1Label.text = "\(selectDateAndSlotViewModel.selectedStation.sockets![0].chargeType!) * \(selectDateAndSlotViewModel.selectedStation.sockets![0].socketType!)"
                item.enumerated().forEach { (index,bool) in
                    if(bool == true) {
                        timeClassArraySocket1[index].timeLabel.backgroundColor = .clear
                        timeClassArraySocket1[index].timeLabel.layer.borderColor = Theme.colorCharcoalGrey().cgColor
                    } else {
                        timeClassArraySocket1[index].timeLabel.backgroundColor = Theme.colorCharcoalGrey()
                        timeClassArraySocket1[index].timeLabel.layer.borderColor = Theme.colorCharcoalGrey().cgColor
                    }
                }
            }
            if(index == 1 && item.count != 0) {
                type2Label.text = "\(selectDateAndSlotViewModel.selectedStation.sockets![1].chargeType!) * \(selectDateAndSlotViewModel.selectedStation.sockets![1].socketType!)"
                item.enumerated().forEach { (index,bool) in
                    if(bool == true) {
                        timeClassArraySocket2[index].timeLabel.backgroundColor = .clear
                        timeClassArraySocket2[index].timeLabel.layer.borderColor = Theme.colorCharcoalGrey().cgColor
                    }else {
                        timeClassArraySocket2[index].timeLabel.backgroundColor = Theme.colorCharcoalGrey()
                        timeClassArraySocket2[index].timeLabel.layer.borderColor = Theme.colorCharcoalGrey().cgColor
                    }
                }
            }
            if(index == 2 && item.count != 0) {
                type3Label.text = "\(selectDateAndSlotViewModel.selectedStation.sockets![2].chargeType!) * \(selectDateAndSlotViewModel.selectedStation.sockets![2].socketType!)"
                item.enumerated().forEach { (index,bool) in
                    if(bool == true) {
                        timeClassArraySocket3[index].timeLabel.backgroundColor = .clear
                        timeClassArraySocket3[index].timeLabel.layer.borderColor = Theme.colorCharcoalGrey().cgColor
                    }
                    else {
                        timeClassArraySocket3[index].timeLabel.backgroundColor = Theme.colorCharcoalGrey()
                        timeClassArraySocket3[index].timeLabel.layer.borderColor = Theme.colorCharcoalGrey().cgColor
                    }
                }
            }
        }
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
extension SelectDateAndSlotViewController {
    @objc func viewInStack1Tapped(sender: UITapGestureRecognizer) {
        confirmButton.backgroundColor = Theme.colorWhite()
        confirmButton.isUserInteractionEnabled = true
        if let senderView = sender.view as? TimeLabelView {
            if selectedView != nil {
                selectedView?.timeLabel.layer.borderColor = Theme.colorCharcoalGrey().cgColor
                selectedView?.timeLabel.backgroundColor = Theme.colorCharcoalGrey()
            }
            selectDateAndSlotViewModel.selectedTimeSlot = senderView.timeLabel.text!
            selectDateAndSlotViewModel.selectedSocketID = selectDateAndSlotViewModel.selectedStation.sockets![0].socketID!
            selectDateAndSlotViewModel.selectedSocketIndex = 0
            senderView.timeLabel.layer.borderColor = Theme.colorPrimary().cgColor
            senderView.timeLabel.backgroundColor = Theme.darkColor()
            selectedView = senderView
        }
    }
    @objc func viewInStack2Tapped(sender: UITapGestureRecognizer) {
        if let senderView = sender.view as? TimeLabelView {
            confirmButton.backgroundColor = Theme.colorWhite()
            confirmButton.isUserInteractionEnabled = true
            if selectedView != nil {
                selectedView?.timeLabel.layer.borderColor = Theme.colorCharcoalGrey().cgColor
                selectedView?.timeLabel.backgroundColor = Theme.colorCharcoalGrey()
            }
            selectDateAndSlotViewModel.selectedTimeSlot = senderView.timeLabel.text!
            selectDateAndSlotViewModel.selectedSocketID = selectDateAndSlotViewModel.selectedStation.sockets![1].socketID!
            selectDateAndSlotViewModel.selectedSocketIndex = 1
            senderView.timeLabel.layer.borderColor = Theme.colorPrimary().cgColor
            senderView.timeLabel.backgroundColor = Theme.darkColor()
            selectedView = senderView
        }
    }
    @objc func viewInStack3Tapped(sender: UITapGestureRecognizer) {
        if let senderView = sender.view as? TimeLabelView {
            confirmButton.backgroundColor = Theme.colorWhite()
            confirmButton.isUserInteractionEnabled = true
            if selectedView != nil {
                selectedView?.timeLabel.layer.borderColor = Theme.colorCharcoalGrey().cgColor
                selectedView?.timeLabel.backgroundColor = Theme.colorCharcoalGrey()
            }
            selectDateAndSlotViewModel.selectedTimeSlot = senderView.timeLabel.text!
            selectDateAndSlotViewModel.selectedSocketID = selectDateAndSlotViewModel.selectedStation.sockets![2].socketID!
            selectDateAndSlotViewModel.selectedSocketIndex = 2
            senderView.timeLabel.layer.borderColor = Theme.colorPrimary().cgColor
            senderView.timeLabel.backgroundColor = Theme.darkColor()
            selectedView = senderView
        }
    }
}
extension SelectDateAndSlotViewController {
    /// Sets Navigation Bar styles and items
    private func setNavigationBarItems() {
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "Tarih ve Saat Seçin"
        titleLabel.font = Theme.fontBold(size: 20)
        titleLabel.textColor = Theme.colorWhite()
        let subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = selectDateAndSlotViewModel.selectedStation.stationName?.localizedUppercase
        subtitleLabel.font = Theme.fontNormal(size: 12)
        subtitleLabel.textColor = Theme.colorGrayscale()
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        
        navigationItem.titleView = stackView
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal

    }
}
extension SelectDateAndSlotViewController {
    @objc func datePickerTapped(sender: UITapGestureRecognizer) {
        let datePickerVC = DatePickerViewController()
        datePickerVC.modalPresentationStyle = .pageSheet
        datePickerVC.datePickerViewModel.delegate = self.selectDateAndSlotViewModel
        navigationController?.pushViewController(datePickerVC, animated: true)
    }
}
extension SelectDateAndSlotViewController {
    @objc func confirmTapped(sender: UIButton) {
        let detailVC = AppointmentDetailViewController(station: selectDateAndSlotViewModel.selectedStation,
                                                       socketIndex: selectDateAndSlotViewModel.selectedSocketIndex,
                                                       timeSlot: selectDateAndSlotViewModel.selectedTimeSlot,
                                                       appointmentDate: selectDateAndSlotViewModel.date)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
