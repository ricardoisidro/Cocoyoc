//
//  WebViewController.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/15/20.
//  Copyright © 2020 jot. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!
    private let webViewManager = WebViewManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = webViewManager.createURLRequest() else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func load(_ userCredentials: UserAuthentication) {
        webViewManager.set(userCredentials)
    }
}
