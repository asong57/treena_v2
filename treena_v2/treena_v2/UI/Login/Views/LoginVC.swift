//
//  LoginVC.swift
//  treena_v2
//
//  Created by asong on 2022/02/18.
//

import Foundation
import UIKit
import RxSwift

class LoginVC: UIViewController {
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindUIWithView()
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "treena_logo")
        return imageView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.background = UIImage(named: "loginbox")
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.background = UIImage(named: "loginbox")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}
extension LoginVC {
    func configureUI(){
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(180)
            make.centerX.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(70)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(400)
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(450)
            make.centerX.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(280)
            make.centerX.equalToSuperview()
            make.width.equalTo(270)
            make.height.equalTo(30)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(320)
            make.centerX.equalToSuperview()
            make.width.equalTo(270)
            make.height.equalTo(30)
        }
        
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(370)
            make.centerX.equalToSuperview()
            make.width.equalTo(270)
            make.height.equalTo(30)
        }
    }
    
    private func bindUIWithView(){
        emailTextField.rx.text.orEmpty.bind(to: viewModel.input.email).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.input.password).disposed(by: disposeBag)
        loginButton.rx.tap.bind(to: viewModel.input.tapSignIn).disposed(by: disposeBag)
        
        viewModel.output.errorMessage.observe(on: MainScheduler.instance).bind(to: errorLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.goToMain.observe(on: MainScheduler.instance).bind (onNext: { [weak self] in
            let homeVC = HomeVC()
            homeVC.view.backgroundColor = .white
            self?.navigationController!.navigationBar.isHidden = true
            self?.navigationController!.pushViewController(homeVC, animated: true)
        }).disposed(by: disposeBag)
        
        registerButton.rx.tap
            .subscribe(onNext:  { [weak self] in
                let signUpVC = SignUpVC()
                signUpVC.view.backgroundColor = .white
                self?.navigationController?.pushViewController(signUpVC, animated: true)
            }).disposed(by: disposeBag)
    }
}
