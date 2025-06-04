//
//  SpaceXViewModel.swift
//  SpaceXInsights
//
//  Created by luisr on 02/06/25.
//

import Foundation

final class SpaceXViewModel {
    
    private(set) var spaceXItems: [SpaceXModel] = []
    private let service: ServiceSpaceXType
    private let repository: SpaceXRepository
    
    init(service: ServiceSpaceXType, repository: SpaceXRepository = SpaceXRepository()) {
        self.service = service
        self.repository = repository
    }
    
    func fetchSpaceShips(
        success: @escaping ([SpaceXModel]) -> Void,
        failure: @escaping (String) -> Void
    ) {
        Task {
            if repository.shouldFetchNewData() {
                do {
                    let items = try await service.fetchSpaceShipModels()
                    try repository.saveToRealm(items)
                    repository.updateLastFetchDate()
                    self.spaceXItems = items
                    DispatchQueue.main.async {
                        success(items)
                    }
                } catch {
                    DispatchQueue.main.async {
                        let errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
                        failure(errorMessage)
                    }
                }
            } else {
                do {
                    let realmItems = try repository.fetchFromRealm()
                    let converted = realmItems.map { realmModel in
                        SpaceXModel(
                            flight_number: realmModel.flightNumber,
                            mission_name: realmModel.missionName,
                            mission_id: Array(realmModel.missionId),
                            upcoming: realmModel.upcoming,
                            launch_year: realmModel.launchYear,
                            launch_site: .init(
                                siteID: .ccafsSlc40,
                                siteName: .ccafsSlc40,
                                siteNameLong: .capeCanaveralAirForceStationSpaceLaunchComplex40
                            ),
                            links: .init(
                                missionPatch: realmModel.missionPatch,
                                missionPatchSmall: realmModel.missionPatchSmall,
                                redditCampaign: nil,
                                redditLaunch: nil,
                                redditRecovery: nil,
                                redditMedia: nil,
                                presskit: nil,
                                articleLink: realmModel.articleLink,
                                wikipedia: nil,
                                videoLink: realmModel.videoLink,
                                youtubeID: extractYoutubeID(from: realmModel.videoLink),
                                flickrImages: []
                            ),
                            launch_date_utc: "",
                            rocket: .init(
                                rocketID: .falcon9,
                                rocketName: .falcon9,
                                rocketType: .ft
                            ),
                            details: realmModel.details
                        )
                    }
                    
                    self.spaceXItems = converted
                    DispatchQueue.main.async {
                        success(converted)
                    }
                } catch {
                    DispatchQueue.main.async {
                        let errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
                        failure(errorMessage)
                    }
                }
            }
        }
    }
    
    
    func extractYoutubeID(from url: String) -> String {
        guard let url = URL(string: url) else { return "" }
        
        if url.host?.contains("youtu.be") == true {
            return url.lastPathComponent
        } else if url.host?.contains("youtube.com") == true {
            if let queryItems = URLComponents(string: url.absoluteString)?.queryItems {
                return queryItems.first(where: { $0.name == "v" })?.value ?? ""
            }
        }
        return ""
    }
}
