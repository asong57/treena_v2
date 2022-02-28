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
   // private let viewModel = LoginViewModel()
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
        textField.background = UIImage(named: "loginbox")
        return textField
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
    
    private lazy var passwordCheckTextField: UITextField = {
        let textField = UITextField()
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
    }
    
    private func bindUIWithView(){

    }
}
