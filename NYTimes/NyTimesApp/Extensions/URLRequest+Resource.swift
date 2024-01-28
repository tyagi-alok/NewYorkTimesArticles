//
//  URLRequest+Resource.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 27/01/2024.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

extension URLRequest {
    
    init(_ resource: Resource) {
        self.init(url: resource.url)
        self.httpMethod = resource.method
    }
    
}
