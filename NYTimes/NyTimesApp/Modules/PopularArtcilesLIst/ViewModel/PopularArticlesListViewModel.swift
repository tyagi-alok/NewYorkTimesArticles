//
//  PopularArticlesLIstViewModel.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

protocol PopularArticlesListViewModelProtocol{
    func getPopularArticles() async
}

class PopularArticlesListViewModel : PopularArticlesListViewModelProtocol, ObservableObject {
    
    let apiService: APIServiceProtocol
    
    
    @Published var cellViewModels: PopularArticlesModel? {
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
    
    var selectedIndexPath: IndexPath?
    

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
                
                DispatchQueue.main.async {
                    self.cellViewModels = data
                }
                
            case .failure(let error):
                self.alertMessage = error.localizedDescription
            }
        }
        catch(let error){
            self.alertMessage = error.localizedDescription
        }

    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> Articles? {
            return cellViewModels?.articles[indexPath.row]
    }

}

extension PopularArticlesListViewModel {
    func userPressed( at indexPath: IndexPath ){
        self.selectedIndexPath = indexPath
    }
}