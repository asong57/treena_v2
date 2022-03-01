//
//  MyPageVC.swift
//  treena_v2
//
//  Created by asong on 2022/02/25.
//

import Foundation
import UIKit
import RxSwift

class MyPageVC: UIViewController{
    private let disposeBag = DisposeBag()
    let viewModel = MyPageViewModel()
    
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
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.titleLabel?.font = UIFont(name: "THEAppleR", size: 18)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var resetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 변경", for: .normal)
        button.titleLabel?.font = UIFont(name: "THEAppleR", size: 18)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var deleteUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("탈퇴", for: .normal)
        button.titleLabel?.font = UIFont(name: "THEAppleR", size: 18)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    func configureUI(){
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(160)
            make.centerX.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(70)
        }

        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints{ make in
            make.top.equalTo(self.logoImageView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(resetPasswordButton)
        resetPasswordButton.snp.makeConstraints{ make in
            make.top.equalTo(self.logoutButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(deleteUserButton)
        deleteUserButton.snp.makeConstraints{ make in
            make.top.equalTo(self.resetPasswordButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func bindUIWithView(){
        resetPasswordButton.rx.tap.bind(to:viewModel.resetPasswordTouched).disposed(by: disposeBag)
        logoutButton.rx.tap.bind(to: viewModel.logoutTouched).disposed(by: disposeBag)
        viewModel.logoutTouched.subscribe(onNext: {[weak self] event in
            let loginVC = LoginVC()
            loginVC.view.backgroundColor = .white
            self?.navigationController?.pushViewController(loginVC, animated: true)
        })
        deleteUserButton.rx.tap.bind(to: viewModel.deleteUserTouched).disposed(by: disposeBag)
        viewModel.deleteUserTouched.subscribe(onNext: {[weak self] event in
            let loginVC = LoginVC()
            loginVC.view.backgroundColor = .white
            self?.navigationController?.pushViewController(loginVC, animated: true)
        })
    }
}
