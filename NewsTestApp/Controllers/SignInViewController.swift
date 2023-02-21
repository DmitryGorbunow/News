//
//  SignInViewController.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/19/23.
//

import UIKit

class SignInViewController: UIViewController {
    
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signInButton = CustomButton(title: "Вход", hasBackground: true, fontSize: .big)
    private let signUpButton = CustomButton(title: "Зарегистрироваться", hasBackground: false, fontSize: .small)
    private let passwordResetButton = CustomButton(title: "Сбросить пароль", hasBackground: false, fontSize: .small)
    
    private lazy var noAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет аккаунта ?"
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
        title = "Вход"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(signUpStack)
        view.addSubview(passwordResetButton)
        signUpStack.addArrangedSubview(noAccountLabel)
        signUpStack.addArrangedSubview(signUpButton)
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
            signUpStack.heightAnchor.constraint(equalToConstant: 18),
            
            passwordResetButton.heightAnchor.constraint(equalToConstant: 18),
            passwordResetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 129),
            passwordResetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -129),
            passwordResetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    private func buttonsConfig() {
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        self.passwordResetButton.addTarget(self, action: #selector(didTapReset), for: .touchUpInside)
    }
    
    @objc private func didTapSignIn() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc private func didTapSignUp() {
        let vc = SignUpViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: false, completion: nil)
    }
    
    @objc private func didTapReset() {
        let vc = ResetPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

