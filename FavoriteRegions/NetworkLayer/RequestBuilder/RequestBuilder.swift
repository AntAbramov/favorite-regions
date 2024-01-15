//
//  RequestBuilder.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

protocol RequestBuilder {
    func build(with request: any NetworkRequest) throws -> URLRequest
}
