//
//  LaunchScreenVC.swift
//  treena_v2
//
//  Created by asong on 2022/03/07.
//

import UIKit
import Gifu
import FirebaseAuth

class LaunchScreenVC: UIViewController{
    private lazy var imageView: GIFImageView = {
        let image = GIFImageView()
        image.animate(withGIFNamed: "treena_launch")
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)){
            self.checkIsLogined()
        }
    }
    
    func configureUI(){
        view.addSubview(imageView)
        self.imageView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.top.bottom.left.right.equalTo(self.view).offset(0)
        }
    }
    
    func checkIsLogined(){
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        if Auth.auth().currentUser != nil{
            let vc = HomeVC()
            vc.view.backgroundColor = .white
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = LoginVC()
            vc.view.backgroundColor = .white
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
