//
//  NetworkManager.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol{
    func load(_ resource: Resource, result: @escaping ((Result<Data,ErrorResult>) -> Void))
    func load(_ resource: Resource) async throws -> Data

}

class NetworkManager : NetworkManagerProtocol{
    
    init(){}
    
    func load(_ resource: Resource, result: @escaping ((Result<Data,ErrorResult>) -> Void)) {
        let request = URLRequest(resource)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let `data` = data else {
                result(.failure(.serverError))
                return
            }
            if let error = error {
                result(.failure(.network(string: error.localizedDescription)))
                return
            }
            result(.success(data))
        }
        task.resume()
    }
    
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
