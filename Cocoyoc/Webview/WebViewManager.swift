//
//  WebViewManager.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 3/7/20.
//  Copyright © 2020 jot. All rights reserved.
//

import Foundation
import WebKit

protocol WebViewManagerDelegate: class {
    func webViewManagerDetectedNoAccess(_ webViewManager: WebViewManager)
}

class WebViewManager: NSObject {
    
    private var authentication: UserAuthentication!
    private let defaultURL = URL(string: "https://www.sath.com.mx/PropietariosCocoyoc")
    
    weak var delegate: WebViewManagerDelegate?

    func set(_ userAuthentication: UserAuthentication) {
        self.authentication = userAuthentication
    }
    
    func createURLRequest() -> URL? {
        guard let authentication = authentication else { return defaultURL }
        let components = NSURLComponents()
        components.scheme = "https"
        components.host = "www.sath.com.mx"
        components.path = "/PropietariosCocoyoc/get.php"
        let queryEmail = URLQueryItem(name: "email", value: authentication.email)
        let queryPassword = URLQueryItem(name: "password", value: authentication.password)
        components.queryItems = [queryEmail, queryPassword]
        return components.url
    }
}

extension WebViewManager: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host {
            if host.contains("sath.com.mx") {
                decisionHandler(.allow)
                return
            }
        }
        decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.textContent") { (result, _) in
            guard let textContent = result as? String else { return }
            if textContent.elementsEqual("NO:ACCESS") {
                self.delegate?.webViewManagerDetectedNoAccess(self)
            }
        }
    }
}
