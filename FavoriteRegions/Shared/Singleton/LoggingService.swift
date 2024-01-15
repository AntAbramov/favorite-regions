//
//  LoggingService.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import OSLog

// MARK: - Implementation

struct LoggingService {
    // swiftlint:disable:next prefer_self_in_static_references
    static let shared = LoggingService()
    
    let networkLogger = Logger(
        subsystem: "com.antabramov.FavoriteRegions",
        category: "Network monitoring"
    )
}
// MARK: - Interface
/// Frequently used methods

extension LoggingService {
    func networkError(_ error: NetworkError) {
        networkLogger.error("\(error.localizedDescription)")
    }
    
    func unknownNetworkError(_ error: Error) {
        networkLogger.error("Unknown network error - \(error.localizedDescription)")
    }
}
