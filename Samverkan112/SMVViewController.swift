//
//  ViewController.swift
//  Samverkan112
//
//  Created by Hampus Zätterberg on 2016-01-27.
//  Copyright © 2016 hampus. All rights reserved.
//

import UIKit

class SMVViewController: UIViewController,SMWebViewDelegate {
    
    @IBOutlet weak var webView: SMWebView!
    
    var extendedSplashImage:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegateProtocol = self
        extendSplash()
    }
    
    func extendSplash () {
        extendedSplashImage = UIImageView(frame: self.view.frame)
        extendedSplashImage.image = UIImage(imageLiteral: "splash-1242x2208.png")
        self.view.addSubview(extendedSplashImage)
    }
    
    func webViewDidFinishLoading() {
        extendedSplashImage.removeFromSuperview()
    }
}