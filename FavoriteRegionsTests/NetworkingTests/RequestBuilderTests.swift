//
//  RequestBuilderTests.swift
//  FavoriteRegionsTests
//
//  Created by Anton Abramov on 15.01.2024.
//

import XCTest
@testable import FavoriteRegions

private enum Constant {
    static let brandsUrl = "https://vmeste.wildberries.ru/api/guide-service/v1/getBrands"
}

final class MockNetworkRequest: NetworkRequest {
    typealias Response = Brands
    
    var decoder: JSONDecoder = .init()
    var httpMethod: FavoriteRegions.HttpMethod = .GET
    var url: String = Constant.brandsUrl
    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringCacheData
    var timeoutInterval: TimeInterval = 15
    var headers: [String: String]? = ["Test": "Test"]
}

final class RequestBuilderTests: XCTestCase {
    func testBuildURLRequest() {
        let requestBuilder: RequestBuilder = RequestBuilderImpl()
        let mockNetworkRequest = MockNetworkRequest()
        
        do {
            let urlRequest = try requestBuilder.build(with: mockNetworkRequest)
            
            XCTAssertEqual(urlRequest.url?.absoluteString, Constant.brandsUrl)
            XCTAssertEqual(urlRequest.httpMethod, "GET")
            XCTAssertEqual(urlRequest.cachePolicy, .reloadIgnoringCacheData)
            XCTAssertEqual(urlRequest.timeoutInterval, 15)
            XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["Test": "Test"])
        } catch {
            XCTFail("Error building URLRequest: \(error)")
        }
    }
}
