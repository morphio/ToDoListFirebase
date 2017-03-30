//
//  CustomButton.swift
//  FireList
//
//  Created by Alex on 30.03.17.
//  Copyright © 2017 Grid. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
