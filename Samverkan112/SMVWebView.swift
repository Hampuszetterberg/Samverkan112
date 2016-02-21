//
//  SMVWebView.swift
//  Samverkan112
//
//  Created by Hampus Zätterberg on 2016-02-02.
//  Copyright © 2016 hampus. All rights reserved.
//

import SpriteKit

protocol SMWebViewDelegate {
    func webViewDidFinishLoading()
}

class SMWebView: UIWebView, UIWebViewDelegate {
    var delegateProtocol: SMWebViewDelegate!
    private let permissionList = SMWebViewPermissonlistStruct.init()
    
    private struct SMVWebViewStruct {
        let mainUrl: String = "http://www.s112.se"
    }
    
    private struct SMWebViewPermissonlistStruct {
        let blacklist: Array = ["s112.se/flash/","issuu.com",".pdf"]
        let whitelist: Array = [""]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        hidden = true
        delegate = self
        dataDetectorTypes = UIDataDetectorTypes.Link
        loadRequest(NSURLRequest(URL: NSURL(string: SMVWebViewStruct().mainUrl)!))
    }

    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let urlRequest:String = (request.URL?.absoluteString)!
        
        for blacklistURL in permissionList.blacklist {
            if (urlRequest.rangeOfString(blacklistURL) != nil) {
                
                if urlRequest.rangeOfString("s112.se/flash/") != nil {
                    let badConnectionAlert = UIAlertController(title: "Obs", message: "Flash stöds ej på den här enheten.", preferredStyle: UIAlertControllerStyle.Alert)
                    badConnectionAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                    }))

                    UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(badConnectionAlert, animated: true, completion: nil);

                    return false
                }
                
                UIApplication.sharedApplication().openURL(NSURL(string: urlRequest)!)
                return false
            }
        }

        return true
    }

    func webViewDidStartLoad(webView: UIWebView) {
        if Reachability.isConnectedToNetwork() == true {
        } else {
            let badConnectionAlert = UIAlertController(title: "Dålig anslutning", message: "Kolla din anslutning innan du fortsätter.", preferredStyle: UIAlertControllerStyle.Alert)
            badConnectionAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                switch action.style {
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
