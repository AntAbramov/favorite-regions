//
//  MainViewModelTests.swift
//  FavoriteRegionsTests
//
//  Created by Anton Abramov on 15.01.2024.
//

import XCTest
@testable import FavoriteRegions

final class MainViewModelTests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var viewModel: MainViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let networkService = NetworkServiceImpl()
        viewModel = MainViewModel(networkService: networkService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testRequestPerform() {
        viewModel.retryRequest()
        XCTAssertTrue(viewModel.isRefreshing)
        XCTAssertFalse(viewModel.hasError)
    }
}
