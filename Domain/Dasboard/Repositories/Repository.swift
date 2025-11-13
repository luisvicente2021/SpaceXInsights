//
//  Repository.swift
//  SpaceXInsights
//
//  Created by luisr on 11/11/25.
//

protocol DashboardRepository {
    func getAllItems() async throws -> [SpaceXEntity]
}
