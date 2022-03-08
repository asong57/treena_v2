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
    var treeLevel: Int = 0                                                                                            
    var email: String!
    var datesWithDiary: [String] = []
    var completionHandler: ((Bool) -> Void)?
    
    init() {
        // Firebase Database 연결
        ref = Database.database().reference()
    
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            uid = user?.uid
            email = user?.email
        } else{
            print("user is nil")
        }
    }
    
    func setUid(){
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            uid = user?.uid
            email = user?.email
        }
    }
    
    // 데이터베이스 사용자 일기량 확인 
    func checkDiaryUsage() -> Observable<Int>{
        return Observable.create { subject in
            if self.uid != nil {
                self.ref.child("diary").child(self.uid).getData{ (error, snapshot) in
                    if let error = error {
                        print("error getting data \(error)")
                    }else if snapshot.exists() {
                        let diaryUsage = Int(snapshot.childrenCount)
                        subject.onNext(diaryUsage)
                    }else {
                        subject.onNext(0)
                    }
                }
            }
            return Disposables.create()
        } 
    }
    
    func saveDiary(text: String, date: String) {
        self.ref.child("diary").child(uid).child(date).setValue(text)
    }
    
    func getDiary(date: String) -> Observable<String> {
        return Observable.create { observer in
            self.ref.child("diary").child(self.uid).child(date).getData{ (error, snapshot) in
                if let error = error {
                    print("error getting data \(error)")
                }else if snapshot.exists() {
                    let text = snapshot.value as! String
                    observer.onNext(text)
                }else {
                    observer.onNext(" ")
                }
            }
            return Disposables.create()
        }
    }
    
    func deleteDiary(date: String){
        self.ref.child("diary").child(uid).child(date).removeValue()
    }
    
    // 일기 쓴 날짜 배열 가져오기
    func getDiaryDatesWithoutObserver() {
        DatabaseNetwork.shared.datesWithDiary.removeAll()
        self.ref.child("diary").child(self.uid).getData{  [weak self](error, snapshot) in
            if let error = error {
                print("error getting data \(error)")
            }else if snapshot.exists() {
                let value: [String: String] = snapshot.value as! [String : String]
                for key in value.keys {
                    DatabaseNetwork.shared.datesWithDiary.append(key)
                }
                _ = self?.completionHandler?(true)
            }else {
                _ = self?.completionHandler?(true)
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                print("failed email sending")
            } else {
                print("successed email sending")
            }
        }
    }
    
    
    func deleteUser() {
        let userForDeletion: User? = Auth.auth().currentUser
        userForDeletion?.delete(completion: { (error) in
            if error != nil {
                print("failed delete user")
            } else {
                self.ref.child("Users").child(self.uid).removeValue()
            }
        })
    }
    
    func singUpUser(name: String){
        // 데이터베이스에 회원정보 저장
        if Auth.auth().currentUser != nil {
            let value: [String: Any] = [ "uid" : uid, "email" : email, "name": name]
            self.ref.child("Users").child(uid).setValue(value)
        } else{
            print("user is nil")
        }
    }
}
