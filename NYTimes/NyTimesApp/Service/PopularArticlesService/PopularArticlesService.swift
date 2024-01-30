//
//  PopularArticlesService.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2024 Alok. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func getPopularArtciles<T:Codable>() async throws -> Result<T,ErrorResult>
}

class PopularArticlesService:APIServiceProtocol {
    
    typealias GetFriendsResult = Result<PopularArticlesModel,ErrorResult>
    typealias GetFriendsCompletion = (_ result: GetFriendsResult) -> Void

    private let networkManager: NetworkManagerProtocol?
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getPopularArtciles<T:Codable>() async throws -> Result<T,ErrorResult>{
        
        let resource = Resource(url: URL(string:AppURL.SeeAllPopularArticles)!)
            
        do {
           
            let responseData = try await networkManager?.load(resource)
            
            guard let responseData = responseData else {
                return Result.failure(.noData)
            }
            let articles = try self.parseData(T.self, data: responseData)
            return Result.success(articles)
            
        }
        catch(let error){
            throw error
        }
        
    }
    
    func parseData<T:Codable>(_ modelType : T.Type, data : Data) throws -> T{
        
        do{
            let model = try JSONDecoder().decode(modelType.self, from: data)
            return model
        }
        catch(let error){
            throw error
        }
    }

    
}
