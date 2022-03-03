//
//  CalendarDetailViewModel.swift
//  treena_v2
//
//  Created by asong on 2022/02/23.
//

import Foundation
import RxSwift
import RxRelay

class CalendarDetailViewModel: PlusViewModel{
    private let disposeBag = DisposeBag()
    
    var beforeButtonTouched: PublishRelay<Void>
    var nextButtonTouched: PublishRelay<Void>

    
    override init(){
        beforeButtonTouched = PublishRelay<Void>()
        nextButtonTouched = PublishRelay<Void>()
        super.init()
        
        beforeButtonTouched.subscribe(onNext: { [weak self] event in
            self?.minusDate()
        }).disposed(by: disposeBag)
        nextButtonTouched.subscribe(onNext: { [weak self] event in
            self?.plusDate()
        }).disposed(by: disposeBag)
    }
    
    func minusDate(){
        super.todayDate.onNext(try! checkDateException( String(Int(todayDate.value())! - 1)))
    }
    
    func plusDate(){
        super.todayDate.onNext(try! checkDateException(String(Int(todayDate.value())! + 1)))
    }
    
    func checkDateException(_ inputDate: String) -> String {
        let startDayIdx: String.Index = inputDate.index(inputDate.startIndex, offsetBy: 6)
        var day: Int = Int(String(inputDate[startDayIdx...]))!
        
        let startMonthIdx: String.Index = inputDate.index(inputDate.startIndex, offsetBy: 4)
        let endMonthIdx: String.Index = inputDate.index(inputDate.startIndex, offsetBy: 5)
        var month: Int = Int(String(inputDate[startMonthIdx...endMonthIdx]))!
        
        let endYearIdx: String.Index = inputDate.index(inputDate.startIndex, offsetBy: 3)
        var year: Int = Int(String(inputDate[...endYearIdx]))!
        
        let monthDates = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        if month == 2 && day > 28 {
            month = 3
            day = 1
            return String(year) + "0301"
        }
        
        if day >= 1 && day <= 30{
            return inputDate
        }
        
        if day == 32 && (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 ){
            month = month+1
            day = 1
            if month == 13 {
                month = 1
                year = year+1
            }
        }
        
        if day == 31 && (month == 4 || month == 6 || month == 9 || month == 11) {
            month = month+1
            day = 1
            if month == 13 {
                month = 1
                year = year+1
            }
        }
        
        if day == 0 {
            month = month-1
            if month == 0 {
                month = 12
                year = year-1
            }
            day = monthDates[month-1]
        }
        
        var monthString: String = String(month)
        if month < 10 {
            monthString = "0"+monthString
        }
        
        var dayString: String = String(day)
        if day < 10 {
            dayString = "0"+dayString
        }
        
        return String(year) + monthString + dayString
    }
}
