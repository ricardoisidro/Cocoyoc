//
//  WebViewController.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/15/20.
//  Copyright © 2020 jot. All rights reserved.
//

import UIKit
import WebKit

protocol WebViewControllerDelegate: class {
    func webViewControllerDidFinish(_ webViewController: WebViewController)
}

class WebViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!
    private let webViewManager = WebViewManager()

    weak var delegate: WebViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = webViewManager.createURLRequest() else { return }
        webViewManager.delegate = self
        let request = URLRequest(url: url)
        webView.navigationDelegate = webViewManager
        webView.load(request)
    }
    
    func load(_ userCredentials: UserAuthentication) {
        webViewManager.set(userCredentials)
    }
}

extension WebViewController: WebViewManagerDelegate {

    func webViewManagerDetectedNoAccess(_ webViewManager: WebViewManager) {
        delegate?.webViewControllerDidFinish(self)
    }
}
