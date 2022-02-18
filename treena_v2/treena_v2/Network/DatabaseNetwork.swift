//
//  Database.swift
//  treena_v2
//
//  Created by asong on 2022/02/18.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import RxSwift

class DatabaseNetwork {
    static let shared = DatabaseNetwork()
    
    private var ref: DatabaseReference!
    var uid: String!
    var diaryUsage: Int
    var treeLevel: Int = 0
    
    private init() {
        // Firebase Database 연결
        ref = Database.database().reference()
    
        diaryUsage = 0
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            uid = user?.uid
            print("user exists : \(uid)")
        } else{
            print("user is nil")
        }
    }
    
    // 데이터베이스 사용자 일기량 확인 
    func checkDiaryUsage() -> Observable<Int>{
        return Observable.create { subject in
            subject.onNext(22)
            /*
            self.ref.child("diary").child(self.uid).getData{ (error, snapshot) in
                if let error = error {
                    print("error getting data \(error)")
                }else if snapshot.exists() {
                    self.diaryUsage = Int(snapshot.childrenCount)
                    print("got data \(self.diaryUsage)")
                    subject.onNext(self.diaryUsage)
                }else {
                    print("No data")
                }
            }*/
            return Disposables.create()
        } 
    }
}
