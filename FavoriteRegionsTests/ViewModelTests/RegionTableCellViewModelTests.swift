//
//  RegionTableCellViewModelTests.swift
//  FavoriteRegionsTests
//
//  Created by Anton Abramov on 15.01.2024.
//

import XCTest
@testable import FavoriteRegions

private enum Constant {
    // swiftlint:disable:next force_unwrapping
    static let moscowUrl = URL(string: "https://static-basket-02.wb.ru/vol22/travel/preview-ffwHk_JJ1oj_1024x435.jpg")!
    static let expectedImageData = Data("Mock Image Data".utf8)
}

enum MockErrors: Error {
    case cantLoadImage
}

final class RegionTableCellViewModelTests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var viewModel: RegionTableCellViewModel!
    private let dto = RegionDTO(
        brandId: "1",
        title: "Moscow",
        thumbUrls: [Constant.moscowUrl],
        viewsCount: 100
    )
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = RegionTableCellViewModel(
            dto: dto,
            imageLoader: MockDataLoader(
                expectedError: MockErrors.cantLoadImage
            )
        )
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testLoadingError() {
        let viewModel = RegionTableCellViewModel(
            dto: dto,
            imageLoader: MockDataLoader(
                expectedError: MockErrors.cantLoadImage
            )
        )
        XCTAssertNil(viewModel.imageData)
    }
}
