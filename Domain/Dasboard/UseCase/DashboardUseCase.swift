//
//  DashboardUseCase.swift
//  SpaceXInsights
//
//  Created by luisr on 11/11/25.
//

final class FetchDashboardItemsUseCase {
    private let repository: DashboardRepository
    
    init(repository: DashboardRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [SpaceXEntity] {
        let items = try await repository.getAllItems()
        // Aquí podrías filtrar por año, upcoming = true, etc.
        return items
    }
}
