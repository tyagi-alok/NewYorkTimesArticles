//
//  PopularArticlesListRouter.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 30/01/24.
//  Copyright © 2024 Alok. All rights reserved.
//

import Foundation
import UIKit

enum Screentype {
    case PopularArticlesDetail
}

/*--Router protocol with T as data that is to be passed to the destination screen --*/
protocol Router{
    associatedtype T 
    func navigateToScreen(screenType : Screentype, data : T?)
}

/*--Router class for routing any screen from the Popular Articles List screen-*/
class PopularArticlesListRouter : Router{
   
    var viewController : UIViewController?
    
    func navigateToScreen(screenType: Screentype, data: Articles?) {
        
        switch screenType {
        case .PopularArticlesDetail:
            navigateToArticlesDetail(with: data)
        }
        
    }
}

extension PopularArticlesListRouter {
    
    private func navigateToArticlesDetail(with data : Articles?){
        
        if let article = data,article.abstract != nil{

            guard let detailController = mainStoryboard.instantiateViewController(withIdentifier: popularArtcilesDetailVCIdentifier) as? PopularArticlesDetailViewController else {
                return
            }
            detailController.saveData(for: article)
            viewController?.navigationController?.pushViewController(detailController, animated: true)
            
        }
    }
    
}
