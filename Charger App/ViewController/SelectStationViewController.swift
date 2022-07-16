//
//  SelectStationViewController.swift
//  Charger App
//
//  Created by Doğukan Inci on 3.07.2022.
//

import Foundation
import UIKit

class SelectStationViewController: UIViewController {
    
    private let searchResultLabel = UILabel()
    private let searchAgainLabel = UILabel()
    
    private let searchBar = UISearchBar()
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        viewLayout.estimatedItemSize = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()
    private let resultLabel = UILabel()
    private let tableView = UITableView()
    
    private let selectStationViewModel: SelectStationViewModel
    
    var collectionViewActiveConstraint: [NSLayoutConstraint] = []
    var collectionViewDeactiveConstraint: [NSLayoutConstraint] = []
    
    init(viewModel: String) {
        // Create SelectStationViewModel with city info coming from
        //SelectCityViewController to SelectStationViewController seque
        self.selectStationViewModel = SelectStationViewModel(city: viewModel)
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
        setNavigationBarItems()
        initViewModel()
    }
    override func viewDidLayoutSubviews() {
        setGradientBackground()
    }
    /// Adds subviews to the SelectStationViewController view
    private func setup() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(resultLabel)
        view.addSubview(tableView)
        view.addSubview(searchResultLabel)
        view.addSubview(searchAgainLabel)
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: "filterTableViewCell")
        
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            searchBar,
            collectionView,
            resultLabel,
            tableView,
            searchResultLabel,
            searchAgainLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        collectionViewActiveConstraint.append(contentsOf: [
            
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalToConstant: 50),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            resultLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15),
            resultLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            resultLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
            
            searchResultLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 150),
            searchResultLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            searchResultLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            searchAgainLabel.topAnchor.constraint(equalTo: searchResultLabel.bottomAnchor, constant: 20),
            searchAgainLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            searchAgainLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            tableView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15)
        ])
        collectionViewDeactiveConstraint.append(contentsOf: [
            
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalToConstant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            resultLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15),
            resultLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            resultLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
            
            searchResultLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 150),
            searchResultLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            searchResultLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            searchAgainLabel.topAnchor.constraint(equalTo: searchResultLabel.bottomAnchor, constant: 20),
            searchAgainLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            searchAgainLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            tableView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate(collectionViewDeactiveConstraint) // activates constraints array
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
        searchBar.placeholder = "İstasyon Ara"
        // Clear unnecessary background
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.layer.cornerRadius = 18
        // magnifying glass icon color
        searchBar.searchTextField.leftView?.tintColor = Theme.colorWhite()
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.borderColor = Theme.colorWhite().cgColor
        searchBar.searchTextField.textColor = Theme.colorWhite()
        searchBar.searchTextField.backgroundColor = Theme.darkColor()
        searchBar.autocapitalizationType = .none
        searchBar.searchTextField.clipsToBounds = true
        searchBar.keyboardType = .alphabet
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = false
        
        resultLabel.textColor = Theme.colorWhite()
        resultLabel.textAlignment = .left
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = Theme.colorGrayscale()
        // clear head inset
        tableView.separatorInset = .zero
        tableView.rowHeight = 44
        tableView.layer.cornerRadius = 7
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        searchResultLabel.text = "Aramanız ile eşleşen bir sonuç bulunamadı."
        searchResultLabel.font = Theme.fontBold(size: 30)
        searchResultLabel.numberOfLines = 0
        searchResultLabel.textColor = Theme.colorWhite()
        searchResultLabel.textAlignment = .center
        
        searchAgainLabel.text = "Lütfen yeni bir arama yapın."
        searchAgainLabel.textColor = Theme.colorGrayscale()
        searchAgainLabel.font = Theme.fontNormal(size: 15)
        searchAgainLabel.numberOfLines = 0
        searchAgainLabel.textAlignment = .center
        
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        searchResultLabel.isHidden = true
        searchAgainLabel.isHidden = true
        tableView.isHidden = false
        
    }
    func initViewModel() {
        // Get stations data
        selectStationViewModel.fetchStations()
        
        // Reload TableView closure
        DispatchQueue.main.async {
            self.selectStationViewModel.reloadTableView = { [weak self] in
                self?.tableView.reloadData()
                self?.updateResultTitle(city: (self?.selectStationViewModel.city!)!,
                                        filteredStationCount: (self?.selectStationViewModel.filteredStations.count)!)
            }
        }
        // Reload collectionView closure
        DispatchQueue.main.async {
            self.selectStationViewModel.reloadCollectionView = { [weak self] in
                self?.collectionView.reloadData()
                if (self?.selectStationViewModel.collectionViewDataArray.count != 0) {
                NSLayoutConstraint.deactivate(self!.collectionViewDeactiveConstraint)
                NSLayoutConstraint.activate(self!.collectionViewActiveConstraint)
                } else {
                    NSLayoutConstraint.activate(self!.collectionViewDeactiveConstraint)
                    NSLayoutConstraint.deactivate(self!.collectionViewActiveConstraint)
                }
            }
        }
    }
    /// Update result title
    func updateResultTitle(city: String, filteredStationCount: Int) {
        let cityString = NSMutableAttributedString(string: "'\(city) '"
                                                   ,attributes: [ NSAttributedString.Key.font: Theme.fontBold(size: 15) ])
        let descriptionString = NSMutableAttributedString(string: "şehri için \(filteredStationCount) sonuç görüntüleniyor."
                                                          , attributes: [ NSAttributedString.Key.font: Theme.fontNormal(size: 15) ])
        cityString.append(descriptionString)
        resultLabel.attributedText = cityString
    }
}
extension SelectStationViewController {
    /// Table View, Collection View, Search Bar Delegation
    private func delegation() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
extension SelectStationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectStationViewModel.filteredStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterTableViewCell", for: indexPath) as! FilterTableViewCell
        cell.stationName.text = selectStationViewModel.filteredStations[indexPath.row].stationName
        cell.socketTypeImageView.image = UIImage(named: findStationTypeImage(station: selectStationViewModel.filteredStations[indexPath.row]))
        cell.avaibleTimePlaceholderLabel.text = "Hizmet saatleri:"
        cell.avaibleTimeLabel.text = "24 Saat"
        cell.avaibleSocketNumberPlaceholderLabel.text = "Uygun soket sayısı:"
        cell.avaibleSocketNumberLabel.text = "\(selectStationViewModel.filteredStations[indexPath.row].socketCount! - (selectStationViewModel.filteredStations[indexPath.row].occupiedSocketCount!)) / \(selectStationViewModel.filteredStations[indexPath.row].socketCount!)"
        if LocationManager.shared.getLatitude() == nil {
            cell.distanceLabel.text = ""
        } else {
            cell.distanceLabel.text = String(format: "%.1f", selectStationViewModel.filteredStations[indexPath.row].distanceInKM ?? 0) + " km"
        }

