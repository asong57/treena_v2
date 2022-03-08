//
//  EmotionCommentModel.swift
//  treena_v2
//
//  Created by asong on 2022/02/24.
//

import Foundation
import UIKit

struct EmotionCommentModel: Codable {
    var emotions: [EmotionInfo]
    
    struct EmotionInfo: Codable{
        var id: Int
        var name: String
        var type: Int
        var response: [String]
    }
    
    // EmotionResult.json 파싱
    static func parseEmotionResult() -> EmotionCommentModel{
        let jsonDecoder = JSONDecoder()
        let emotionData: NSDataAsset = NSDataAsset(name: "emotion_json")!
        let emotionJson = try! jsonDecoder.decode(EmotionCommentModel.self, from: emotionData.data)
        return emotionJson
    }
}
