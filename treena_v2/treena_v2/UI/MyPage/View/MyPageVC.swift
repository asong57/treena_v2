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
        view.addSubview(logoutButton)
        view.addSubview(resetPasswordButton)
        view.addSubview(deleteUserButton)
        
        logoImageView.snp.makeConstraints{ make in
            //make.top.equalTo(self.view).offset(160)
            make.centerX.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(70)
            make.bottom.equalTo(logoutButton.snp.top).offset(-40)
        }

        logoutButton.snp.makeConstraints{ make in
            //make.top.equalTo(self.logoImageView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(resetPasswordButton.snp.top).offset(-30)
        }
        
        resetPasswordButton.snp.makeConstraints{ make in
            //make.top.equalTo(self.logoutButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        deleteUserButton.snp.makeConstraints{ make in
            make.top.equalTo(self.resetPasswordButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func bindUIWithView(){
        resetPasswordButton.rx.tap.bind(to:viewModel.resetPasswordTouched).disposed(by: disposeBag)
        viewModel.resetPasswordTouched.subscribe(onNext: { [weak self] event in
            self?.showAlert(title: "비밀번호 변경", message: "비밀번호 변경을 위한 이메일이 발송되었습니다.")
        })
        logoutButton.rx.tap.bind(to: viewModel.logoutTouched).disposed(by: disposeBag)
        viewModel.logoutTouched.subscribe(onNext: {[weak self] event in
            let loginVC = LoginVC()
            loginVC.view.backgroundColor = .white
            self?.navigationController?.pushViewController(loginVC, animated: true)
        })
        deleteUserButton.rx.tap.bind(to: viewModel.deleteUserTouched).disposed(by: disposeBag)
        viewModel.deleteUserTouched.subscribe(onNext: {[weak self] event in
            self?.showAlert(title: "탈퇴", message: "탈퇴가 성공적으로 완료되었습니다.")
        })
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message,  preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            let loginVC = LoginVC()
            loginVC.view.backgroundColor = .white
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}
