//
//  LaunchScreenVC.swift
//  treena_v2
//
//  Created by asong on 2022/03/07.
//

import UIKit

class LaunchScreenVC: UIViewController{
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        self.imageView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(500)
            make.width.equalTo(360)
        }
        
        guard let confettiImageView = UIImageView.fromGif(frame: view.frame, resourceName: "" ) else { return }
        view.addSubview(confettiImageView)
        imageView.startAnimating()
        imageView.animationDuration = 3
        imageView.animationRepeatCount = 1
        imageView.animationImages = nil
    }
}
extension UIImageView {
    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
            let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        return gifImageView
    }
}
