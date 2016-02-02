//
//  SMVWebView.swift
//  Samverkan112
//
//  Created by Hampus Zätterberg on 2016-02-02.
//  Copyright © 2016 hampus. All rights reserved.
//

import SpriteKit

struct SMVWebViewStruct {
    let MAIN_URL:String = "http://www.s112.se"
}

protocol SMWebViewDelegate{
    func webViewDidFinishLoading()
}

class SMWebView : UIWebView,UIWebViewDelegate {
    
    var delegateProtocol:SMWebViewDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        hidden = true
        delegate = self
        loadRequest(NSURLRequest(URL: NSURL(string: SMVWebViewStruct().MAIN_URL)!))
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        if Reachability.isConnectedToNetwork() == true {
            
        } else {
            let badConnectionAlert = UIAlertController(title: "Dålig anslutning", message: "Kolla din anslutning innan du fortsätter.", preferredStyle: UIAlertControllerStyle.Alert)
            badConnectionAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    print("default")
                    
                case .Cancel:
                    print("cancel")
                    
                case .Destructive:
                    print("destructive")
                }
            }))
            
            let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
            let viewController = appDelegate.window!.rootViewController as! SMVViewController
            viewController.presentViewController(badConnectionAlert, animated: true, completion: nil)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if stringByEvaluatingJavaScriptFromString("document.readyState") == "complete" {
            if hidden {
                hidden = false
                delegateProtocol.webViewDidFinishLoading()
            }
        }
    }
}