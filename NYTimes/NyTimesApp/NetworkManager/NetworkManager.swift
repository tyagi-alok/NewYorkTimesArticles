//
//  NetworkManager.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2024 Alok. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol{
    func load(_ resource: Resource) async throws -> Data
}

final class NetworkManager : NetworkManagerProtocol{
    
    init(){}
    
    func load(_ resource: Resource) async throws -> Data {
        let request = URLRequest(resource)
        do{
            let (data,response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw ErrorResult.serverError
            }
            return data
        }
        catch(let error){
            throw error
        }
    }
}
