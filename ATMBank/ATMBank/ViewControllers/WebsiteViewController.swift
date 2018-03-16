//
//  WebsiteViewController.swift
//  ATMBank
//
//  Created by Bao on 3/11/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit
import WebKit


class WebsiteViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    
    // MARK: IBActions
    @IBAction func buttonCloseView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Properties
    private var _webView: WKWebView!
    var bank: Bank?
    
    // MARK: Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTitle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpWebView()
    }

    private func setUpWebView() {
        guard let bank = bank else { return }
        guard let url = URL(string: bank.website) else { return }
        _webView = WKWebView(frame: CGRect(origin: CGPoint.zero, size: containerView.frame.size))
        _webView.allowsBackForwardNavigationGestures = true
        _webView.navigationDelegate = self
        _webView.load(URLRequest(url: url))
        containerView.addSubview(_webView)
    }
    
    private func setUpTitle() {
        guard let bank = bank else { return }
        labelTitle.text = bank.shortname.uppercased()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
    
    deinit {
        print("WebsiteViewController is deinit")
    }
}

// MARK: Extension - WKNavigationDelegate
extension WebsiteViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        Helper.showLoadingView(effect: .twins, containerView: containerView)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Helper.hideLoadingView()
    }
}
