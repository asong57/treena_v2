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
    
    init(){
        let diaryUsage: Observable<Int> = DatabaseNetwork.shared.checkDiaryUsage()
        print("HomeViewModel init")
        diaryUsage.subscribe(onNext: { element in
            print(element)
        }).disposed(by: disposeBag)
        
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
        
        // 데이터베이스에서 일기 작성한 날짜 배열 체크하는 메서드
        DatabaseNetwork.shared.getDiaryDatesWithoutObserver()
    }
}
