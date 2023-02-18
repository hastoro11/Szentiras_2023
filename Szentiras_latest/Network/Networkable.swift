//
//  Networkable.swift
//  NetworkTest
//
//  Created by Gabor Sornyei on 2023. 01. 20..
//

import Foundation
import LoggerKit

protocol Networkable {
    func requestCodable<T:Decodable>(_ resource: Resource) async throws -> T
    func requestData(_ resource: Resource) async throws -> Data
}

struct NetworkKit: Networkable {
    
    static var shared = NetworkKit()
    private init() {}
    
    func requestCodable<T: Decodable>(_ resource: Resource) async throws -> T {
        try await processRequest(resource)
    }
    
    func requestData(_ resource: Resource) async throws -> Data {
        try await processRequest(resource)
    }
}

extension NetworkKit {
    private func processRequest<T: Decodable>(_ resource: Resource) async throws -> T {
        let data = try await processRequest(resource)
        return try decode(data)
    }
    
    private func processRequest(_ resource: Resource) async throws -> Data {
        let request = try buildRequest(resource)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        
        guard (200...299).contains(response.statusCode) else {
            let apiError = APIError(statusCode: response.statusCode)
            throw apiError.networkError
        }
        if data.isEmpty {
            throw NetworkError.noData
        }
        
        return data
    }
    
    private func buildRequest(_ resource: Resource) throws -> URLRequest {
        var request = URLRequest(url: try resource.url)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return request
    }
    
    private func decode<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()        
        return try decoder.decode(T.self, from: data)
    }
}
