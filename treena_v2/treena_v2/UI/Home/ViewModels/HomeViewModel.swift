//
//  HomeViewModel.swift
//  treena_v2
//
//  Created by asong on 2022/02/15.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    private let disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        let tapCalendar = PublishSubject<Void>()
    }
    
    struct Output {
        let errorMessage = PublishRelay<String>()
    }
    
    
    init(){
       
    }
    
}
