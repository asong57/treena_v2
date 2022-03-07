//
//  HideAPI+Bundle.swift
//  treena_v2
//
//  Created by asong on 2022/03/07.
//

import Foundation

extension Bundle {
    var apiUrl: String {
        guard let file = self.path(forResource: "API_URL", ofType: "plist") else { return " " }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["API_URL"] as? String else { fatalError("API_URL.plist key 설정을 해주세요.")}
        return key
    }
}
