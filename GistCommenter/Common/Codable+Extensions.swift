//
//  Codable+Extensions.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

internal protocol CodableExtension {
    var json: String? { get }
    var jsonData: Data? { get }

    init?(data: Data)
    init?(_ json: String, using encoding: String.Encoding)
    init?(fromURL url: String)
}

internal extension CodableExtension {
    static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}

extension CodableExtension where Self: Codable {
    init?(data: Data) {
        guard let me = try? Self.jsonDecoder.decode(Self.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
