//
//  LaunchScreenVC.swift
//  treena_v2
//
//  Created by asong on 2022/03/07.
//

import UIKit
import Gifu

class LaunchScreenVC: UIViewController{
    private lazy var imageView: GIFImageView = {
        let image = GIFImageView()
        image.animate(withGIFNamed: "treena_launch")
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        view.addSubview(imageView)
        self.imageView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.top.bottom.left.right.equalTo(self.view).offset(0)
        }
    }
}
