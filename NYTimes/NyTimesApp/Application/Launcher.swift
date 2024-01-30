    //
    //  Launcher.swift
    //  NyTimesApp
    //
    //  Created by Alok Tyagi on 30/01/24.
    //  Copyright © 2024 Alok. All rights reserved.
    //

import Foundation
import UIKit

/*--Launcher class for instantiating the launch screen and setting to Navigation Controller--*/
class Launcher {
    static func launch(with window: UIWindow?) {
        let navController = UINavigationController(rootViewController: PopularArticlesListViewController.createPopularArticleList())
        
            //setting the UINavigation Bar Appearance throught the app
        AppAppearance.setupAppearance()
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
    }
}
