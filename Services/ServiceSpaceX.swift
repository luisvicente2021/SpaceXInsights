//
//  ServiceSpaceX.swift
//  SpaceXInsights
//
//  Created by luisr on 29/05/25.
//
import Foundation
import Alamofire

enum ServiceError: Error, LocalizedError {
    case badURL
    case decodingError
    case custom(String)

    var errorDescription: String? {
        let strings = Strings()
        switch self {
        case .badURL:
            return strings.badURL
        case .decodingError:
            return strings.decodingError
        case .custom(let message):
            return message
        }
    }
}

protocol ServiceSpaceXType {
    func fetchSpaceShipModels() async throws -> [SpaceXModel]
}

final class ServiceSpaceX: ServiceSpaceXType {
    
    private let baseURL = "https://api.spacexdata.com/v3/launches/past"
    let strings = Strings()
    
    func fetchSpaceShipModels() async throws -> [SpaceXModel] {
        guard let url = URL(string: baseURL) else {
            throw ServiceError.badURL
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let request = AF.request(url)
            .validate()

        do {
            let response = try await request.serializingData().response

            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case 200...299:
                    break
                case 400...499:
                        throw ServiceError.custom(strings.clientError(statusCode))
                    case 500...599:
                        throw ServiceError.custom(strings.serverError(statusCode))
                    default:
                        throw ServiceError.custom(strings.unknownError(statusCode))
                }
            }

            guard let data = response.data else {
                throw ServiceError.custom(strings.emptyResponse)
            }

            let decoded = try decoder.decode([SpaceXModel].self, from: data)
            return decoded
        } catch {
            if let afError = error as? AFError {
                throw ServiceError.custom(strings.networkError(afError.localizedDescription))
            }
            throw ServiceError.decodingError
        }
    }
}
