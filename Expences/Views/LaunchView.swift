//
//  LaunchView.swift
//  Expences
//
//  Created by Serhii Prykhodko on 07.10.2020.
//

import UIKit

class LaunchView: UIView {
    
    private lazy var view: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        
        return view
        
    }()

    private lazy var goToNextScreenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Check expences", for: .normal)
        button.center.x = self.view.center.x
        button.center.y = self.view.center.y
        
        return button
    }()

}
