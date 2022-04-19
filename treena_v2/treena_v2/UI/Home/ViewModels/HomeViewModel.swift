//
//  HomeViewModel.swift
//  treena_v2
//
//  Created by asong on 2022/02/15.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class HomeViewModel {
    private let disposeBag = DisposeBag()
    
    let treeLevel: Observable<Int>
    var treeImageUrl: BehaviorSubject<String>
    
    init(){
        let diaryUsage: Observable<Int> = DatabaseNetwork.shared.checkDiaryUsage()
        
        treeLevel = diaryUsage.map{
            TreeLevel.setTreeLevel(diaryUsage: $0)
        }
        
        treeImageUrl = BehaviorSubject<String>(value: ImageUrl.treeImageURLList[0])
        treeLevel.subscribe(onNext: { [weak self] in
            self?.treeImageUrl.onNext(ImageUrl.treeImageURLList[$0])
        })
    }
}
