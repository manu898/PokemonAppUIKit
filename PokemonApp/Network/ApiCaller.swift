//
//  APICaller.swift
//  Interview
//
//  Created by Manuel Caparrelli on 11/04/23.
//

import Foundation

class ApiCaller {
    enum APError: Error {
        case invalidQuery(url: String)
        case parseError
        case invalidResponse
        case custom(error: Error)
    }
    
    static var shared = ApiCaller()
    
    private init() { }
    
    func urlCompose(baseURL: String, query: Any) -> String {
        var url = baseURL
        
        if let query = query as? [String: Any] {
            url += "?"
            for (key, value) in query {
                url += key + "=\(value)&"
            }
        } else {
            url += "/\(query)"
        }
        
        return url
    }
    
    func performApiRequest<T: Codable>(query: Any,
                                       baseURL: String) async throws -> T {
        let url = urlCompose(baseURL: baseURL, query: query)
        
        guard let url = URL(string: url)
        else { throw APError.invalidQuery(url: url) }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else { throw APError.invalidResponse }
            
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
            else { throw APError.parseError }
            
            return decodedData
            
        } catch {
            throw APError.custom(error: error)
        }
    }
}

