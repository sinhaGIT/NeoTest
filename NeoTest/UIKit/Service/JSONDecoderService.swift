//
//  JSONDecoderService.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 09/01/25.
//
//  JSONDecoderService is a utility class responsible for handling JSON decoding operations.
//  It provides generic methods for decoding JSON data into Swift models, enabling code reusability
//  and reducing duplication of JSON parsing logic across the app.
//

import Foundation

struct JSONDecoderService {
    
    /// Decodes JSON data into the specified model type.
    ///
    /// - Parameters:
    ///   - type: The model type to decode the JSON data into.
    ///   - data: The JSON data to decode.
    /// - Returns: An instance of the specified model type, or `nil` if decoding fails.
    ///
    static func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}
