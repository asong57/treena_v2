//
//  CommentVC.swift
//  treena_v2
//
//  Created by asong on 2022/02/20.
//

import Foundation
import UIKit
import RxSwift

class CommentVC: UIViewController {
    private let disposeBag = DisposeBag()
    let viewModel = CommentViewModel()
    
    private lazy var treenaImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()

    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "home"), for: .normal)
        return button
    }()

    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindUIWithView()
    }
}

extension CommentVC {
    func configureUI(){
        view.addSubview(treenaImageView)
        self.treenaImageView.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 10, bottom: 80, right: 10))
        }
        
        view.addSubview(homeButton)
        homeButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view).offset(-60)
            make.right.equalTo(self.view).offset(-40)
            make.width.height.equalTo(45)
        }
        
        view.addSubview(commentLabel)
        commentLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(15)
            make.left.equalTo(self.view).offset(10)
        }
    }
    
    private func bindUIWithView(){
        viewModel.emotionResult.observe(on: MainScheduler.instance).subscribe(onNext: { emotion in
            print("CommentVC emotion: \(emotion)")
        }).disposed(by: disposeBag)
        
        homeButton.rx.tap
            .subscribe(onNext:  { [weak self] in
                let homeVC = HomeVC()
                homeVC.view.backgroundColor = .white
                self?.navigationController?.pushViewController(homeVC, animated: true)
            }).disposed(by: disposeBag)
        viewModel.treenaImage.bind(to: treenaImageView.rx.image).disposed(by: disposeBag)
        viewModel.commentText.bind(to: commentLabel.rx.text).disposed(by: disposeBag)
    }
}

