//
//  CalendarVC.swift
//  treena_v2
//
//  Created by asong on 2022/02/15.
//

import Foundation
import UIKit
import FSCalendar
import RxSwift

class CalendarVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    var calendar = FSCalendar()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        configureUI()
        bindUIWithView()
    }
    
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
    
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "home"), for: .normal)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        return button
    }()
    
    func configureUI(){
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
        
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = UIColor.gray
        calendar.appearance.weekdayTextColor = UIColor.gray
        view.addSubview(calendar)
        calendar.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(110)
            make.centerX.equalToSuperview()
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.bottom.equalTo(self.view).offset(-130)
        }
        
        view.addSubview(homeButton)
        homeButton.snp.makeConstraints{ make in
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
    private func bindUIWithView(){
        homeButton.rx.tap
            .subscribe(onNext:  { [weak self] in
                let homeVC = HomeVC()
                homeVC.view.backgroundColor = .white
                self?.navigationController?.pushViewController(homeVC, animated: true)
            }).disposed(by: disposeBag)
        
        plusButton.rx.tap
            .subscribe(onNext:  { [weak self] in
                let plusVC = PlusVC()
                plusVC.view.backgroundColor = .white
                self?.navigationController?.pushViewController(plusVC, animated: true)
            }).disposed(by: disposeBag)
    }
}
extension CalendarVC {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let calendarDetailVC = CalendarDetailVC()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        print(dateFormatter.string(from: date))
        //nextVC.date = dateFormatter.string(from: date)
        calendarDetailVC.view.backgroundColor = .white
        self.navigationController?.pushViewController(calendarDetailVC, animated: true)
    }
}
