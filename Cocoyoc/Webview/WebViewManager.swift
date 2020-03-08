//
//  WebViewManager.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 3/7/20.
//  Copyright © 2020 jot. All rights reserved.
//

import Foundation

class WebViewManager {
    
    private var authentication: UserAuthentication!
    private let defaultURL = URL(string: "https://www.sath.com.mx/PropietariosCocoyoc")
    
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
