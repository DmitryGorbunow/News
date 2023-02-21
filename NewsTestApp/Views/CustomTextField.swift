//
//  CustomTextField.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/20/23.
//

import UIKit

class CustomTextField: UITextField {
    
    enum CustomTextFieldType {
        case email
        case password
    }
    
    private let authFieldType: CustomTextFieldType
    
    init(fieldType: CustomTextFieldType) {
        self.authFieldType = fieldType
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor(named: "NALightBlue")
        self.layer.cornerRadius = 20
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.size.height))
        
        switch fieldType {
            
        case .email:
            self.placeholder = "Почта"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
            
        case .password:
            self.placeholder = "Пароль"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
