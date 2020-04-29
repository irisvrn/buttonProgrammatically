//
//  surveyButton.swift
//  buttonProgrammatically
//
//  Created by Eugene Izotov on 14.10.2019.
//  Copyright © 2019 Eugene Izotov. All rights reserved.
//

import UIKit

class surveyButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton()  {
        setTitleColor(.white, for: .normal)
        //setTitleColor(.red, for: .normal)
        //backgroundColor = .red
        backgroundColor = .purple //.blue
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 28)
        layer.cornerRadius = 5
    }
    
}
