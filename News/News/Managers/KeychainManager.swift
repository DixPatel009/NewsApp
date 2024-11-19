//
//  KeychainManager.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import Security
import Foundation

class KeychainManager {
    
    // MARK: - Properties
    static let shared = KeychainManager()
    
    // Save data from keychain
    func save(_ value: String, for key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary) // Delete existing item if exists
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    // Get data from keychain
    func get(for key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess, let data = result as? Data,
              let value = String(data: data, encoding: .utf8) else { return nil }
        
        return value
    }
    
    // Update data from keychain
    func update(value: String, for key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount
            as String: key
        ]
        
        let status = SecItemUpdate(query as CFDictionary,
                                   [kSecValueData : data] as CFDictionary)
        return status == errSecSuccess
    }
    
    // Delete data from keychain
    func delete(for key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    
    // Remove all data from keychain
    func removeAll() -> Bool {
        let secItemClasses: [CFString] = [
            kSecClassGenericPassword,
            kSecClassInternetPassword,
            kSecClassCertificate,
            kSecClassKey,
            kSecClassIdentity
        ]
        
        for secItemClass in secItemClasses {
            let query: [String: Any] = [
                kSecClass as String: secItemClass,
                kSecAttrSynchronizable as String: kSecAttrSynchronizableAny
            ]
            
            let status = SecItemDelete(query as CFDictionary)
            if status != errSecSuccess && status != errSecItemNotFound {
                return false
            }
        }
        
        return true
    }
    
}
