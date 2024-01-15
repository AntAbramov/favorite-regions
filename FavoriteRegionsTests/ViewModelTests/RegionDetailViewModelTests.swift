//
//  RegionDetailViewModelTests.swift
//  FavoriteRegionsTests
//
//  Created by Anton Abramov on 15.01.2024.
//

import XCTest
@testable import FavoriteRegions

private enum Constant {
    static let dto = RegionDTO(
        brandId: "1",
        title: "Moscow",
        thumbUrls: [],
        viewsCount: 100
    )
}

final class RegionDetailViewModelTests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var viewModel: RegionDetailViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let networkService = NetworkServiceImpl()
        viewModel = RegionDetailViewModel(
            dto: Constant.dto,
            imageLoader: networkService
        )
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testColorOpacity() {
        let size = CGSize(width: 100, height: 100)
        let opacity = viewModel.colorOpacity(for: size)
        XCTAssertEqual(opacity, 0.875)
    }
    
    func testViewCount() {
        let viewCount = viewModel.getViewCount()
        XCTAssertEqual(viewCount, "Просмотров: 100")
    }
    
    func testRegionTitle() {
        XCTAssertEqual(viewModel.getRegionTitle(), "Moscow")
    }
}
