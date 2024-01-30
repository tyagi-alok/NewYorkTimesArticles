//
//  Result.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2024 Alok. All rights reserved.
//

import Foundation

enum Result<T,E: Error>{
    case success(T)
    case failure(E)
}


enum ErrorResult: Error {
    case network(string: String)
    case cancel(string: String)
    case custom(string: String)
    case noData
    case decodingError( _ error: Error)
    case invalidRequest
    case serverError

}

