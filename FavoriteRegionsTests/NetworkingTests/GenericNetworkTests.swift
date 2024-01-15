//
//  GenericNetworkTests.swift
//  FavoriteRegionsTests
//
//  Created by Anton Abramov on 15.01.2024.
//

import XCTest
@testable import FavoriteRegions

private enum Constant {
    static let postsUrlStr = "https://jsonplaceholder.typicode.com/posts"
}

final class MockPostNetworkRequest: NetworkRequest {
    typealias Response = [Post]
    
    var decoder: JSONDecoder = {
        $0.keyDecodingStrategy = .convertFromSnakeCase
        return $0
    }(JSONDecoder())
    var httpMethod: FavoriteRegions.HttpMethod = .GET
    var url: String = Constant.postsUrlStr
    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
    var timeoutInterval: TimeInterval = 15
    var headers: [String: String]?
}

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

final class GenericNetworkTests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var networkService: NetworkService!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var mockPostNetworkRequest: MockPostNetworkRequest!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkService = NetworkServiceImpl()
        mockPostNetworkRequest = MockPostNetworkRequest()
    }
    
    override func tearDownWithError() throws {
        networkService = nil
        mockPostNetworkRequest = nil
        try super.tearDownWithError()
    }
    
    func testGenericSend() async {
        do {
            let posts = try await networkService.send(request: mockPostNetworkRequest)
            XCTAssertFalse(posts.isEmpty, "Fetch Posts result should not be empty")
            XCTAssertEqual(posts.count, 100, "Fetch Posts result incomplete")
        } catch {
            XCTFail("Error fetching posts")
        }
    }
}
