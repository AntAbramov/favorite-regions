//
//  NetworkingTests.swift
//  FavoriteRegionsTests
//
//  Created by Anton Abramov on 15.01.2024.
//

import XCTest
@testable import FavoriteRegions

private enum Constant {
    // swiftlint:disable:next force_unwrapping
    static let moscowUrl = URL(string: moscowUrlStr)!
    private static let moscowUrlStr = "https://static-basket-02.wb.ru/vol22/travel/preview-ffwHk_JJ1oj_1024x435.jpg"
}

final class NetworkingTests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var networkService: NetworkService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkService = NetworkServiceImpl()
    }
    
    override func tearDownWithError() throws {
        networkService = nil
        try super.tearDownWithError()
    }
    
    func testDownloadData() async {
        do {
            let data = try await networkService.downloadData(from: Constant.moscowUrl)
            XCTAssertFalse(data.isEmpty, "Downloaded Data should not be empty")
        } catch {
            XCTFail("Error downloading data: \(error.localizedDescription)")
        }
    }
    
    func testFetchBrands() async {
        do {
            let brands = try await networkService.fetchBrands()
            XCTAssertFalse(brands.brands.isEmpty, "Fetch Brands result should not be empty")
        } catch {
            XCTFail("Error fetching brands: \(error.localizedDescription)")
        }
    }
}
