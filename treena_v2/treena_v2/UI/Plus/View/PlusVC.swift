//
//  Plus.swift
//  treena_v2
//
//  Created by asong on 2022/02/20.
//

import Foundation
import UIKit
import RxSwift
import Gifu

class PlusVC: UIViewController {
    private let disposeBag = DisposeBag()
    let viewModel = PlusViewModel()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "treena_logo")
        return imageView
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
        button.titleLabel?.font = UIFont(name: "THEAppleM", size: 17)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = UIFont(name: "THEAppleM", size: 17)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var loadingImageView: GIFImageView = {
        let image = GIFImageView()
        image.animate(withGIFNamed: "treena_loading")
        return image
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension PlusVC {
    func configureUI(){
        view.addSubview(logoImageView)
        view.addSubview(saveButton)
        view.addSubview(todayLabel)
        view.addSubview(textView)
        view.addSubview(temporarySaveButton)
        
        logoImageView.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        todayLabel.snp.makeConstraints{ make in
            make.top.equalTo(textView.snp.bottom).offset(10)
            make.right.equalTo(self.view).offset(-20)
        }
        
        textView.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(143)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-100)
        }
        
        temporarySaveButton.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(107)
            make.left.equalTo(self.view).offset(40)
        }
        
        saveButton.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(107)
            make.right.equalTo(self.view).offset(-40)
        }
    }
    
    private func bindUIWithView(){
        textView.rx.text.orEmpty.bind(to: viewModel.textViewText).disposed(by: disposeBag)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        viewModel.todayDate.onNext(formatter.string(from: Date()))
        saveButton.rx.tap.bind(to: viewModel.saveButtonTouched).disposed(by: disposeBag)
        saveButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext:  { [weak self] in
                self?.navigationController?.navigationBar.isHidden = false
                self?.view.endEditing(true)
                self?.addLoadingView()
            }).disposed(by: disposeBag)
        temporarySaveButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .bind(to: viewModel.temporarySaveButtonTouched).disposed(by: disposeBag)
        viewModel.diaryText.subscribe(onNext: { [weak self] text in
            if text == " " {
                self?.textViewPlaceHolderSetting()
            }else{
                self?.textView.text = text
                self?.textView.textColor = UIColor.black
            }
        })
        viewModel.emotionResult.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] emotion in
            if emotion != "" {
                let commentVC = CommentVC()
                commentVC.view.backgroundColor = .white
                commentVC.viewModel.emotionResult.accept(emotion)
                self?.navigationController?.navigationBar.isHidden = true
                self?.navigationController?.pushViewController(commentVC, animated: true)
            }
        }).disposed(by: disposeBag)
        viewModel.temporarySaveButtonTouched.subscribe(onNext: { [weak self] event in
            self?.showAlert(title: "임시저장 완료", message: "임시 저장이 완료되었습니다. \n 트리나의 이야기를 듣고싶다면 저장을 눌러주세요 :) ")
        })
    }
    
    func addLoadingView(){
        view.addSubview(loadingImageView)
        self.loadingImageView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.top.bottom.left.right.equalTo(self.view).offset(0)
        }
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message,  preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
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
