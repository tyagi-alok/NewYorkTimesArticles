//
//  DependencyContainer.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/24.
//  Copyright © 2024 Alok. All rights reserved.
//

import Foundation

class DependencyContainer{
    
    static func getViewModelDependency() -> PopularArticlesListViewModelProtocol {
        
        let viewModel = PopularArticlesListViewModel(apiService: getAPIServiceDependency())
        
        return viewModel
    }
    
    static func getAPIServiceDependency() -> APIServiceProtocol {
        
        let apiService = PopularArticlesService(networkManager: getNetworkManagerDependency())
        return apiService
        
    }
    
    static func getNetworkManagerDependency() -> NetworkManagerProtocol {
        
        let networkManager = NetworkManager()
        return networkManager
        
    }
    
}
