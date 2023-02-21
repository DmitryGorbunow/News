//
//  SignUpViewController.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/20/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signInButton = CustomButton(title: "Вход", hasBackground: true, fontSize: .big)
    private let backToSignInButton = CustomButton(title: "Войти", hasBackground: false, fontSize: .small)
    
    private lazy var noAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас есть аккаунт ?"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signUpStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(signUpStack)
        signUpStack.addArrangedSubview(noAccountLabel)
        signUpStack.addArrangedSubview(backToSignInButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
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
            
            signUpStack.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 68),
            signUpStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -67),
            signUpStack.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func buttonsConfig() {
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.backToSignInButton.addTarget(self, action: #selector(didTapBackToSignIn), for: .touchUpInside)
    }
    
    @objc private func didTapSignIn() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc private func didTapBackToSignIn() {
        let vc = SignInViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: false, completion: nil)
    }
}

