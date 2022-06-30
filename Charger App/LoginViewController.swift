//
//  ViewController.swift
//  Charger App
//
//  Created by Doğukan Inci on 30.06.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let welcomeLabel = UILabel()
    private let welcomeDescriptionLabel = UILabel()
    private let emailTextField = UITextField()
    private let loginButton = UIButton()
    
    var constraints: [NSLayoutConstraint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldDelegate()
        addGestureRecognizerToView()
        addKeyboardNotificationObserver()
        setup()
        setupConstraints()
        style()
        setNavigationBarItems()
        
    }
    override func viewDidLayoutSubviews() {
        emailTextField.addBottomBorder()
    }
    
    /// Adds subviews to the LoginViewController view
    private func setup() {
        view.addSubview(welcomeLabel)
        view.addSubview(welcomeDescriptionLabel)
        view.addSubview(emailTextField)
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func style(){
        if let backgroundImage = UIImage(named: "background") {
            view.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        
        let welcomeString = NSMutableAttributedString(string: "Charger'a hoş geldiniz.")
        let stringRange = NSRange(location: 0, length: 9) // range starting at location 0 with a lenth of 9: "Charger'a"
        welcomeString.addAttribute(NSAttributedString.Key.font, value: Theme.fontBold(size: 22), range: stringRange)
        welcomeLabel.attributedText = welcomeString
        welcomeLabel.textColor = Theme.colorMain()
        welcomeLabel.textAlignment = .center
        
        welcomeDescriptionLabel.text = "Charger'ı kullanmak için giriş yapmanız gerekiyor."
        welcomeDescriptionLabel.textColor = Theme.colorAux()
        welcomeDescriptionLabel.font = Theme.fontNormal(size: 15)
        welcomeDescriptionLabel.numberOfLines = 0
        welcomeDescriptionLabel.textAlignment = .center
        
        let welcomeDescriptionString = NSAttributedString(string: "E-POSTA ADRESİNİZ", attributes: [NSAttributedString.Key.foregroundColor : Theme.colorAux()])
        emailTextField.attributedPlaceholder = welcomeDescriptionString
        emailTextField.font = Theme.fontNormal(size: 15)
        emailTextField.textColor = Theme.colorMain()
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.borderStyle = .none
        emailTextField.returnKeyType = .done
        
        loginButton.setTitle("GİRİŞ YAP", for: .normal)
        loginButton.titleLabel?.font = Theme.fontBold(size: 15)
        loginButton.setTitleColor(Theme.colorThird(), for: .normal)
        loginButton.backgroundColor = Theme.colorMain()
        loginButton.layer.cornerRadius = 20
    }
    
    /// Setups view components constraints
    private func setupConstraints() {
        [
            welcomeLabel,
            welcomeDescriptionLabel,
            emailTextField,
            loginButton
        ].forEach {
          $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.append(contentsOf: [
            
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            welcomeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            welcomeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            welcomeDescriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            welcomeDescriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            welcomeDescriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            emailTextField.topAnchor.constraint(equalTo: welcomeDescriptionLabel.bottomAnchor, constant: 100),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate(constraints) // activates constraints array
    }

}
extension UITextField {
    /// Draw thin bottom line to the TextField object
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = Theme.colorAux().cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
extension LoginViewController {
    /// Shifts view y point relative to keyboard height and button height
    /// - Parameter sender: NSNotification
    @objc func keyboardWillShow(sender: NSNotification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let bottomSpace = self.view.frame.height - (loginButton.frame.origin.y + loginButton.frame.height)
            view.frame.origin.y -= keyboardHeight - bottomSpace
        }
         
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        hideKeyboardOperation()
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
}
extension LoginViewController {
    /// Hide Keyboard
    @objc func hideKeyboard() {
        emailTextField.resignFirstResponder()
    }
}
extension LoginViewController {
    /// Restores view's y point when keyboard disappears
    private func hideKeyboardOperation() {
        view.frame.origin.y = 0
    }
}
extension LoginViewController {
    /// Registers to the keyboard's notification
    private func addKeyboardNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
extension LoginViewController {
    /// Touching anywhere in the view closes the keyboard
    private func addGestureRecognizerToView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
}
extension LoginViewController {
    /// TextField delegation
    private func setTextFieldDelegate() {
        emailTextField.delegate = self
    }
}
extension LoginViewController {
    @objc func loginButtonTapped() {

    }
}
extension LoginViewController {
    private func setNavigationBarItems() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Theme.navBarColor()
        appearance.titleTextAttributes = [.foregroundColor: Theme.colorMain(),.font: Theme.fontBold(size: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.title = "Giriş Yapın"

    }
}

