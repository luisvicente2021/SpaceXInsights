//
//  SpaceXRepository.swift
//  SpaceXInsights
//
//  Created by luisr on 02/06/25.
//

import Foundation
import RealmSwift

enum RepositoryError: Error, LocalizedError {
    case realmSaveError(String)
    case realmFetchError(String)

    var errorDescription: String? {
        let strings = Strings()
        switch self {
        case .realmSaveError(let description):
            return strings.saveError(description)
        case .realmFetchError(let description):
            return strings.fetchError(description)
        }
    }
}

class SpaceXRepository {
    private let lastFetchKey = "lastFetchDate"

    func shouldFetchNewData() -> Bool {
        let calendar = Calendar.current
        if let lastFetch = UserDefaults.standard.object(forKey: lastFetchKey) as? Date {
            return !calendar.isDateInToday(lastFetch)
        }
        return true
    }

    func updateLastFetchDate() {
        UserDefaults.standard.set(Date(), forKey: lastFetchKey)
    }

    func saveToRealm(_ items: [SpaceXModel]) throws {
        do {
            let realm = try Realm()
            try realm.write {
                items.forEach {
                    let realmModel = SpaceXRealmModel()
                    realmModel.flightNumber = $0.flight_number
                    realmModel.missionName = $0.mission_name
                    realmModel.missionId.append(objectsIn: $0.mission_id)
                    realmModel.upcoming = $0.upcoming
                    realmModel.launchYear = $0.launch_year
                    realmModel.launchSite = $0.launch_site.siteNameLong.rawValue
                    realmModel.missionPatch = $0.links.missionPatch
                    realmModel.videoLink = $0.links.videoLink
                    realmModel.rocketName = $0.rocket.rocketName.rawValue
                    realmModel.details = $0.details
                    realmModel.articleLink = $0.links.articleLink
                    realmModel.missionPatchSmall = $0.links.missionPatchSmall
                    realm.add(realmModel, update: .modified)
                }
            }
        } catch {
            throw RepositoryError.realmSaveError(error.localizedDescription)
        }
    }

    func fetchFromRealm() throws -> [SpaceXRealmModel] {
        do {
            let realm = try Realm()
            return Array(realm.objects(SpaceXRealmModel.self))
        } catch {
            throw RepositoryError.realmFetchError(error.localizedDescription)
        }
    }
}
