//
//  KeychainController.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/22/20.
//  Copyright © 2020 jot. All rights reserved.
//

import Foundation

class KeychainController {
    
    enum Key: String {
        case user
    }
    
    func save(password: UserAuthentication) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(password)
            let data = try NSKeyedArchiver.archivedData(withRootObject: encoded, requiringSecureCoding: false)
            save(objectData: data, forKey: .user)
        } catch {
            fatalError("Couldn't save on keychain " + error.localizedDescription)
        }
    }
    
    func loadUser() -> UserAuthentication? {
        guard let data = load(withKey: .user) else { return nil }
        let decoder = JSONDecoder()
        do {
            let unarchivedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! Data
            return try decoder.decode(UserAuthentication.self, from: unarchivedData)
        } catch {
            fatalError("Couldn't load from keychain " + error.localizedDescription)
        }
        
    }
}

private extension KeychainController {
    
    func keychainQuery(withKey key: String) -> [String: Any] {
        let dictionary = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: key,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly] as [String: Any]
        return dictionary
    }
    
    func save(objectData: Data?, forKey key: Key) {
        var query = keychainQuery(withKey: key.rawValue)
        if SecItemCopyMatching(query as CFDictionary, nil) == noErr {
            if let dictData = objectData {
                SecItemUpdate(query as CFDictionary, NSDictionary(dictionary: [kSecValueData: dictData]))
            } else {
                SecItemDelete(query as CFDictionary)
            }
        } else {
            if let dictData = objectData {
                query[kSecValueData as String] = dictData
                SecItemAdd(query as CFDictionary, nil)
            }
        }
    }
    
    func load(withKey key: Key) -> Data? {
        var query = keychainQuery(withKey: key.rawValue)
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess, let resultDict = result as? NSDictionary, let resultData = resultDict.value(forKey: kSecValueData as String) as? Data else { return nil }
        return resultData
    }
}
