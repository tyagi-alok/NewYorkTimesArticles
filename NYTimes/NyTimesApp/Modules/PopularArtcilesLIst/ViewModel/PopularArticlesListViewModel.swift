//
//  PopularArticlesLIstViewModel.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2024 Alok. All rights reserved.
//

import Foundation

protocol PopularArticlesListViewModelProtocol{
    func getPopularArticles() async
}

class PopularArticlesListViewModel : PopularArticlesListViewModelProtocol {
    
    let apiService: APIServiceProtocol
    
    
    var cellViewModels: PopularArticlesModel? {
    didSet {
        self.reloadTableViewClosure?()
    }
}
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels?.resultsNumber ?? 0
    }
        

    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?

    init( apiService: APIServiceProtocol = PopularArticlesService(networkManager: NetworkManager())) {
        self.apiService = apiService
    }
    
    func getPopularArticles() async {
        self.isLoading = true
        
        do{
            let result:Result<PopularArticlesModel,ErrorResult> = try await apiService.getPopularArtciles()
           
            switch result{
            case .success(let data):
                self.isLoading = false
                self.cellViewModels = data
                
            case .failure(let error):
                self.isLoading = false
                self.alertMessage = error.localizedDescription
            }
        }
        catch(let error){
            self.isLoading = false
            self.alertMessage = error.localizedDescription
        }

    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> Articles? {
            return cellViewModels?.articles[indexPath.row]
    }

}

