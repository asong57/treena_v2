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
    var temporarySaveButtonTouched: PublishRelay<Void>
    var emotionResult: BehaviorRelay<String>
   
    init(){
        textViewText = BehaviorSubject<String>(value: "")
        todayDate = BehaviorSubject<String>(value: "")
        saveButtonTouched  = PublishRelay<Void>()
        temporarySaveButtonTouched = PublishRelay<Void>()
        var saveData: Observable<PlusModel> {
            return Observable.combineLatest(textViewText, todayDate){ text, date in
                return PlusModel.init(text: text, date: date)
            }
        }
        emotionResult = BehaviorRelay<String>(value: "happy")
        emotionResult.subscribe(onNext: { element in
            print(element)
        }).disposed(by: disposeBag)
        
        temporarySaveButtonTouched.withLatestFrom(saveData).subscribe(onNext: { [weak self] event in
            DatabaseNetwork.shared.saveDiary(text: event.text, date: event.date)
        })
        
        saveButtonTouched.withLatestFrom(saveData).subscribe(onNext: { [weak self] event in
            DatabaseNetwork.shared.saveDiary(text: event.text, date: event.date)
            ApiNetwork.shared.getEmotion(text: event.text).subscribe{ [weak self] event in
                switch event {
                case let .next(answer):
                    print("event : \(event)")
                    self!.emotionResult.accept(answer)
                default: break
                }
            }
        }).disposed(by: disposeBag)
    }
}
