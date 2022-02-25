//
//  MyPageViewModel.swift
//  treena_v2
//
//  Created by asong on 2022/02/25.
//

import Foundation
import RxSwift
import RxRelay

class MyPageViewModel {
    private let disposeBag = DisposeBag()
    
    var resetPasswordTouched: PublishRelay<Void>
    init(){
        resetPasswordTouched = PublishRelay<Void>()
        
        resetPasswordTouched.subscribe(onNext: { event in
            DatabaseNetwork.shared.resetPasswordClicked()
        }).disposed(by: disposeBag)
    }
}
