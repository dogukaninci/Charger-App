//
//  DatePickerViewController.swift
//  Charger App
//
//  Created by Doğukan Inci on 9.07.2022.
//

import Foundation
import UIKit

class DatePickerViewController: UIViewController {
    
    let datePicker = UIDatePicker()
    
    let datePickerViewModel: DatePickerViewModel
    
    init() {
        self.datePickerViewModel = DatePickerViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        datePickerViewModel.saveDate(date: datePicker.date)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    func configure() {
        view.addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.timeZone = NSTimeZone.local
        datePicker.setValue(false, forKey: "highlightsToday")
        datePicker.setValue(Theme.colorWhite(), forKey: "textColor")
        
    }
}
