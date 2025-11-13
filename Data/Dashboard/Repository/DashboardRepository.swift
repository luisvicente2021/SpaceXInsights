//
//  DashboardRepository.swift
//  SpaceXInsights
//
//  Created by luisr on 11/11/25.
//

import Foundation

final class DashboardRepositoryImp: DashboardRepository {
    private let apiClient: APIClient
    init(apiClient: APIClient = APIClient(baseURL: URL(string: "https://api.spacexdata.com/v3")!)) {
            self.apiClient = apiClient
        }
    
    func getAllItems() async throws -> [SpaceXEntity] {
        
        let dtos: [ItemDTO] = try await apiClient.request(
            endpoint: "launches/past",
            responseType: [ItemDTO].self
        )
        
        

        return dtos.map { dto in
            
            var nombres: [String] = dto.links?.flickrImages ?? []

            
            return SpaceXEntity(flightNumber: dto.id, missionName: dto.title, details: dto.description, links: Links(missionPatchSmall: dto.links?.missionPatchSmall, articleLink: dto.links?.articleLink, videoLink: dto.links?.videoLink ?? "", youtubeID: dto.links?.youtubeID ?? "", flickrImages: nombres))
        }
    }
}


struct ItemDTO: Decodable {
    let id: Int
    let title: String
    let description: String?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id = "flight_number"
        case title = "mission_name"
        case description = "details"
        case links
    }
}

/*
struct LinksDTO: Codable {
    let missionPatchSmall: String?
    let articleLink: String?
    let videoLink: String
    let youtubeID: String
    let flickrImages: [String]

    enum CodingKeys: String, CodingKey {
        case missionPatchSmall = "mission_patch_small"
        case articleLink = "article_link"
        case videoLink = "video_link"
        case youtubeID = "youtube_id"
        case flickrImages = "flickr_images"
    
    }
}
*/
