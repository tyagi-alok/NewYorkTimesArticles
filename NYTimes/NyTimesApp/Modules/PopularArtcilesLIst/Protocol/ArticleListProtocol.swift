//
//  ArticleListProtocol.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2024 Alok. All rights reserved.
//

import Foundation

protocol ArticleListProtocol : AnyObject {
    func getData(atIndexPath: IndexPath)->Articles?
    func itemSelected(atIndexPath: IndexPath)
    func retrieveNumberOfSections()->Int
    func retrieveNumberOfItems()->Int
}
