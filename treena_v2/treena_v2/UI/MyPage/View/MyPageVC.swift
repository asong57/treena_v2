//
//  MyPageVC.swift
//  treena_v2
//
//  Created by asong on 2022/02/25.
//

import Foundation
import UIKit

class MyPageVC: UIViewController{
    
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
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var findPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var deleteUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("탈퇴", for: .normal)
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
            make.top.equalTo(self.logoImageView.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(findPasswordButton)
        findPasswordButton.snp.makeConstraints{ make in
            make.top.equalTo(self.logoutButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(deleteUserButton)
        deleteUserButton.snp.makeConstraints{ make in
            make.top.equalTo(self.findPasswordButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    private func bindUIWithView(){
        
    }
}
