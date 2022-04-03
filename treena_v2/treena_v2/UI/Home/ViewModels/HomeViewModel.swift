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
    
    let treeImage: Observable<UIImage>
    let treeLevel: Observable<Int>
    var treeImageUrl: BehaviorSubject<String>
    
    init(){
        let diaryUsage: Observable<Int> = DatabaseNetwork.shared.checkDiaryUsage()
        
        treeLevel = diaryUsage.map{
            TreeLevel.setTreeLevel(diaryUsage: $0)
        }
        
        treeImage = diaryUsage.map{
            TreeLevel.setTreeLevel(diaryUsage: $0)
        }.map{
            URL(string: ImageUrl.treeImageURLList[$0])
        }.map{
            try! Data(contentsOf: $0!)
        }.map{
            UIImage(data: $0)!
        }
        
        // 트리이미지 url 캐시 위한 url 전달 코드
        treeImageUrl = BehaviorSubject<String>(value: ImageUrl.treeImageURLList[0])
        treeLevel.subscribe(onNext: { [weak self] in
            self?.treeImageUrl.onNext(ImageUrl.treeImageURLList[$0])
            print($0)
        })
    }
}
