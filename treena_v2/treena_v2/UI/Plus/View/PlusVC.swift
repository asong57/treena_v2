//
//  Plus.swift
//  treena_v2
//
//  Created by asong on 2022/02/20.
//

import Foundation
import UIKit
import RxSwift

class PlusVC: UIViewController {
    private let disposeBag = DisposeBag()
    let viewModel = PlusViewModel()
    
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
    
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 dd일"
        label.text = formatter.string(from: Date())
        label.textColor = .black
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView: UITextView = UITextView()
        textView.text = "오늘은 기분이 좋았다. 기쁜 하루였다."
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.font = UIFont.systemFont(ofSize: 20.0)
        textView.textColor = UIColor.black
        textView.textAlignment = NSTextAlignment.left
        return textView
    }()
    
    private lazy var temporarySaveButton: UIButton = {
        let button = UIButton()
        button.setTitle("임시저장", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindUIWithView()
    }
}

extension PlusVC {
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
        
        view.addSubview(todayLabel)
        todayLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(107)
            make.right.equalTo(self.view).offset(-20)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(130)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-100)
        }
        
        view.addSubview(temporarySaveButton)
        temporarySaveButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view).offset(-60)
            make.left.equalTo(self.view).offset(40)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view).offset(-60)
            make.right.equalTo(self.view).offset(-40)
        }
    }
    
    private func bindUIWithView(){
        textView.rx.text.orEmpty.bind(to: viewModel.textViewText).disposed(by: disposeBag)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        viewModel.todayDate.onNext(formatter.string(from: Date()))
        saveButton.rx.tap.bind(to: viewModel.saveButtonTouched).disposed(by: disposeBag)
        temporarySaveButton.rx.tap.bind(to: viewModel.temporarySaveButtonTouched).disposed(by: disposeBag)
        viewModel.emotionResult.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] emotion in
            print("PlusVC emotion : \(emotion)")
            if emotion != "" {
                let commentVC = CommentVC()
                commentVC.view.backgroundColor = .white
                commentVC.viewModel.emotionResult.accept(emotion)
                self?.navigationController?.pushViewController(commentVC, animated: true)
            }
        }).disposed(by: disposeBag)
    }
}

