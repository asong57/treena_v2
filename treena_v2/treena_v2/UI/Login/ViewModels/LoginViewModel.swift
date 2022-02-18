//
//  LoginViewModel.swift
//  treena_v2
//
//  Created by asong on 2022/02/18.
//

import Foundation
import RxSwift
import RxRelay
import Firebase

class LoginViewModel {
    private let disposeBag = DisposeBag()
    var input = Input()
    var output = Output()
    
    struct Input {
        let email = PublishSubject<String>()
        let password = PublishSubject<String>()
        let tapSignIn = PublishSubject<Void>()
    }
    
    struct Output {
        let enableSignInButton = PublishRelay<Bool>()
        let errorMessage = PublishRelay<String>()
        let goToMain = PublishRelay<Void>()
    }
    
    init(){
        input.tapSignIn.withLatestFrom(Observable.combineLatest(input.email, input.password))
            .bind{ [weak self] (email, password) in
                guard let self = self else { return }
                if password.count < 6 {
                    self.output.errorMessage.accept("6자리 이상 비밀번호를 입력해주세요.")
                } else {
                    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                               if user != nil{
                                   print("login success")
                                   self.output.goToMain.accept(())
                               }else{
                                   print("login failed")
                               }
                           }
                }
            }.disposed(by: disposeBag)
    }

}
