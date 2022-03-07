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
        button.setImage(UIImage(named: "profile2"), for: .normal)
        return button
    }()
    
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        label.font = UIFont(name: "THEAppleM", size: 16)
        label.text = formatter.string(from: Date())
        label.textColor = .black
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView: UITextView = UITextView()
        textView.text = "오늘은 어떤 일이 있었나요? \n 오늘 느꼈던 감정에 집중하면서 감정 단어(ex. 행복했다. 슬펐다. 놀랐다)를 사용해서 일기를 작성해 보세요."
        textView.setLineAndLetterSpacing(textView.text)
        textView.font = UIFont(name: "THEAppleR", size: 17)
        textView.layer.borderWidth = 1.1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.textColor = UIColor.lightGray
        textView.textAlignment = NSTextAlignment.left

        return textView
    }()
    
    private lazy var temporarySaveButton: UIButton = {
        let button = UIButton()
        button.setTitle("임시저장", for: .normal)
        button.titleLabel?.font = UIFont(name: "THEAppleM", size: 18)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = UIFont(name: "THEAppleM", size: 18)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        textViewPlaceHolderSetting()
        configureUI()
        bindUIWithView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}

extension PlusVC {
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
            make.top.equalTo(textView.snp.bottom).offset(10)
            make.left.equalTo(self.view).offset(40)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints{ make in
            make.top.equalTo(textView.snp.bottom).offset(10)
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
        viewModel.diaryText.subscribe(onNext: { [weak self] text in
            if text == " " {
                self?.textViewPlaceHolderSetting()
            }else{
                self?.textView.text = text
                self?.textView.textColor = UIColor.black
            }
        })
        viewModel.emotionResult.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] emotion in
            print("PlusVC emotion : \(emotion)")
            if emotion != "" {
                let commentVC = CommentVC()
                commentVC.view.backgroundColor = .white
                commentVC.viewModel.emotionResult.accept(emotion)
                self?.navigationController?.navigationBar.isHidden = true
                self?.navigationController?.pushViewController(commentVC, animated: true)
            }
        }).disposed(by: disposeBag)
        
        mypageButton.rx.tap
            .subscribe(onNext:  { [weak self] in
                let myPageVC = MyPageVC()
                myPageVC.view.backgroundColor = .white
                self?.navigationController?.pushViewController(myPageVC, animated: true)
            }).disposed(by: disposeBag)
    }
}

extension PlusVC: UITextViewDelegate {
    func textViewPlaceHolderSetting(){
        self.textView.delegate = self
        self.textView.text = "오늘은 어떤 일이 있었나요? \n 오늘 느꼈던 감정에 집중하면서 감정 단어(ex. 행복했다. 슬펐다. 놀랐다)를 사용해서 일기를 작성해 보세요."
        self.textView.textColor = UIColor.lightGray
    }
    
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
 
    func textViewDidChange(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "오늘은 어떤 일이 있었나요? \n오늘 느꼈던 감정에 집중하면서 감정 단어(ex. 행복했다, 슬펐다, 놀랐다)를 사용해서 일기를 작성해 보세요."
            textView.textColor = UIColor.lightGray
        }
    }
}
