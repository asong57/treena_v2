//
//  LoginVC.swift
//  treena_v2
//
//  Created by asong on 2022/02/18.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
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
    
    private lazy var idTextField: UITextField = {
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
        
        view.addSubview(idTextField)
        idTextField.snp.makeConstraints{ make in
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
    }
    
    private func bindUIWithView(){
       
    }
}
