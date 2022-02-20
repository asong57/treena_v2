//
//  PlusViewModel.swift
//  treena_v2
//
//  Created by asong on 2022/02/20.
//

import Foundation
import RxSwift
import UIKit
import RxRelay

class PlusViewModel {
    private let disposeBag = DisposeBag()
    
    let textViewText: BehaviorSubject<String>
    let todayDate: BehaviorSubject<String>
    var saveButtonTouched: PublishRelay<Void>
    
    
    init(){
        
        textViewText = BehaviorSubject<String>(value: "")
        todayDate = BehaviorSubject<String>(value: "")
        var saveData: Observable<PlusModel> {
            return Observable.combineLatest(textViewText, todayDate){ text, date in
                return PlusModel.init(text: text, date: date)
            }
        }
        
        saveButtonTouched  = PublishRelay<Void>()
        saveButtonTouched.withLatestFrom(saveData).subscribe(onNext: { event in
            DatabaseNetwork.shared.saveDiary(text: event.text, date: event.date)
        }).disposed(by: disposeBag)
      
        let diaryUsage: Observable<Int> = DatabaseNetwork.shared.checkDiaryUsage()
        
        diaryUsage.subscribe(onNext: { element in
            print(element)
        }).disposed(by: disposeBag)

    }
}
