//
//  ResetPasswordViewController.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/20/23.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    private let emailField = CustomTextField(fieldType: .email)
    private let resetButton = CustomButton(title: "Сбросить пароль", hasBackground: true, fontSize: .big)
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Инструкция по сбросу пароля придет Вам на почту"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Сбросить пароль"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.addTarget(self, action: #selector(didTapReset), for: .touchUpInside)
        
        view.addSubview(emailField)
        view.addSubview(resetButton)
        view.addSubview(infoLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            emailField.heightAnchor.constraint(equalToConstant: 44),
            
            resetButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            resetButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 88),
            resetButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -87),
            resetButton.heightAnchor.constraint(equalToConstant: 42),
            
            infoLabel.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            infoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            infoLabel.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    // checking the correctness of the entered data and reset password
    @objc private func didTapReset() {
        let email = self.emailField.text ?? ""
        
        if !Validator.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }
            
            AlertManager.showPasswordResetSent(on: self)
        }
    }
}
