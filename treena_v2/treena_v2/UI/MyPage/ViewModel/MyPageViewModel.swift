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
    var logoutTouched: PublishRelay<Void>
    var deleteUserTouched: PublishRelay<Void>
    
    init(){
        resetPasswordTouched = PublishRelay<Void>()
        logoutTouched = PublishRelay<Void>()
        deleteUserTouched = PublishRelay<Void>()
        
        resetPasswordTouched.subscribe(onNext: { event in
            DatabaseNetwork.shared.resetPassword()
        }).disposed(by: disposeBag)
        
        logoutTouched.subscribe(onNext: { event in
            DatabaseNetwork.shared.logout()
        }).disposed(by: disposeBag)
        
        deleteUserTouched.subscribe(onNext: { event in
            DatabaseNetwork.shared.deleteUser()
        }).disposed(by: disposeBag)
    }
}
