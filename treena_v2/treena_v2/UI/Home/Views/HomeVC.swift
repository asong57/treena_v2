//
//  ViewController.swift
//  treena_v2
//
//  Created by asong on 2022/02/14.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeVC: UIViewController {
    private let disposeBag = DisposeBag()
    private lazy var viewModel = HomeViewModel()
    
    private lazy var treeImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "treena_logo")
        return imageView
    }()
    
    private lazy var mypageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profile2"), for: .normal)
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
        bindUIWithView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension HomeVC {
    func configureUI(){
        view.addSubview(treeImageView)
        self.treeImageView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(500)
            make.width.equalTo(360)
        }
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        view.addSubview(mypageButton)
        mypageButton.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(40)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.width.equalTo(75)
            make.height.equalTo(60)
        }
        
        view.addSubview(calendarButton)
        calendarButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view).offset(-70)
            make.left.equalTo(self.view).offset(40)
            make.height.equalTo(50)
            make.width.equalTo(55)
        }
        
        view.addSubview(plusButton)
        plusButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view).offset(-70)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(45)
            make.width.equalTo(50)
        }
    }
    
    private func bindUIWithView(){
        calendarButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext:  { [weak self] in
                // ???????????????????????? ?????? ????????? ?????? ?????? ???????????? ?????????
                DatabaseNetwork.shared.getDiaryDatesWithoutObserver()
                DatabaseNetwork.shared.completionHandler = { [weak self] check in
                    if check {
                        let calendarVC = CalendarVC()
                        calendarVC.view.backgroundColor = .white
                        self?.navigationController?.pushViewController(calendarVC, animated: true)
                    }
                }
            }).disposed(by: disposeBag)
        
        plusButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext:  { [weak self] in
                let plusVC = PlusVC()
                plusVC.view.backgroundColor = .white
                self?.navigationController?.pushViewController(plusVC, animated: true)
            }).disposed(by: disposeBag)
        
        mypageButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext:  { [weak self] in
                let myPageVC = MyPageVC()
                myPageVC.view.backgroundColor = .white
                self?.navigationController?.pushViewController(myPageVC, animated: true)
            }).disposed(by: disposeBag)
        
        viewModel.treeImageUrl.subscribe(onNext: { [weak self] url in
            self?.treeImageView.setImageWithUrl(url)
        })
    }
}

