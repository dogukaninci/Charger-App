//
//  FilterViewController.swift
//  Charger App
//
//  Created by Doğukan Inci on 6.07.2022.
//

import Foundation
import UIKit


class FilterViewController: UIViewController {
    
    private let chargeTypeLabel = UILabel()
    
    private let chargeTypeCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        viewLayout.estimatedItemSize = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()
    
    private let socketTypeLabel = UILabel()
    
    private let socketTypeCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        viewLayout.estimatedItemSize = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()
    
    private let distanceLabel = UILabel()
    private let slideBar = UISlider()
    private let sliderLabelStackView = UIStackView()
    private let sliderValue1 = UILabel(), sliderValue2 = UILabel(), sliderValue3 = UILabel(), sliderValue4 = UILabel(), sliderValue5 = UILabel()
    private let servicesLabel = UILabel()
    
    private let servicesCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        viewLayout.estimatedItemSize = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()
    
    private let filterButton = UIButton()
    
    var constraints: [NSLayoutConstraint] = []
    
    let filterViewModel: FilterViewModel
    
    init(viewModel: FilterDataSender) {
        // Create FilterViewModel with filtered info coming from
        //SelectStationViewController to FilterViewController seque
        self.filterViewModel = FilterViewModel(filtered: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        delegation()
        setupConstraints()
        style()
        setGradientBackground()
        setNavigationBarItems()
    }
    /// Adds subviews to the FilterViewController view
    private func setup() {
        view.addSubview(chargeTypeLabel)
        view.addSubview(chargeTypeCollectionView)
        view.addSubview(socketTypeLabel)
        view.addSubview(socketTypeCollectionView)
        view.addSubview(distanceLabel)
        view.addSubview(slideBar)
        view.addSubview(servicesLabel)
        view.addSubview(servicesCollectionView)
        view.addSubview(filterButton)
        sliderLabelStackView.addArrangedSubview(sliderValue1)
        sliderLabelStackView.addArrangedSubview(sliderValue2)
        sliderLabelStackView.addArrangedSubview(sliderValue3)
        sliderLabelStackView.addArrangedSubview(sliderValue4)
        sliderLabelStackView.addArrangedSubview(sliderValue5)
        view.addSubview(sliderLabelStackView)
        
        chargeTypeCollectionView.register(FilterViewControllerCell.self, forCellWithReuseIdentifier: "filterViewControllerCell")
        socketTypeCollectionView.register(FilterViewControllerCell.self, forCellWithReuseIdentifier: "filterViewControllerCell")
        servicesCollectionView.register(FilterViewControllerCell.self, forCellWithReuseIdentifier: "filterViewControllerCell")
        
        slideBar.addTarget(self, action: #selector(sliderValueChanged), for: UIControl.Event.valueChanged)
        
        filterButton.addTarget(self, action: #selector(filterTapped(sender:)), for: .touchUpInside)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            chargeTypeLabel,
            chargeTypeCollectionView,
            socketTypeLabel,
            socketTypeCollectionView,
            distanceLabel,
            slideBar,
            servicesLabel,
            servicesCollectionView,
            filterButton,
            sliderLabelStackView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.append(contentsOf: [
            
            chargeTypeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            chargeTypeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            chargeTypeCollectionView.topAnchor.constraint(equalTo: chargeTypeLabel.bottomAnchor, constant: 10),
            chargeTypeCollectionView.heightAnchor.constraint(equalToConstant: 50),
            chargeTypeCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            chargeTypeCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            socketTypeLabel.topAnchor.constraint(equalTo: chargeTypeCollectionView.bottomAnchor, constant: 10),
            socketTypeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            socketTypeCollectionView.topAnchor.constraint(equalTo: socketTypeLabel.bottomAnchor, constant: 10),
            socketTypeCollectionView.heightAnchor.constraint(equalToConstant: 50),
            socketTypeCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            socketTypeCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            distanceLabel.topAnchor.constraint(equalTo: socketTypeCollectionView.bottomAnchor, constant: 10),
            distanceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            slideBar.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 10),
            slideBar.heightAnchor.constraint(equalToConstant: 80),
            slideBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            slideBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            sliderLabelStackView.topAnchor.constraint(equalTo: slideBar.bottomAnchor, constant: -17),
            sliderLabelStackView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            sliderLabelStackView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            
            servicesLabel.topAnchor.constraint(equalTo: sliderLabelStackView.bottomAnchor, constant: 20),
            servicesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            servicesCollectionView.topAnchor.constraint(equalTo: servicesLabel.bottomAnchor, constant: 10),
            servicesCollectionView.heightAnchor.constraint(equalToConstant: 50),
            servicesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            servicesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            filterButton.heightAnchor.constraint(equalToConstant: 44),
            filterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            filterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            filterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate(constraints) // activates constraints array
    }
    private func style(){
        chargeTypeLabel.text = "Cihaz Tipi"
        chargeTypeLabel.textColor = Theme.colorWhite()
        chargeTypeLabel.textAlignment = .left
        chargeTypeLabel.font = Theme.fontBold(size: 28)
        
        socketTypeLabel.text = "Soket Tipi"
        socketTypeLabel.textColor = Theme.colorWhite()
        socketTypeLabel.textAlignment = .left
        socketTypeLabel.font = Theme.fontBold(size: 28)
        
        distanceLabel.text = "Uzaklık (km)"
        distanceLabel.textColor = Theme.colorWhite()
        distanceLabel.textAlignment = .left
        distanceLabel.font = Theme.fontBold(size: 28)
        
        servicesLabel.text = "Hizmetler"
        servicesLabel.textColor = Theme.colorWhite()
        servicesLabel.textAlignment = .left
        servicesLabel.font = Theme.fontBold(size: 28)
        
        chargeTypeCollectionView.frame = view.bounds
        chargeTypeCollectionView.backgroundColor = .clear
        
        socketTypeCollectionView.frame = view.bounds
        socketTypeCollectionView.backgroundColor = .clear
        
        servicesCollectionView.frame = view.bounds
        servicesCollectionView.backgroundColor = .clear
        
        filterButton.setTitle("FİLTRELE", for: .normal)
        filterButton.titleLabel?.font = Theme.fontBold(size: 15)
        filterButton.setTitleColor(Theme.darkColor(), for: .normal)
        filterButton.backgroundColor = Theme.colorWhite()
        filterButton.layer.cornerRadius = 20
        
        slideBar.isContinuous = false
        slideBar.minimumValue = 0
        slideBar.maximumValue = 15
        slideBar.value = 15
        slideBar.tintColor = Theme.colorPrimary()
        
        sliderValue1.text = "3"
        sliderValue2.text = "6"
        sliderValue3.text = "9"
        sliderValue4.text = "12"
        sliderValue5.text = "15+"
        
        sliderValue1.textColor = Theme.colorWhite()
        sliderValue2.textColor = Theme.colorWhite()
        sliderValue3.textColor = Theme.colorWhite()
        sliderValue4.textColor = Theme.colorWhite()
        sliderValue5.textColor = Theme.colorWhite()
        
        sliderValue1.font = Theme.fontNormal(size: 16)
        sliderValue2.font = Theme.fontNormal(size: 16)
        sliderValue3.font = Theme.fontNormal(size: 16)
        sliderValue4.font = Theme.fontNormal(size: 16)
        sliderValue5.font = Theme.fontNormal(size: 16)
        
        
        sliderLabelStackView.axis = .horizontal
        sliderLabelStackView.distribution = .equalCentering
        sliderLabelStackView.alignment = .center
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
extension FilterViewController {
    /// Collection View, Search Bar Delegation
    private func delegation() {
        chargeTypeCollectionView.dataSource = self
        chargeTypeCollectionView.delegate = self
        socketTypeCollectionView.dataSource = self
        socketTypeCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        servicesCollectionView.delegate = self
    }
}
extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.chargeTypeCollectionView {
            return filterViewModel.filterDataSender.chargeTypesArrData.count
        } else if collectionView == self.socketTypeCollectionView {
            return filterViewModel.filterDataSender.socketTypesArrData.count
        } else {
            return filterViewModel.filterDataSender.serviceTypesArrData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.chargeTypeCollectionView {
            let cell = chargeTypeCollectionView.dequeueReusableCell(withReuseIdentifier: "filterViewControllerCell", for: indexPath) as! FilterViewControllerCell
            cell.filterTitle.text = filterViewModel.filterDataSender.chargeTypesArrData[indexPath.row]
            if filterViewModel.filterDataSender.chargeTypesArrSelectedIndex.contains(indexPath.row) {
                cell.layer.borderColor = Theme.colorPrimary().cgColor
            } else {
                cell.layer.borderColor = Theme.colorGrayscale().cgColor
            }
            return cell
        } else if collectionView == self.socketTypeCollectionView {
            let cell = socketTypeCollectionView.dequeueReusableCell(withReuseIdentifier: "filterViewControllerCell", for: indexPath) as! FilterViewControllerCell
            cell.filterTitle.text = filterViewModel.filterDataSender.socketTypesArrData[indexPath.row]
            if filterViewModel.filterDataSender.socketTypesArrSelectedIndex.contains(indexPath.row) {
                cell.layer.borderColor = Theme.colorPrimary().cgColor
            } else {
                cell.layer.borderColor = Theme.colorGrayscale().cgColor
            }
            return cell
        } else {
            let cell = servicesCollectionView.dequeueReusableCell(withReuseIdentifier: "filterViewControllerCell", for: indexPath) as! FilterViewControllerCell
            cell.filterTitle.text = filterViewModel.filterDataSender.serviceTypesArrData[indexPath.row]
            if filterViewModel.filterDataSender.serviceTypesArrSelectedIndex.contains(indexPath.row) {
                cell.layer.borderColor = Theme.colorPrimary().cgColor
            } else {
                cell.layer.borderColor = Theme.colorGrayscale().cgColor
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.chargeTypeCollectionView {
            let size = (self.filterViewModel.filterDataSender.chargeTypesArrData[indexPath.row] as NSString).size(withAttributes: [NSAttributedString.Key.font: Theme.fontNormal(size: 15)])
            return CGSize(width: size.width + 30, height: size.height + 15)
        } else if collectionView == self.socketTypeCollectionView {
            let size = (self.filterViewModel.filterDataSender.socketTypesArrData[indexPath.row] as NSString).size(withAttributes: [NSAttributedString.Key.font: Theme.fontNormal(size: 15)])
            return CGSize(width: size.width + 30, height: size.height + 15)
        } else {
            let size = (self.filterViewModel.filterDataSender.serviceTypesArrData[indexPath.row] as NSString).size(withAttributes: [NSAttributedString.Key.font: Theme.fontNormal(size: 15)])
            return CGSize(width: size.width + 30, height: size.height + 15)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.chargeTypeCollectionView {
            let strData = filterViewModel.filterDataSender.chargeTypesArrData[indexPath.row]
            if filterViewModel.filterDataSender.chargeTypesArrSelectedIndex.contains(indexPath.row) {
                filterViewModel.filterDataSender.chargeTypesArrSelectedIndex = filterViewModel.filterDataSender.chargeTypesArrSelectedIndex.filter { $0 != indexPath.row}
                filterViewModel.filterDataSender.chargeTypesArrSelectedData = filterViewModel.filterDataSender.chargeTypesArrSelectedData.filter { $0 != strData}
            }
            else {
                filterViewModel.filterDataSender.chargeTypesArrSelectedIndex.append(indexPath.row)
                filterViewModel.filterDataSender.chargeTypesArrSelectedData.append(strData)
            }
            collectionView.reloadData()
        } else if collectionView == self.socketTypeCollectionView {
            let strData = filterViewModel.filterDataSender.socketTypesArrData[indexPath.row]
            if filterViewModel.filterDataSender.socketTypesArrSelectedIndex.contains(indexPath.row) {
                filterViewModel.filterDataSender.socketTypesArrSelectedIndex = filterViewModel.filterDataSender.socketTypesArrSelectedIndex.filter { $0 != indexPath.row}
                filterViewModel.filterDataSender.socketTypesArrSelectedData = filterViewModel.filterDataSender.socketTypesArrSelectedData.filter { $0 != strData}
            }
            else {
                filterViewModel.filterDataSender.socketTypesArrSelectedIndex.append(indexPath.row)
                filterViewModel.filterDataSender.socketTypesArrSelectedData.append(strData)
            }
            collectionView.reloadData()
        } else {
            let strData = filterViewModel.filterDataSender.serviceTypesArrData[indexPath.row]
            if filterViewModel.filterDataSender.serviceTypesArrSelectedIndex.contains(indexPath.row) {
                filterViewModel.filterDataSender.serviceTypesArrSelectedIndex = filterViewModel.filterDataSender.serviceTypesArrSelectedIndex.filter { $0 != indexPath.row}
                filterViewModel.filterDataSender.serviceTypesArrSelectedData = filterViewModel.filterDataSender.serviceTypesArrSelectedData.filter { $0 != strData}
            }
            else {
                filterViewModel.filterDataSender.serviceTypesArrSelectedIndex.append(indexPath.row)
                filterViewModel.filterDataSender.serviceTypesArrSelectedData.append(strData)
            }
            collectionView.reloadData()
        }
    }
}
extension FilterViewController {
    @objc func sliderValueChanged() {
        filterViewModel.filterDataSender.sliderValue = self.slideBar.value
    }
}
extension FilterViewController {
    @objc func filterTapped(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
extension FilterViewController {
    /// Sets Navigation Bar styles and items
    private func setNavigationBarItems() {
        navigationItem.title = "Filtreleme"
        let clearButton = UIBarButtonItem(title: "TEMİZLE", style: .plain, target: self, action: #selector(clearButtonTapped))
        navigationItem.rightBarButtonItem = clearButton
    }
}
extension FilterViewController {
    @objc func clearButtonTapped() {
        filterViewModel.filterDataSender.chargeTypesArrSelectedIndex.removeAll()
        filterViewModel.filterDataSender.chargeTypesArrSelectedData.removeAll()
        filterViewModel.filterDataSender.socketTypesArrSelectedIndex.removeAll()
        filterViewModel.filterDataSender.socketTypesArrSelectedData.removeAll()
        filterViewModel.filterDataSender.serviceTypesArrSelectedIndex.removeAll()
        filterViewModel.filterDataSender.serviceTypesArrSelectedData.removeAll()
        filterViewModel.filterDataSender.sliderValue = 15
        slideBar.value = 15
        chargeTypeCollectionView.reloadData()
        socketTypeCollectionView.reloadData()
        servicesCollectionView.reloadData()
        
    }
}
