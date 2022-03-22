//
//  TreeLevel.swift
//  treena_v2
//
//  Created by asong on 2022/02/18.
//

import Foundation

class TreeLevel {
    // treeLevel 세팅
    static func setTreeLevel(diaryUsage: Int) -> Int{
        if (diaryUsage <= 2 && diaryUsage >= 0) {
            return 0
        }
        if (diaryUsage > 2 && diaryUsage <= 7) {
            return 1
        }
        if (diaryUsage > 7 && diaryUsage <= 14) {
            return 2
        }
        if (diaryUsage > 14 && diaryUsage <= 21) {
            return 3
        }
        if (diaryUsage > 21 && diaryUsage <= 28) {
            return 4
        }
        if (diaryUsage > 28 && diaryUsage <= 35) {
            return 5
        }
        if (diaryUsage > 35 && diaryUsage <= 42) {
            return 6
        }
        if (diaryUsage > 42 && diaryUsage <= 49) {
            return 7
        }
        if (diaryUsage > 49 ) {
            return 8
        }
        return 0
    }
}
