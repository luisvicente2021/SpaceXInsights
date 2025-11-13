//
//  SpaceXRealmModel.swift
//  SpaceXInsights
//
//  Created by luisr on 02/06/25.
//
/*
import Foundation
import RealmSwift

class SpaceXRealmModel: Object {
    @Persisted(primaryKey: true) var flightNumber: Int
    @Persisted var missionName: String
    @Persisted var missionId: List<String>
    @Persisted var upcoming: Bool
    @Persisted var launchYear: String
    @Persisted var launchSite: String // simplificado
    @Persisted var missionPatch: String?
    @Persisted var videoLink: String
    @Persisted var rocketName: String
    @Persisted var details: String?
    @Persisted var articleLink: String?
    @Persisted var missionPatchSmall: String?
}


extension SpaceXRealmModel {
    
    convenience init(from model: SpaceXModel) {
        self.init()
        self.flightNumber = model.flight_number
        self.missionName = model.mission_name
        self.missionId.append(objectsIn: model.mission_id)
        self.upcoming = model.upcoming
        self.launchYear = model.launch_year
        self.launchSite = model.launch_site.siteNameLong.rawValue
        self.missionPatch = model.links.missionPatch
        self.videoLink = model.links.videoLink
        self.rocketName = model.rocket.rocketName.rawValue
        self.details = model.details
        self.articleLink = model.links.articleLink
        self.missionPatchSmall = model.links.missionPatchSmall
        
    }
}
*/
