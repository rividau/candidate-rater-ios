//
//  UserAuthWebViewController.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/19/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

import UIKit

class UserAuthWebViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var urlRequest = NSURLRequest()
    var callback: ((authCode: String?) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        webView.delegate = self
        
        webView.loadRequest(urlRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - UIWebViewDelegate
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if DEBUG_LOG_HTTP {
            print("UserAuthWebViewController.shouldStartLoadWithRequest(), request=\(request)")
        }
        
        if let queryItems = NSURLComponents(string: request.URLString)?.queryItems {
            for queryItem in queryItems {
                switch queryItem.name {
                case KEY_AUTH_CODE:
                    callback(authCode: queryItem.value)
                    dismissViewControllerAnimated(true, completion: nil)
                    return false
                case QUERY_ERROR:
                    callback(authCode: nil)
                    dismissViewControllerAnimated(true, completion: nil)
                    return false
                default:
                    continue
                }
            }
        }
        
        return true
    }
}
