//
//  SignUpViewModel.swift
//  treena_v2
//
//  Created by asong on 2022/02/28.
//

import Foundation
import RxSwift
import RxRelay
import Firebase

class SignUpViewModel {
    private let disposeBag = DisposeBag()
    var input = Input()
    var output = Output()
    
    struct Input {
        let name = PublishSubject<String>()
        let email = PublishSubject<String>()
        let password = PublishSubject<String>()
        let passwordCheck = PublishSubject<String>()
        let tapSignUp = PublishSubject<Void>()
    }
    
    struct Output {
        let enableSignInButton = PublishRelay<Bool>()
        let errorMessage = PublishRelay<String>()
        let goToLogin = PublishRelay<Void>()
    }
    
    init(){
        input.tapSignUp.withLatestFrom(Observable.combineLatest(input.email, input.password, input.name, input.passwordCheck))
            .bind{ [weak self] (email, password, name, passwordCheck) in
                
                guard let self = self else { return }
                if name == ""{
                    self.output.errorMessage.accept("이름을 입력해주세요.")
                } else if password.count < 6 {
                    self.output.errorMessage.accept("6자리 이상 비밀번호를 입력해주세요.")
                } else if passwordCheck != password {
                    self.output.errorMessage.accept("비밀번호를 다시 확인해 주세요.")
                } else {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if authResult != nil{
                            DatabaseNetwork.shared.setUid()
                            DatabaseNetwork.shared.singUpUser(name: name)
                            self.output.errorMessage.accept("")
                            self.output.goToLogin.accept(())
                        } else {
                            self.output.errorMessage.accept("회원가입에 실패했습니다.")
                        }
                    }
                }
            }.disposed(by: disposeBag)
    }
}
