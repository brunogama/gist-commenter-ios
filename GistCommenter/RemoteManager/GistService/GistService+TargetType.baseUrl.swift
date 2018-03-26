//
//  GistService+TargetType.baseUrl.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

extension GistService {

    var baseURL: URL {
        let bundleData = Bundle.main.object(forInfoDictionaryKey: "API_URL")
        guard let apiUrl = bundleData as? String,
            let url = URL(string: "https://\(apiUrl)") else {
                fatalError("baseURL no created API_URL returned by the Info.plist <\(String(describing: bundleData))>")
        }
        return url
    }
}
