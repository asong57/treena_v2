//
//  CalendarViewModel.swift
//  treena_v2
//
//  Created by asong on 2022/02/24.
//

import Foundation
import RxRelay
import RxSwift

class CalendarViewModel {
    private let disposeBag = DisposeBag()
    
    let diaryDates: PublishRelay<[String]>
    let dateInput: PublishRelay<String>
    let checkDiaryExisted: PublishRelay<Bool>
    init(){
        diaryDates = PublishRelay<[String]>()
        dateInput = PublishRelay<String>()
        checkDiaryExisted = PublishRelay<Bool>()
    }
}
