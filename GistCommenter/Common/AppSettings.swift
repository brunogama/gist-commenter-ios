//
//  AppSettings.swift
//  GistCommenter
//
//  Created by Bruno Gama on 26/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation
import KeychainAccess

// swiftlint:disable type_name
internal final class AppSettings {

    struct Keys {
        private static var identifier: String = {
            Bundle.main.bundleIdentifier!
        }()

        private static var hashedTokenKey: String {
            return "\(identifier).token"
        }

        static var hasToken: Bool {
            return token != nil ? true : false
        }

        static var token: String? {
            return Keychain(service: identifier)[string: hashedTokenKey]
        }

        static func save(token: String) {
            Keychain(service: identifier)[string: hashedTokenKey] = token
        }
    }

    struct Api {
        private static func bundleData(forKey: String) -> Any? {
            return Bundle.main.object(forInfoDictionaryKey: forKey)
        }

        static var baseUrl: URL {
            guard let apiUrl = self.bundleData(forKey: "API_URL") as? String,
                let url = URL(string: "https://\(apiUrl)") else {
                    fatalError("baseURL no created API_URL returned by the Info.plist")
            }
            return url
        }

        static var key: String {
            guard let key = self.bundleData(forKey: "API_KEY") as? String else {
                fatalError("baseURL no created API_KEY returned by the Info.plist")
            }
            return key
        }

        static var secret: String {
            guard let secret = self.bundleData(forKey: "API_SECRET") as? String else {
                fatalError("baseURL no created API_SECRET returned by the Info.plist")
            }
            return secret
        }
    }
}
// swiftlint:enable
