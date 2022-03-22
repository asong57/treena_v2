//
//  ApiNetwork.swift
//  treena_v2
//
//  Created by asong on 2022/02/20.
//

import Foundation
import Alamofire
import RxSwift

class ApiNetwork {
    static let shared = ApiNetwork()
    
    func getEmotion(text: String) -> Observable<String>{
        let url = Bundle.main.apiUrl
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        
        // POST 로 보낼 정보
        let params = ["context": text] as Dictionary
        
        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        return Observable.create{observer -> Disposable in
            // 인공지능 모델 API 통신 요청
            AF.request(request).responseJSON { (response) in
                switch response.result {
                case .success(let res):
                    do{
                        // response JSON 파싱
                        let data = try? JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                        var emotionAnswer: String = ""
                        do {
                            emotionAnswer = try JSONDecoder().decode(ApiResponseModel.self, from: data!).answer
                        } catch{
                            emotionAnswer = "neutral"
                        }
                        observer.onNext(emotionAnswer)
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                    
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
            return Disposables.create()
        }
    }
}
