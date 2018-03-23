//
//  GistService+TargetType.sampleData.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

extension GistService {

    var sampleData: Data {
        switch self {
        case .gist:
            return stubData("gist")
        default:
            return stubData("comments")
        }
    }
}

fileprivate func stubData(_ resource: String) -> Data {
    guard let url = Bundle.main.url(forResource: resource, withExtension: "json"),
        let data = try? Data(contentsOf: url) else {
            return Data()
    }
    return data
}
