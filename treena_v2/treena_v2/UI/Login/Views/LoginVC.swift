//
//  LoginVC.swift
//  treena_v2
//
//  Created by asong on 2022/02/18.
//

import UIKit
import RxSwift
import FirebaseAuth

class LoginVC: UIViewController {
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindUIWithView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension LoginVC {
    func configureUI(){
        view.addSubview(logoImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        logoImageView.snp.makeConstraints{ make in
            make.bottom.equalTo(emailTextField.snp.top).offset(-30)
            make.centerX.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(70)
        }
        
        emailTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(passwordTextField.snp.top).offset(-10)
            make.left.equalTo(self.view).offset(53)
            make.right.equalTo(self.view).offset(-53)
            make.height.equalTo(30)
        }
        
        passwordTextField.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
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
        loginButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.tapSignIn).disposed(by: disposeBag)
        
        viewModel.output.errorMessage.observe(on: MainScheduler.instance).bind(to: errorLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.goToMain.observe(on: MainScheduler.instance).bind (onNext: { [weak self] in
            let homeVC = HomeVC()
            homeVC.view.backgroundColor = .white
            self?.navigationController!.navigationBar.isHidden = true
            self?.navigationController!.pushViewController(homeVC, animated: true)
        }).disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext:  { [weak self] in
                let signUpVC = SignUpVC()
                signUpVC.view.backgroundColor = .white
                self?.navigationController?.navigationBar.tintColor = .black
                self?.navigationController?.navigationBar.topItem?.title = ""
                self?.navigationController?.pushViewController(signUpVC, animated: true)
            }).disposed(by: disposeBag)
    }
}

