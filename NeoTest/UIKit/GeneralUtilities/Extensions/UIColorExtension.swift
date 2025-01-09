//
//  UIColorExtension.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 12/12/24.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, Constants.ErrorMessages.invalidRedValue)
        assert(green >= 0 && green <= 255, Constants.ErrorMessages.invalidGreenValue)
        assert(blue >= 0 && blue <= 255, Constants.ErrorMessages.invalidBlueValue)
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}
