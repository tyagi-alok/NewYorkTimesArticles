//
//  ColorUtility.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/24.
//  Copyright © 2024 Alok. All rights reserved.
//

import Foundation
import UIKit

class ColorUtility{
    
    
   static func uicolorFromHex(rgbValue:UInt32) -> UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }

    
}
