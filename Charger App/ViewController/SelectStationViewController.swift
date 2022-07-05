//
//  SelectStationViewController.swift
//  Charger App
//
//  Created by Doğukan Inci on 3.07.2022.
//

import Foundation
import UIKit

class SelectStationViewController: UIViewController {
    
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
    
    var items = ["Type 2","CSS", "6 km", "asdasdasdadasdsadad"]
    
    var constraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        delegation()
        setupConstraints()
        style()
        setNavigationBarItems()
    }
    override func viewDidLayoutSubviews() {
        setGradientBackground()
    }
    /// Adds subviews to the AppointmentsViewController view
    private func setup() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(resultLabel)
        view.addSubview(tableView)
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: "filterTableViewCell")
        
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            searchBar,
            collectionView,
            resultLabel,
            tableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.append(contentsOf: [
            
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
            
            tableView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15)
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
        
        let resultString = NSMutableAttributedString(string: "'İstanbul' şehri için 3 sonuç görüntüleniyor.")
        let stringRange = NSRange(location: 0, length: 9) // range starting at location 0 with a lenth of 9: "Charger'a"
        resultString.addAttribute(NSAttributedString.Key.font, value: Theme.fontBold(size: 20), range: stringRange)
        resultLabel.attributedText = resultString
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
        
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
    }
}
extension SelectStationViewController {
    /// Table View Delegation
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterTableViewCell", for: indexPath) as! FilterTableViewCell
        cell.stationName.text = "Kanyon AVM, Levent"
        cell.socketTypeImageView.image = UIImage(named: "avatar")
        cell.avaibleTimePlaceholderLabel.text = "Hizmet saatleri:"
        cell.avaibleTimeLabel.text = "24 Saat"
        cell.avaibleSocketNumberPlaceholderLabel.text = "Uygun soket sayısı:"
        cell.avaibleSocketNumberLabel.text = "3/3"
        cell.distanceLabel.text = "1.4 km"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
extension SelectStationViewController: UISearchBarDelegate {
    
}
extension SelectStationViewController: UICollectionViewDelegate, UICollectionViewDataSource,
                                       UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell",
                                                      for: indexPath) as! FilterCollectionViewCell
        cell.filterTitle.text = items[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.items[indexPath.row] as NSString).size(withAttributes: [NSAttributedString.Key.font: Theme.fontNormal(size: 13)])
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
        print("filtertapped")
    }
}

