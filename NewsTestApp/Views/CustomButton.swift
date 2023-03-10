//
//  CustomButton.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/20/23.
//

import UIKit

class CustomButton: UIButton {
    
    // constructor for different types of buttons
    
    enum FontSize {
        case big
        case small
    }
    
    init(title: String, hasBackground: Bool, fontSize: FontSize) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        
        self.backgroundColor = hasBackground ? UIColor(named: "NABlue") : .clear
        
        let titleColor: UIColor = hasBackground ? .white : UIColor(named: "NABlue")!
        self.setTitleColor(titleColor, for: .normal)
        
        switch fontSize {
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
            self.layer.cornerRadius = 20
            self.layer.masksToBounds = true
            
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
