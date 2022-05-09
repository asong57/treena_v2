//
//  CommentViewModel.swift
//  treena_v2
//
//  Created by asong on 2022/02/24.
//

import Foundation
import RxSwift
import RxRelay

class CommentViewModel: PlusViewModel {
    private let disposeBag = DisposeBag()
    
    var commentText: PublishRelay<String>
    var treenaImageUrl: BehaviorSubject<String>
    
    override init(){
        commentText = PublishRelay<String>()
        treenaImageUrl = BehaviorSubject<String>(value: ImageUrl.loadingBigImageUrl)
        super.init()
        
        let emotionJsonData = EmotionCommentModel.parseEmotionResult()
        super.emotionResult.subscribe(onNext: { [weak self] emotion in
            for i in 0..<emotionJsonData.emotions.capacity {
                if emotion == emotionJsonData.emotions[i].name {
                    let type = emotionJsonData.emotions[i].type
                    let random = Int.random(in: 0..<emotionJsonData.emotions[i].response.count)
                    self?.commentText.accept(emotionJsonData.emotions[i].response[random])
                    self?.setTreenaEmotionImage(type: type)
                    break
                }
            }
        }).disposed(by: disposeBag)
    }
    
    func setTreenaEmotionImage(type: Int) {
        var index: Int = 0
        var random: Int
        if type == 1 {
            random = Int(arc4random_uniform(UInt32(3)))
            index = random
        } else if type == 0 {
            random = Int(arc4random_uniform(UInt32(2)))
            index = random+3
        } else if type == -1 {
            index = 5
        }
        
        super.treeLevel.subscribe(onNext: { [weak self] in
            self?.treenaImageUrl.onNext(ImageUrl.treenaImageUrlList[index][$0])
        })
    }
}
