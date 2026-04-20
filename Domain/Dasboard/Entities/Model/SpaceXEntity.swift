//
//  Space.swift
//  SpaceXInsights
//
//  Created by luisr on 11/11/25.
//

import Foundation

struct SpaceXEntity: Decodable {
    let flightNumber: Int
    let missionName: String
    let details: String?
    let links: Links?
}
    
struct Links: Codable {
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