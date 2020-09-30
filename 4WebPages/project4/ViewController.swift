//
//  ViewController.swift
//  project4
//
//  Created by Tomislav Jurić-Arambašić on 20/05/2020.
//  Copyright © 2020 Tomislav Jurić-Arambašić. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    var selectedSite: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let back = UIBarButtonItem(title: "Back",style: .plain, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(title:"Forward",style: .plain, target: webView, action: #selector(webView.goForward))
        
        toolbarItems = [forward,back,progressButton, spacer , refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        guard let selectedSite = selectedSite else { return }

        if let url = URL(string: "https://" + selectedSite)
        {
          let urlRequest = URLRequest(url: url)
          webView.load(urlRequest)
        }
        
        
        webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    
   

    
    @objc func openTapped() {
        let ac = UIAlertController(title: "open page...", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
        ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac,animated: true)
    }

    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website){
                decisionHandler(.allow)
                return
                }
            }
        }
        let forbidden = UIAlertController(title: "Alert", message: "cannot acces that page!", preferredStyle: UIAlertController.Style.alert)
        forbidden.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(forbidden, animated: true, completion: nil)
        decisionHandler(.cancel)
    }
}

