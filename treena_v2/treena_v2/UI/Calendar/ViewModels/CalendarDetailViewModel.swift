//
//  CalendarDetailViewModel.swift
//  treena_v2
//
//  Created by asong on 2022/02/23.
//

import Foundation
import RxSwift
import RxRelay

class CalendarDetailViewModel: PlusViewModel{
    private let disposeBag = DisposeBag()
    
    var beforeButtonTouched: PublishRelay<Void>
    var nextButtonTouched: PublishRelay<Void>

    
    override init(){
        beforeButtonTouched = PublishRelay<Void>()
        nextButtonTouched = PublishRelay<Void>()
        super.init()
        
        beforeButtonTouched.subscribe(onNext: { [weak self] event in
            self?.minusDate()
        }).disposed(by: disposeBag)
        nextButtonTouched.subscribe(onNext: { [weak self] event in
            self?.plusDate()
        }).disposed(by: disposeBag)
    }
    func minusDate(){
        super.todayDate.onNext(try! String(Int(todayDate.value())! - 1))
    }
    func plusDate(){
        super.todayDate.onNext(try! String(Int(todayDate.value())! + 1))
    }
}
