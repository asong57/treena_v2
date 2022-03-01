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
    
    var treenaImage: PublishRelay<UIImage>
    var commentText: PublishRelay<String>
    
    override init(){
        treenaImage = PublishRelay<UIImage>()
        commentText = PublishRelay<String>()
        super.init()
        let emotionJsonData = EmotionCommentModel.parseEmotionResult()
        super.emotionResult.subscribe(onNext: { [weak self] emotion in
            for i in 0..<emotionJsonData.emotions.capacity {
                if emotion == emotionJsonData.emotions[i].name {
                    let type = emotionJsonData.emotions[i].type
                    let random = Int.random(in: 0..<emotionJsonData.emotions[i].response.count)
                    print("random: \(random) \(emotionJsonData.emotions[i].response.count) i: \(i)")
                    self?.commentText.accept(emotionJsonData.emotions[i].response[random])
                    self?.setTreenaEmotionImage(type: type)
                    print("response : \(emotionJsonData.emotions[i].response[0])")
                    print("type : \(type)")
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
        let image = super.treeLevel
        .map{
            URL(string: ImageUrl.treenaImageUrlList[index][$0])
        }.map{
            try! Data(contentsOf: $0!)
        }.map{
            UIImage(data: $0)!
        }
        image.subscribe(onNext: { observer in
            self.treenaImage.accept(observer)
        })
    }
}
