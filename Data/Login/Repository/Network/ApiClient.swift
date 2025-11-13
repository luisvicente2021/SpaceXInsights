//
//  ApiClient.swift
//  SpaceXInsights
//
//  Created by luisr on 11/11/25.
//
import Foundation

final class APIClient {
  
    private let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func request<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: Data? = nil,
        headers: [String: String] = [:],
        responseType: T.Type
    ) async throws -> T {
        var request = URLRequest(url: baseURL.appendingPathComponent(endpoint))
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8)!) // 👈 ver JSON real
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode)
        else { throw APIError.invalidResponse }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
}

enum APIError: Error {
    case invalidResponse
    case decodingError
    case networkError
}

