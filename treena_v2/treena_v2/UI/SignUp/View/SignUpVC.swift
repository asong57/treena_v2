//
//  SignUpVC.swift
//  treena_v2
//
//  Created by asong on 2022/02/28.
//

import Foundation
import UIKit
import RxSwift

class SignUpVC: UIViewController {
    private let viewModel = SignUpViewModel()
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
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Name"
        textField.background = UIImage(named: "loginbox")
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Email"
        textField.background = UIImage(named: "loginbox")
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Password"
        textField.background = UIImage(named: "loginbox")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var passwordCheckTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Password Check"
        textField.background = UIImage(named: "loginbox")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var passwordNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호는 6글자 이상으로 설정해주세요."
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named: "blackbox"), for: .normal)
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}
extension SignUpVC {
    func configureUI(){
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(150)
            make.centerX.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(70)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(240)
            make.centerX.equalToSuperview()
            make.width.equalTo(270)
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
        
        view.addSubview(passwordCheckTextField)
        passwordCheckTextField.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(360)
            make.centerX.equalToSuperview()
            make.width.equalTo(270)
            make.height.equalTo(30)
        }
        
        view.addSubview(passwordNoticeLabel)
        passwordNoticeLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(passwordCheckTextField.snp.bottom).offset(10)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(30)
            make.top.equalTo(passwordNoticeLabel.snp.bottom).offset(20)
        }
        
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpButton.snp.bottom).offset(30)
        }
    }
    
    private func bindUIWithView(){
        nameTextField.rx.text.orEmpty.bind(to: viewModel.input.name).disposed(by: disposeBag)
        emailTextField.rx.text.orEmpty.bind(to: viewModel.input.email).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.input.password).disposed(by: disposeBag)
        passwordCheckTextField.rx.text.orEmpty.bind(to: viewModel.input.passwordCheck).disposed(by: disposeBag)
        signUpButton.rx.tap.bind(to: viewModel.input.tapSignUp).disposed(by: disposeBag)
        
        viewModel.output.errorMessage.observe(on: MainScheduler.instance).bind(to: errorLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.goToLogin.observe(on: MainScheduler.instance).bind (onNext: { [weak self] in
            let loginVC = LoginVC()
            loginVC.view.backgroundColor = .white
            self?.navigationController!.navigationBar.isHidden = true
            self?.navigationController!.pushViewController(loginVC, animated: true)
        }).disposed(by: disposeBag)
    }
}
