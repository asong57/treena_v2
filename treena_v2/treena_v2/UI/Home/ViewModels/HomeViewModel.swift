//
//  HomeViewModel.swift
//  treena_v2
//
//  Created by asong on 2022/02/15.
//

import Foundation
import RxSwift

protocol HomeViewModelType {
    var moveToCalendar: AnyObserver<Void> { get }
}

class HomeViewModel: HomeViewModelType {
    private let disposeBag = DisposeBag()
    
    let moveToCalendar: AnyObserver<Void>
    
    init(){
        let home = PublishSubject<Void>()
        
        moveToCalendar = home.asObserver()
    }
    
    
    
}
