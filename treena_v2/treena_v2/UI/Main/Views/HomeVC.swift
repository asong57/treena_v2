//
//  ViewController.swift
//  treena_v2
//
//  Created by asong on 2022/02/14.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        let url = URL(string: "https://postfiles.pstatic.net/MjAyMTA3MjlfMjA3/MDAxNjI3NTY4NjE3Mjcx.DAnQNog3Cyr18qAv4ke17sWV0Ye3R1bBpiyilMO7J0Qg.dVECs9WmdPKnlH-8DODBy-aqXcA5wBPoVGSHeXcVMyMg.JPEG.hahahafb/wood1.jpg?type=w966")
        if let data = try? Data(contentsOf: url!){
            if let imageData = UIImage(data: data){
                image.image = imageData
            }
        }
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

extension HomeVC {
    func configureUI(){
        view.addSubview(imageView)
        self.imageView.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
        }
    }
}

