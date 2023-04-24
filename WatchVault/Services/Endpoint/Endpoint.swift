//
//  NetworkManager.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 12.04.2023.
//

import SwiftUI

struct Endpoint {
    let baseURL: String
    let path: String
    let parameters: Parameters?
    var requestURL: String {
        var url = "\(baseURL)/\(path)"
        guard let parameters else { return url }
        url += "?"
        parameters.forEach({ key, value in
            url += "\(key)=\(value)&"
        })
        url.removeLast()
        return url
    }
    
    init(baseURL: String, path: String, parameters: Parameters? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.parameters = parameters
    }
    
    func request() async -> Data? {
        guard let url = URL(string: requestURL) else {
            print("Invalid URL: \(requestURL)")
            return nil
        }
        do {
            print("Request: \(requestURL)")
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Response not found.")
                return nil
            }
            guard (200..<300).contains(httpResponse.statusCode) else {
                print("Request failed with status code of: \(httpResponse)")
                return nil
            }
            return data
        } catch {
            print("Request error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func request<T: Decodable>(_ type: T.Type) async -> T? {
        guard let data = await request()
        else {
            print("Data request failed.")
            return nil
        }
        guard let decodedData = try? JSONDecoder().decode(type, from: data) else {
            print("Data decoding failed.")
            return nil
        }
        return decodedData
    }

    func imageRequest() async -> UIImage? {
        guard let data = await request()
        else {
            return nil
        }
        return UIImage(data: data)
    }
}
