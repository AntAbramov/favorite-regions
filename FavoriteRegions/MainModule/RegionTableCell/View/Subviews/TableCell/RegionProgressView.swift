//
//  RegionProgressView.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import SwiftUI

// MARK: - View

struct RegionProgressView: View {
    var body: some View {
        EmptyRegionView()
            .background(ProgressView())
    }
}
