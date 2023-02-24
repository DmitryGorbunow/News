//
//  SignUpViewController.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/20/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let usernameField = CustomTextField(fieldType: .username)
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signInButton = CustomButton(title: "Вход", hasBackground: true, fontSize: .big)
    private let backToSignInButton = CustomButton(title: "Войти", hasBackground: false, fontSize: .small)
    
    private lazy var noAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас есть аккаунт?"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        buttonsConfig()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Регистрация"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        backToSignInButton.translatesAutoresizingMaskIntoConstraints = false
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(usernameField)
        view.addSubview(noAccountLabel)
        view.addSubview(backToSignInButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            usernameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 38),
            usernameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -37),
            usernameField.heightAnchor.constraint(equalToConstant: 44),
            
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 15),
            emailField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 38),
            emailField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -37),
            emailField.heightAnchor.constraint(equalToConstant: 44),

            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
            passwordField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 38),
            passwordField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -37),
            passwordField.heightAnchor.constraint(equalToConstant: 44),
            
            signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            signInButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 88),
            signInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -87),
            signInButton.heightAnchor.constraint(equalToConstant: 42),
            
            noAccountLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            noAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noAccountLabel.heightAnchor.constraint(equalToConstant: 18),
            
            backToSignInButton.topAnchor.constraint(equalTo: noAccountLabel.bottomAnchor, constant: 10),
            backToSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backToSignInButton.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func buttonsConfig() {
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.backToSignInButton.addTarget(self, action: #selector(didTapBackToSignIn), for: .touchUpInside)
    }
    
    // checking the correctness of the entered data, creating a new user and logging in
    @objc private func didTapSignIn() {
        let registerUserRequest = RegisterUserRequest(
            username: self.usernameField.text ?? "",
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
        
        if !Validator.isValidUsername(for: registerUserRequest.username) {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        if !Validator.isPasswordValid(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }
    
    // // transition to SignIn
    @objc private func didTapBackToSignIn() {
        let vc = SignInViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: false, completion: nil)
    }
}

