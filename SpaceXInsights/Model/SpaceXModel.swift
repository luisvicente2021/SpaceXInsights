//
//  SpaceXModel.swift
//  SpaceXInsights
//
//  Created by luisr on 29/05/25.
//

import Foundation

// MARK: - WelcomeElement
struct SpaceXModel: Codable {
    let flight_number: Int
    let mission_name: String
    let mission_id: [String]
    let upcoming: Bool
    let launch_year: String
    let launch_site: LaunchSite
    let links: Links
    let launch_date_utc: String
    let rocket: Rocket
    let details: String?
    
    struct LaunchSite: Codable {
        let siteID: SiteID
        let siteName: SiteName
        let siteNameLong: SiteNameLong
        
        enum CodingKeys: String, CodingKey {
            case siteID = "site_id"
            case siteName = "site_name"
            case siteNameLong = "site_name_long"
        }
    }
    
    enum SiteID: String, Codable {
        case ccafsSlc40 = "ccafs_slc_40"
        case kscLc39A = "ksc_lc_39a"
        case kwajaleinAtoll = "kwajalein_atoll"
        case vafbSlc4E = "vafb_slc_4e"
    }
    
    enum SiteName: String, Codable {
        case ccafsSlc40 = "CCAFS SLC 40"
        case kscLc39A = "KSC LC 39A"
        case kwajaleinAtoll = "Kwajalein Atoll"
        case vafbSlc4E = "VAFB SLC 4E"
    }
    
    enum SiteNameLong: String, Codable {
        case capeCanaveralAirForceStationSpaceLaunchComplex40 = "Cape Canaveral Air Force Station Space Launch Complex 40"
        case kennedySpaceCenterHistoricLaunchComplex39A = "Kennedy Space Center Historic Launch Complex 39A"
        case kwajaleinAtollOmelekIsland = "Kwajalein Atoll Omelek Island"
        case vandenbergAirForceBaseSpaceLaunchComplex4E = "Vandenberg Air Force Base Space Launch Complex 4E"
    }
    
    struct Links: Codable {
        let missionPatch, missionPatchSmall: String?
        let redditCampaign: String?
        let redditLaunch: String?
        let redditRecovery, redditMedia: String?
        let presskit: String?
        let articleLink: String?
        let wikipedia: String?
        let videoLink: String
        let youtubeID: String
        let flickrImages: [String]
        
        enum CodingKeys: String, CodingKey {
            case missionPatch = "mission_patch"
            case missionPatchSmall = "mission_patch_small"
            case redditCampaign = "reddit_campaign"
            case redditLaunch = "reddit_launch"
            case redditRecovery = "reddit_recovery"
            case redditMedia = "reddit_media"
            case presskit
            case articleLink = "article_link"
            case wikipedia
            case videoLink = "video_link"
            case youtubeID = "youtube_id"
            case flickrImages = "flickr_images"
        }
    }
    
    struct Rocket: Codable {
        let rocketID: RocketID
        let rocketName: RocketName
        let rocketType: RocketType
        
        enum CodingKeys: String, CodingKey {
            case rocketID = "rocket_id"
            case rocketName = "rocket_name"
            case rocketType = "rocket_type"
            
        }
    }
    
    enum RocketID: String, Codable {
        case falcon1 = "falcon1"
        case falcon9 = "falcon9"
        case falconheavy = "falconheavy"
    }
    
    enum RocketName: String, Codable {
        case falcon1 = "Falcon 1"
        case falcon9 = "Falcon 9"
        case falconHeavy = "Falcon Heavy"
    }
    
    enum RocketType: String, Codable {
        case ft = "FT"
        case merlinA = "Merlin A"
        case merlinC = "Merlin C"
        case v10 = "v1.0"
        case v11 = "v1.1"
    }
}
