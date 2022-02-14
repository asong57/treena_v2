//
//  ViewController.swift
//  treena_v2
//
//  Created by asong on 2022/02/14.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    private lazy var treeImageView: UIImageView = {
        let image = UIImageView()
        let url = URL(string: "https://postfiles.pstatic.net/MjAyMTA3MjlfMjUg/MDAxNjI3NTY4NjE3Njk1.diWQ2q_gQza_Ll8twVi-eDMNQ-qj534u8HfeyYEbXhQg.vP9slLlDMUibCxJRTzvsn6mtBIXlKANOiiuxJ8mozp8g.JPEG.hahahafb/wood9.jpg?type=w966")
        if let data = try? Data(contentsOf: url!){
            if let imageData = UIImage(data: data){
                image.image = imageData
            }
        }
        return image
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "treena_logo")
        return imageView
    }()
    
    private lazy var mypageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profile"), for: .normal)
        return button
    }()
    
    private lazy var calendarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "calendar"), for: .normal)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

extension HomeVC {
    func configureUI(){
        view.addSubview(treeImageView)
        self.treeImageView.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 100, left: 50, bottom: 180, right: 50))
        }
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        view.addSubview(mypageButton)
        mypageButton.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(30)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.width.height.equalTo(60)
        }
        
        view.addSubview(calendarButton)
        calendarButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view).offset(-80)
            make.left.equalTo(self.view).offset(40)
            make.width.height.equalTo(50)
        }
        
        view.addSubview(plusButton)
        plusButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view).offset(-80)
            make.right.equalTo(self.view).offset(-40)
            make.width.height.equalTo(45)
        }
    }
}

