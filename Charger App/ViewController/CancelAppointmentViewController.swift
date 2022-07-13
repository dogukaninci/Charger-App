//
//  InvalidDateViewController.swift
//  Charger App
//
//  Created by Doğukan Inci on 13.07.2022.
//

import Foundation
import UIKit

/// Delegate Protocol
protocol CancelAppointmentVCProtocol {
    func isCancelButton(cancelButton: Bool)
}

class CancelAppointmentViewController: UIViewController {
    
    var buttonDelegate: CancelAppointmentVCProtocol? = nil
    
    private let containerView = UIView()
    private let logo = UIImageView()
    private let cancelPlacaholderLabel = UILabel()
    var cancelDetailLabel = UILabel()
    private let cancelAppointmentButton = UIButton()
    private let escapeButton = UIButton()
    private var attributedString: NSMutableAttributedString!
    
    
    private var cancelAppointmentViewModel: CancelAppointmentViewModel
    
    var constraints: [NSLayoutConstraint] = []
    
    init(appointment: Appointment) {
        // Create CancelApppointmentViewController with appointment info coming from
        //AppointmnetsViewController to CancelAppointmentViewController seque
        self.cancelAppointmentViewModel = CancelAppointmentViewModel(appointment: appointment)
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
    }
    /// Adds subviews to the InvalidDateViewController view
    private func setup() {
        containerView.addSubview(logo)
        containerView.addSubview(cancelPlacaholderLabel)
        containerView.addSubview(cancelDetailLabel)
        containerView.addSubview(cancelAppointmentButton)
        containerView.addSubview(escapeButton)
        view.addSubview(containerView)
        
        cancelAppointmentButton.addTarget(self, action: #selector(cancelAppointmentButtonTapped), for: .touchUpInside)
        escapeButton.addTarget(self, action: #selector(escapeButtonTapped), for: .touchUpInside)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            containerView,
            logo,
            cancelPlacaholderLabel,
            cancelDetailLabel,
            cancelAppointmentButton,
            escapeButton
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
            
            cancelPlacaholderLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 50),
            cancelPlacaholderLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            cancelDetailLabel.topAnchor.constraint(equalTo: cancelPlacaholderLabel.bottomAnchor, constant: 20),
            cancelDetailLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -50),
            cancelDetailLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 50),
            
            cancelAppointmentButton.heightAnchor.constraint(equalToConstant: 44),
            cancelAppointmentButton.bottomAnchor.constraint(equalTo: escapeButton.topAnchor, constant: -20),
            cancelAppointmentButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 50),
            cancelAppointmentButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -50),
            
            escapeButton.heightAnchor.constraint(equalToConstant: 44),
            escapeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -50),
            escapeButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 50),
            escapeButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -50)
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
        
        cancelPlacaholderLabel.text = "Randevu iptali"
        cancelPlacaholderLabel.font = Theme.fontBold(size: 18)
        cancelPlacaholderLabel.numberOfLines = 0
        cancelPlacaholderLabel.textColor = Theme.colorWhite()
        cancelPlacaholderLabel.textAlignment = .center
        
        attributedString = NSMutableAttributedString(string: "\(cancelAppointmentViewModel.appointment.stationName!) istasyonundaki \(cancelAppointmentViewModel.getDateWithFormat(date: cancelAppointmentViewModel.appointment.date!)) saat \(cancelAppointmentViewModel.appointment.time!) randevunuz iptal edilecektir.").withLineSpacing(5)
        cancelDetailLabel.textColor = Theme.colorWhite()
        cancelDetailLabel.font = Theme.fontNormal(size: 15)
        cancelDetailLabel.numberOfLines = 0
        cancelDetailLabel.textAlignment = .center
        cancelDetailLabel.attributedText = attributedString
        cancelDetailLabel.textAlignment = .center
        
        cancelAppointmentButton.setTitle("RANDEVUYU İPTAL ET", for: .normal)
        cancelAppointmentButton.titleLabel?.font = Theme.fontBold(size: 15)
        cancelAppointmentButton.setTitleColor(Theme.darkColor(), for: .normal)
        cancelAppointmentButton.backgroundColor = Theme.colorWhite()
        cancelAppointmentButton.layer.cornerRadius = 20
        
        escapeButton.setTitle("VAZGEÇ", for: .normal)
        escapeButton.titleLabel?.font = Theme.fontBold(size: 15)
        escapeButton.setTitleColor(Theme.colorWhite(), for: .normal)
        escapeButton.backgroundColor = .clear
        escapeButton.layer.cornerRadius = 20
        escapeButton.layer.borderWidth = 1
        escapeButton.layer.borderColor = Theme.colorGrayscale().cgColor
        
    }
}
extension CancelAppointmentViewController {
    @objc func cancelAppointmentButtonTapped() {
        dismiss(animated: true) {
            self.buttonDelegate?.isCancelButton(cancelButton: true)
        }
    }
    @objc func escapeButtonTapped() {
        dismiss(animated: true) {
            self.buttonDelegate?.isCancelButton(cancelButton: false)
        }
    }
}
extension NSMutableAttributedString {
    func withLineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSMutableAttributedString(attributedString: attributedString)
    }
}

