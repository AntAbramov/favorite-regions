//
//  MainView.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import SwiftUI

// MARK: - Constant

private enum Constant {
    static let alertTitle = "Произошла ошибка"
    static let reloadButtonTitle = "Перезагрузить"
    static let tryLaterMessage = "Проверьте интернет-соединение и попробуйте снова"
    static let progressViewScale: CGFloat = 2
}

// MARK: - View

struct MainView: View {
    // MARK: Dependency
    @StateObject private var viewModel = MainViewModel()
    
    // MARK: body
    var body: some View {
        if viewModel.isRefreshing {
            createProgressView()
        } else {
            createListOfRegions()
        }
    }
}

// MARK: - Private methods

private extension MainView {
    func createProgressView() -> some View {
        ProgressView()
            .progressViewStyle(.circular)
            .scaleEffect(Constant.progressViewScale)
            .onAppear {
                viewModel.performRequest()
            }.alert(
                LocalizedStringKey(Constant.alertTitle),
                isPresented: $viewModel.hasError,
                actions: {
                    Button(Constant.reloadButtonTitle) {
                        viewModel.retryRequest()
                    }
                },
                message: {
                    Text(Constant.tryLaterMessage)
                }
            )
    }
    
    func createListOfRegions() -> some View {
        List(viewModel.dataSource) { dto in
            RegionTableCell(
                viewModel: viewModel.createRegionTableCellViewModel(dto: dto)
            ).onTapGesture {
                viewModel.showDetailView(dto: dto)
            }.listRowSeparator(.hidden)
        }.refreshable {
            await viewModel.refresh()
        }.listStyle(.plain)
    }
}
