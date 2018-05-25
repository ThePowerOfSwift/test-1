//
//  UICustomButton.swift
//  BatChat
//
//  Created by Sofia Passarelli on 25/05/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class UICustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderThickness: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderThickness
        }
    }
    
    @IBInspectable var borderColor: CGColor = UIColor.clear.cgColor {
        didSet {
            layer.borderColor = borderColor
        }
    }
}

