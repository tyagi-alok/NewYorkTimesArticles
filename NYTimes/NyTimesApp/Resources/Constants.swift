//
//  Constants.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2024 Alok. All rights reserved.
//

import Foundation

struct AppURL {
    static let SeeAllPopularArticles = "viewed/1.json?api-key=kDOFCueo43oe8wKfh7YxV4qadA3YGGey"
    
}

var baseURL: String! {
    get {
        return Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String
    }
}
