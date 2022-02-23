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
    var emotionResult: PublishRelay<String>
    var diaryText: BehaviorRelay<String>
  
    init(){
        todayDate = BehaviorSubject<String>(value: "")
        textViewText = BehaviorSubject<String>(value: "")
        saveButtonTouched  = PublishRelay<Void>()
        temporarySaveButtonTouched = PublishRelay<Void>()
        emotionResult = PublishRelay<String>()
        diaryText = BehaviorRelay<String>(value: "")
        
        var saveData: Observable<PlusModel> {
            return Observable.combineLatest(textViewText, todayDate){ text, date in
                return PlusModel.init(text: text, date: date)
            }
        }
        todayDate.subscribe(onNext: { [weak self] date in
            print("date : \(date)")
            if date != "" {
                DatabaseNetwork.shared.getDiary(date: date).subscribe{ [weak self] text in
                    self?.diaryText.accept(text)
                }
                print("데이터베이스 가져오기")
            }
        }).disposed(by: disposeBag)
       
        /*
        emotionResult.subscribe(onNext: { element in
            print(element)
        }).disposed(by: disposeBag)
        */
        temporarySaveButtonTouched.withLatestFrom(saveData).subscribe(onNext: { event in
            DatabaseNetwork.shared.saveDiary(text: event.text, date: event.date)
        }).disposed(by: disposeBag)
        
        saveButtonTouched.withLatestFrom(saveData).subscribe(onNext: { [weak self] event in
            DatabaseNetwork.shared.saveDiary(text: event.text, date: event.date)
            ApiNetwork.shared.getEmotion(text: event.text).subscribe{ event in
                switch event {
                case let .next(answer):
                    print("PlusViewModel emotion : \(answer)")
                    self!.emotionResult.accept(answer)
                default: break
                }
            }
        }).disposed(by: disposeBag)
    }
}
