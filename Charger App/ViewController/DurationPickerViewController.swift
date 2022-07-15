//
//  DatePickerViewController.swift
//  Charger App
//
//  Created by Doğukan Inci on 14.07.2022.
//

import Foundation
import UIKit

class DurationPickerViewController: UIViewController {
    
    let timePicker = UIPickerView()
    
    let durationPickerViewModel: DurationPickerViewModel
    
    init() {
        self.durationPickerViewModel = DurationPickerViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        durationPickerViewModel.saveDuration(duration: durationPickerViewModel.timeArray[timePicker.selectedRow(inComponent: 0)])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    func configure() {
        timePicker.delegate = self
        
        view.addSubview(timePicker)
        
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        
        timePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        timePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        timePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        timePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        timePicker.selectRow(3, inComponent: 0, animated: true)
        timePicker.setValue(Theme.colorWhite(), forKey: "textColor")
        
    }
}
extension DurationPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durationPickerViewModel.timeArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = durationPickerViewModel.timeArray[row]
           return row
    }
    
    
}
