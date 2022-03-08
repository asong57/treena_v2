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
        label.font = UIFont(name: "THEAppleR", size: 18)
        label.numberOfLines = 7
        return label
    }()
    
    private lazy var labelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindUIWithView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension CommentVC {
    func configureUI(){
        view.addSubview(treenaImageView)
        self.treenaImageView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(640)
            make.width.equalTo(360)
        }
        view.addSubview(labelView)
        view.addSubview(commentLabel)
        commentLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(80)
            make.left.equalTo(self.view).offset(30)
            make.width.equalTo(170)
        }
        
        labelView.snp.makeConstraints{ make in
            make.top.equalTo(commentLabel)
            make.left.equalTo(commentLabel)
            make.height.width.equalTo(commentLabel)
        }
        
        view.addSubview(homeButton)
        homeButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view).offset(-70)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(50)
            make.width.equalTo(55)
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

