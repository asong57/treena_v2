//
//  HomeViewModel.swift
//  treena_v2
//
//  Created by asong on 2022/02/15.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class HomeViewModel {
    private let disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        let tapCalendar = PublishSubject<Void>()
    }
    
    struct Output {
        let errorMessage = PublishRelay<String>()
    }
    
    let treeLevel: Observable<String>
    var treeImageURLList : [String] = ["https://postfiles.pstatic.net/MjAyMTA3MjlfMjA3/MDAxNjI3NTY4NjE3Mjcx.DAnQNog3Cyr18qAv4ke17sWV0Ye3R1bBpiyilMO7J0Qg.dVECs9WmdPKnlH-8DODBy-aqXcA5wBPoVGSHeXcVMyMg.JPEG.hahahafb/wood1.jpg?type=w966",
                                              "https://postfiles.pstatic.net/MjAyMTA3MjlfMTg0/MDAxNjI3NTY4NjE3MzYw.LBABIbXm8OOg_7IkyTfFWN09L5MKulEW8sQe37ivtHQg.-eRZWUupFMLdMiXeGOA5JxB682YG6OSXvmIiufHMPxIg.JPEG.hahahafb/wood2.jpg?type=w966",
                                                       "https://postfiles.pstatic.net/MjAyMTA3MjlfMjEx/MDAxNjI3NTcwMjQwMTky.7FTr3ZXlKzqjDNJFpIozdB0tqhyWhHFPrIg-TxeqsQgg.zzg8zUuKkdcbKct-OYveJOW66nslK5kVqCMEmeiD9JEg.JPEG.hahahafb/wood3.jpg?type=w966",
                                               "https://postfiles.pstatic.net/MjAyMTA3MjlfMjE1/MDAxNjI3NTY4NjE3MzM1.zkDUA6_N9VZVeVvBs1Fq_P9Jarbd1t0gn5HNKfU4Yjcg.vBk5MFsLsDkjR-CaW2W4FC3xkV5bLDVcJ1iSs1kfTeMg.JPEG.hahahafb/wood4.jpg?type=w966",
                                               "https://postfiles.pstatic.net/MjAyMTA3MjlfMjA5/MDAxNjI3NTY4NjE3MzUx.cjKKjFNR1MVkP7jStnxaD5n4TwTzSxZ27m7e4UFaLG8g.3CXyfBGR_oz-chD5Fy9clqgwOBLZ7JOWGDZ6wFtfYO8g.JPEG.hahahafb/wood5.jpg?type=w966",
                                               "https://postfiles.pstatic.net/MjAyMTA3MjlfNjcg/MDAxNjI3NTY4NjE3MzYw.Pjru3AoxNWqDOIhv6Nou9r2L6nSphVWNEMey3v-5704g.Q431roZ5UeD_2te-GnJ1mWERCiYqXgOnvqk9LhC3fbwg.JPEG.hahahafb/wood6.jpg?type=w966",
                                               "https://postfiles.pstatic.net/MjAyMTA3MjlfNTEg/MDAxNjI3NTY4NjE3Mzg1.Em290aKXCBpxn1cqGNH3qt7d-aDEBljoZCaXtsNBfhog.HYBkVjxHr3KbbUGeEbY_igJFJNIw7OWaOPJDVvXOYCcg.JPEG.hahahafb/wood7.jpg?type=w966",
                                              "https://postfiles.pstatic.net/MjAyMTA3MjlfMjAx/MDAxNjI3NTY4NjE3NTkx.7n5dJb1vZXaZ2CMLMjAMRpnB0hfLs0aYYUDJzI3d_aEg.tbvVgbOKnaFw60NgmwBDWlPGh9efxFyMiXfnUsISM_Ig.JPEG.hahahafb/wood8.jpg?type=w966",
                                               "https://postfiles.pstatic.net/MjAyMTA3MjlfMjUg/MDAxNjI3NTY4NjE3Njk1.diWQ2q_gQza_Ll8twVi-eDMNQ-qj534u8HfeyYEbXhQg.vP9slLlDMUibCxJRTzvsn6mtBIXlKANOiiuxJ8mozp8g.JPEG.hahahafb/wood9.jpg?type=w966",
                                               ]
    
    init(){
        let diaryUsage = BehaviorSubject<Int>(value: 0)
        diaryUsage.onNext(3)
        diaryUsage.subscribe(onNext: { element in
            //print(element)
        }).disposed(by: disposeBag)
        treeLevel = diaryUsage.map{ String($0) }
        
    }

    func testObservable(){
        let observable = Observable.just(3)
        observable.subscribe { element in
            print("Observable로 부터 \(element) 를 전달 받았습니다.")
        } onError: { error in
            print(error.localizedDescription)
        } onCompleted: {
            print("Observable 이 정상적으로 종료 되었습니다.")
        } onDisposed: {
            print("Observable 이 버려졌습니다.")
        }.disposed(by: disposeBag)
    }
    
    // treeLevel 세팅
    func setTreeLevel(diaryUsage: Int) -> Int{
        if (diaryUsage <= 2 && diaryUsage >= 0) {
            return 0
        }
        if (diaryUsage > 2 && diaryUsage <= 7) {
            return 1
        }
        if (diaryUsage > 7 && diaryUsage <= 14) {
            return 2
        }
        if (diaryUsage > 14 && diaryUsage <= 21) {
            return 3
        }
        if (diaryUsage > 21 && diaryUsage <= 28) {
            return 4
        }
        if (diaryUsage > 28 && diaryUsage <= 35) {
            return 5
        }
        if (diaryUsage > 35 && diaryUsage <= 42) {
            return 6
        }
        if (diaryUsage > 42 && diaryUsage <= 49) {
            return 7
        }
        if (diaryUsage > 49 && diaryUsage <= 56) {
            return 8
        }
        return 0
    }
    
}
