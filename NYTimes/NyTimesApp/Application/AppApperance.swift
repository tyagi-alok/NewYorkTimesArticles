    //
    //  AppApperance.swift
    //  NyTimesApp
    //
    //  Created by Alok Tyagi on 28/01/24.
    //  Copyright © 2024 Alok. All rights reserved.
    //

import Foundation


import Foundation
import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
        let navigationBarAppearace = UINavigationBarAppearance()
        navigationBarAppearace.backgroundColor = UIColor.clear
        navigationBarAppearace.configureWithTransparentBackground()
        
        let attributes = [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 22)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationBarAppearace.titleTextAttributes = attributes
        UINavigationBar.appearance().tintColor = .white
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearace
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearace
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
