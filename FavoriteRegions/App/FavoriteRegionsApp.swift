//
//  FavoriteRegionsApp.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 29.12.2023.
//

import SwiftUI

private enum Constant {
    static let mainNavigationTitle = "Регионы"
}

@main
struct FavoriteRegionsApp: App {
    @ObservedObject var router = Router.shared
    private let networkService: NetworkService = {
        let session = URLSession(configuration: .default)
        session.configuration.requestCachePolicy = .returnCacheDataElseLoad
        return NetworkServiceImpl(session: session)
    }()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                MainView() // root
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .regionDetail(let dto):
                            buildRegionDetail(dto: dto, imageLoader: networkService)
                        }
                    }
                    .navigationTitle(Constant.mainNavigationTitle)
                    .navigationBarTitleDisplayMode(.large)
            }.accentColor(Color.primary)
        }
    }
    
    private func buildRegionDetail(
        dto: RegionDTO,
        imageLoader: DataLoader
    ) -> some View {
        let viewModel = RegionDetailViewModel(
            dto: dto,
            imageLoader: imageLoader
        )
        return RegionDetailView(viewModel: viewModel)
    }
}
