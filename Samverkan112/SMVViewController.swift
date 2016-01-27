//
//  ViewController.swift
//  Samverkan112
//
//  Created by Hampus Zätterberg on 2016-01-27.
//  Copyright © 2016 hampus. All rights reserved.
//

import UIKit

struct SMVViewControllerrStruct {
    let MAIN_URL:String = "http://www.s112.se"
}

class SMVViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupWebView() {
        webView.delegate = self
        webView.loadRequest(NSURLRequest(URL: NSURL(string: SMVViewControllerrStruct().MAIN_URL)!))
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
            
            self.presentViewController(badConnectionAlert, animated: true, completion: nil)
        }
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("LADDAD URL = \(request.URL)")
        return true
    }
}