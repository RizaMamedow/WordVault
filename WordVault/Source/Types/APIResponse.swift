//
//  APIResponse.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

enum APIResponse<T: Decodable>: Decodable {
    case array([T])
    case dictionary([String: T])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let array = try? container.decode([T].self) {
            self = .array(array)
        } else if let dictionary = try? container.decode([String: T].self) {
            self = .dictionary(dictionary)
        } else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Data does not match expected formats"
            )
        }
    }
}
