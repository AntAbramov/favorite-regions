//
//  MockDataLoader.swift
//  FavoriteRegionsTests
//
//  Created by Anton Abramov on 15.01.2024.
//

import Foundation
@testable import FavoriteRegions

final class MockDataLoader: DataLoader {
    var expectedData: Data?
    var expectedError: Error?
    
    init(
        expectedData: Data? = nil,
        expectedError: Error? = nil
    ) {
        self.expectedData = expectedData
        self.expectedError = expectedError
    }
    
    func downloadData(from: URL) async throws -> Data {
        if let expectedError {
            throw expectedError
        } else {
            return expectedData ?? Data()
        }
    }
}