        // Remove selection effect
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = selectStationViewModel.filteredStations[indexPath.row]
        let selectDateVC = SelectDateAndSlotViewController(viewModel: station)
        navigationController?.pushViewController(selectDateVC, animated: true)
    }
    
}
extension SelectStationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        selectStationViewModel.filterArrayViaSearchBarText(searchBarText: searchText)
        if(searchText == "") {
            searchBar.searchTextField.layer.borderColor = Theme.colorWhite().cgColor
        } else {
            if (selectStationViewModel.filteredStations.count == 0) {
                searchBar.searchTextField.layer.borderColor = Theme.colorSecurityOn().cgColor
                searchResultLabel.isHidden = false
                searchAgainLabel.isHidden = false
                tableView.isHidden = true
            } else {
                searchBar.searchTextField.layer.borderColor = Theme.colorPrimary().cgColor
                searchResultLabel.isHidden = true
                searchAgainLabel.isHidden = true
                tableView.isHidden = false
            }
        }
    }
}
extension SelectStationViewController: UICollectionViewDelegate, UICollectionViewDataSource,
                                       UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectStationViewModel.collectionViewDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell",
                                                      for: indexPath) as! FilterCollectionViewCell
        cell.filterTitle.text = selectStationViewModel.collectionViewDataArray[indexPath.row]
        cell.cancelButton.tag = indexPath.row
        cell.cancelButton.addTarget(self, action: #selector(filterCancelItemTapped(sender:)), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (selectStationViewModel.collectionViewDataArray[indexPath.row] as NSString).size(withAttributes: [NSAttributedString.Key.font: Theme.fontNormal(size: 13)])
        return CGSize(width: size.width + 50, height: size.height + 15)
    }
}
extension SelectStationViewController {
    /// Sets Navigation Bar styles and items
    private func setNavigationBarItems() {
        navigationItem.title = "İstasyon Seçin"
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filterButton
    }
}
extension SelectStationViewController {
    @objc func filterButtonTapped() {
        let filterVC = FilterViewController(viewModel: selectStationViewModel.filterDataSender)
        filterVC.filterViewModel.delegate = self.selectStationViewModel
        navigationController?.pushViewController(filterVC, animated: true)
    }
}
extension SelectStationViewController {
    /// Find image by searching stations charge type array
    /// - Parameter station: StationElement
    /// - Returns: String
    private func findStationTypeImage(station: StationElement) -> String{
        if let socket = station.sockets {
            if(socket.contains(where: { $0.chargeType?.rawValue == "AC" })) {
                if(socket.contains(where: { $0.chargeType?.rawValue == "DC" })) {
                    return "acdc"
                }
            }
            if(socket.contains(where: { $0.chargeType?.rawValue == "AC" })) {
                return "ac"
            }
        }
        return "dc"
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
extension SelectStationViewController {
    @objc func filterCancelItemTapped(sender: UIButton) {
        selectStationViewModel.removeItem(item: selectStationViewModel.collectionViewDataArray[sender.tag])
        selectStationViewModel.collectionViewDataArray.remove(at: sender.tag)
    }
}

