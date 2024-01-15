//
//  FollowingRegionsTests.swift
//  FavoriteRegionsTests
//
//  Created by Anton Abramov on 15.01.2024.
//

import XCTest
@testable import FavoriteRegions

final class FollowingRegionsTests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var followingRegions: FollowingRegions!
    
    private let id = "ID"
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        followingRegions = FollowingRegions()
    }
    
    override func tearDownWithError() throws {
        followingRegions = nil
        try super.tearDownWithError()
    }
        
    func testDefaultValue() {
        XCTAssertFalse(followingRegions.fetch(for: id))
    }
    
    func testFetchExistingValue() {
        followingRegions.set(value: true, for: id)
        XCTAssertTrue(followingRegions.fetch(for: id))
    }

    func testSetValue() {
        followingRegions.set(value: false, for: id)
        XCTAssertFalse(followingRegions.fetch(for: id))
    }
}
