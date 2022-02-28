//
//  CalendarDetailVC.swift
//  treena_v2
//
//  Created by asong on 2022/02/23.
//

import Foundation
import UIKit
import RxSwift

class CalendarDetailVC: UIViewController {
    private let disposeBag = DisposeBag()
    let viewModel = CalendarDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewPlaceHolderSetting()
        configureUI()
        bindUIWithView()
    }
    
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
    
    private lazy var beforeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "before"), for: .normal)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "next"), for: .normal)
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 dd일"
        label.text = formatter.string(from: Date())
        label.textColor = .black
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView: UITextView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.font = UIFont.systemFont(ofSize: 20.0)
        textView.textAlignment = NSTextAlignment.left
        return textView
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
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
        
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(107)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(beforeButton)
        beforeButton.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(110)
            make.right.equalTo(dateLabel.snp.left).offset(-10)
            make.width.height.equalTo(15)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(110)
            make.left.equalTo(dateLabel.snp.right).offset(10)
            make.width.height.equalTo(15)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(130)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-100)
        }
        view.addSubview(deleteButton)
        deleteButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view).offset(-60)
            make.left.equalTo(self.view).offset(40)
        }
        
        view.addSubview(temporarySaveButton)
        temporarySaveButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view).offset(-60)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view).offset(-60)
            make.right.equalTo(self.view).offset(-40)
        }
    }
    
    private func bindUIWithView(){
        textView.rx.text.orEmpty.bind(to: viewModel.textViewText).disposed(by: disposeBag)
        viewModel.diaryText.subscribe(onNext: { [weak self] text in
            if text == " " {
                self?.textViewPlaceHolderSetting()
            }else{
                self?.textView.text = text
                self?.textView.textColor = UIColor.black
            }
        })
        saveButton.rx.tap.bind(to: viewModel.saveButtonTouched).disposed(by: disposeBag)
        temporarySaveButton.rx.tap.bind(to: viewModel.temporarySaveButtonTouched).disposed(by: disposeBag)
        viewModel.emotionResult.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] emotion in
            print("PlusVC emotion : \(emotion)")
            if emotion != "" {
                let commentVC = CommentVC()
                commentVC.view.backgroundColor = .white
                //self?.viewModel.emotionResult.accept(emotion)
                self?.navigationController?.pushViewController(commentVC, animated: true)
            }
        }).disposed(by: disposeBag)
        viewModel.todayDate.subscribe(onNext: {[weak self] date in
            let endIdx: String.Index = date.index(date.startIndex, offsetBy: 3)
            let monthStartIdx: String.Index = date.index(date.startIndex, offsetBy: 4)
            let monthEndIdx: String.Index = date.index(date.startIndex, offsetBy: 5)
            let dayStartIdx: String.Index = date.index(date.startIndex, offsetBy: 6)
            let year: String = String(date[...endIdx])
            let month: String = String(date[monthStartIdx...monthEndIdx])
            let day: String = String(date[dayStartIdx...])
            let nowDate = year+"년 "+month+"월 "+day+"일"
            self?.dateLabel.text = nowDate
        })
        beforeButton.rx.tap.bind(to: viewModel.beforeButtonTouched).disposed(by: disposeBag)
        nextButton.rx.tap.bind(to: viewModel.nextButtonTouched).disposed(by: disposeBag)
    }
}
extension CalendarDetailVC: UITextViewDelegate{
    func textViewPlaceHolderSetting(){
        self.textView.delegate = self
        self.textView.text = "오늘은 어떤 일이 있었나요? \n 오늘 느꼈던 감정에 집중하면서 감정 단어(ex. 행복했다. 슬펐다. 놀랐다)를 사용해서 일기를 작성해 보세요."
        self.textView.textColor = UIColor.lightGray
    }
    
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
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "오늘은 어떤 일이 있었나요? \n오늘 느꼈던 감정에 집중하면서 감정 단어(ex. 행복했다, 슬펐다, 놀랐다)를 사용해서 일기를 작성해 보세요."
            textView.textColor = UIColor.lightGray
        }
    }
}
