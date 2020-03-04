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

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = createURLWithComponents() else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

private extension WebViewController {
    
    func createURLWithComponents() -> URL? {
        let components = NSURLComponents()
        components.scheme = "https"
        components.host = "www.sath.com.mx"
        components.path = "/PropietariosCocoyoc/"
        //components.user = "julio"
        //components.password = "palacios"
        return components.url
    }
}
