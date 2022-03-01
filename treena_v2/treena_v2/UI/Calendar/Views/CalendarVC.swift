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
    let viewModel = CalendarViewModel()
    var dateArr: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
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
    
    private lazy var mypageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profile2"), for: .normal)
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
        
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = UIColor.gray
        calendar.appearance.weekdayTextColor = UIColor.gray
        calendar.appearance.headerTitleFont = UIFont(name: "THEAppleM", size: 18)
        calendar.appearance.weekdayFont = UIFont(name: "TheAppleM", size: 16)
        calendar.appearance.titleFont = UIFont(name: "TheAppleR", size: 15)
        calendar.appearance.todayColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        calendar.appearance.titleTodayColor = UIColor(red: 26/255, green: 153/255, blue: 13/255, alpha: 1)
        calendar.appearance.selectionColor = UIColor(red: 255/255, green: 171/255, blue: 189/255, alpha: 1)
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
        calendarDetailVC.viewModel.todayDate.onNext(dateFormatter.string(from: date))
        calendarDetailVC.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.pushViewController(calendarDetailVC, animated: true)
    }
    
    // 특정 날짜에 이미지 세팅
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let imageDateFormatter = DateFormatter()
        imageDateFormatter.dateFormat = "yyyyMMdd"
        let dateStr = imageDateFormatter.string(from: date)
        let check = DatabaseNetwork.datesWithDiary.contains(dateStr) ? true : false
        print("date: \(dateStr) check : \(check)")
        return check ? UIImage(named: "sprout3") : nil
    }
}
