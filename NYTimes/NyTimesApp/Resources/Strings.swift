//
//  Strings.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2024 Alok. All rights reserved.
//

import UIKit

struct AppStrings{
    static let DEFAULT_URL = "https://static01.nyt.com/images/2020/11/12/upshot/12up-vote-count/12up-vote-count-thumbStandard.jpg"
    static let ALERT_OK_BUTTON_TITLE = "Ok"
    static let ALERT_TITLE = "Alert"
    static let APP_TITLE = "NY Times Most Popular"
    static var DEFAULT_IMAGE_URL = "https://static01.nyt.com/images/2020/11/12/upshot/12up-vote-count/12up-vote-count-thumbStandard.jpg"
}

struct AppIdentifiers{
    // Identifiers
    static let tableCellIdentifier = "PopularArticlesListViewController"
    static let popularArtcilesListVCIdentifier = "PopularArticlesListViewController"
    static let popularArtcilesDetailVCIdentifier = "PopularArticlesDetailViewController"
}

struct AppStoryboards{
    //StoryBoard Names
    static let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
}
