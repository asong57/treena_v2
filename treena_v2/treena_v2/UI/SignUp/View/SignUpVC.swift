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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "treena_logo")
        return imageView
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Name"
        textField.font = UIFont(name: "THEAppleR", size: 20)
        textField.background = UIImage(named: "loginbox")
        textField.setLeftPaddingPoints(7)
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Email"
        textField.font = UIFont(name: "THEAppleR", size: 20)
        textField.background = UIImage(named: "loginbox")
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
    
    private lazy var passwordCheckTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Password Check"
        textField.font = UIFont(name: "THEAppleR", size: 20)
        textField.background = UIImage(named: "loginbox")
        textField.isSecureTextEntry = true
        textField.setLeftPaddingPoints(7)
        return textField
    }()
    
    private lazy var passwordNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = "* 비밀번호는 6글자 이상으로 설정해주세요."
        label.font = UIFont(name: "THEAppleL", size: 14)
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named: "signup_black"), for: .normal)
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "THEAppleR", size: 15)
        label.textColor = UIColor(red: 26/255, green: 153/255, blue: 13/255, alpha: 1)
        return label
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension SignUpVC {
    func configureUI(){
        view.addSubview(logoImageView)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordCheckTextField)
        view.addSubview(passwordNoticeLabel)
        view.addSubview(signUpButton)
        view.addSubview(errorLabel)
        
        logoImageView.snp.makeConstraints{ make in
            make.bottom.equalTo(nameTextField.snp.top).offset(-30)
            make.centerX.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(70)
        }
        
        nameTextField.snp.makeConstraints{ make in
            make.bottom.equalTo(emailTextField.snp.top).offset(-10)
            make.centerX.equalToSuperview()
            make.left.equalTo(self.view).offset(53)
            make.right.equalTo(self.view).offset(-53)
            make.height.equalTo(30)
        }
        
        emailTextField.snp.makeConstraints{ make in
            make.bottom.equalTo(passwordTextField.snp.top).offset(-10)
            make.centerX.equalToSuperview()
            make.left.equalTo(self.view).offset(53)
            make.right.equalTo(self.view).offset(-53)
            make.height.equalTo(30)
        }
       
        passwordTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalTo(self.view).offset(53)
            make.right.equalTo(self.view).offset(-53)
            make.height.equalTo(30)
        }
        
        passwordCheckTextField.snp.makeConstraints{ make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.left.equalTo(self.view).offset(53)
            make.right.equalTo(self.view).offset(-53)
            make.height.equalTo(30)
        }
        
        passwordNoticeLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.left.equalTo(self.view).offset(53)
            make.top.equalTo(passwordCheckTextField.snp.bottom).offset(1)
        }
        
        signUpButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalTo(90)
            make.height.equalTo(30)
            make.top.equalTo(passwordNoticeLabel.snp.bottom).offset(20)
        }
        
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
        signUpButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.tapSignUp).disposed(by: disposeBag)
        
        viewModel.output.errorMessage.observe(on: MainScheduler.instance).bind(to: errorLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.goToLogin.observe(on: MainScheduler.instance).bind (onNext: { [weak self] in
            self?.showCompleteSignUpAlert()
        }).disposed(by: disposeBag)
    }
    
    private func showCompleteSignUpAlert(){
        let alert = UIAlertController(title: "회원가입 완료", message: "회원가입이 성공적으로 완료되었습니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}
