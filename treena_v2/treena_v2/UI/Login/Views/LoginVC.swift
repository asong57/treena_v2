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
        textField.placeholder = " Email"
        textField.font = UIFont(name: "THEAppleR", size: 20)
        textField.background = UIImage(named: "loginbox")
        // TextField 앞에 여백 주기
        textField.setLeftPaddingPoints(7)

        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Password"
        textField.font = UIFont(name: "THEAppleR", size: 20)
        textField.background = UIImage(named: "loginbox")
        textField.isSecureTextEntry = true
        textField.setLeftPaddingPoints(7)
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "login_black"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "signup_white"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "THEAppleR", size: 15)
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
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(280)
            make.centerX.equalToSuperview()
            make.left.equalTo(self.view).offset(53)
            make.right.equalTo(self.view).offset(-53)
            make.height.equalTo(30)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{ make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.left.equalTo(self.view).offset(53)
            make.right.equalTo(self.view).offset(-53)
            make.height.equalTo(30)
        }
        
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints{ make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints{ make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints{ make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(90)
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
        
        signUpButton.rx.tap
            .subscribe(onNext:  { [weak self] in
                let signUpVC = SignUpVC()
                signUpVC.view.backgroundColor = .white
                self?.navigationController?.navigationBar.tintColor = .black
                self?.navigationController?.navigationBar.topItem?.title = ""
                self?.navigationController?.pushViewController(signUpVC, animated: true)
            }).disposed(by: disposeBag)
    }
}

