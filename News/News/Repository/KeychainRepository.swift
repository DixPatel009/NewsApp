//
//  KeychainRepository.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

protocol KeychainRepositoryProtocol {
    func saveData(value: String, forKey key: String) -> Bool
    func updateData(value: String, forKey key: String) -> Bool
    func getData(forKey key: String) -> String?
    func deleteData(forKey key: String) -> Bool
    func removeAllData() -> Bool
}

class KeychainRepository: KeychainRepositoryProtocol {
    
    // Update Data in keychain
    func updateData(value: String, forKey key: String) -> Bool {
        return KeychainManager.shared.update(value: value, for: key)
    }
    
    // Save data in keychain
    func saveData(value: String, forKey key: String) -> Bool {
        return KeychainManager.shared.save(value, for: key)
    }

    // Get data from keychain
    func getData(forKey key: String) -> String? {
        return KeychainManager.shared.get(for: key)
    }

    // Delete data from keychain
    func deleteData(forKey key: String) -> Bool {
        return KeychainManager.shared.delete(for: key)
    }
    
    // Remove all data from keychain
    func removeAllData() -> Bool {
        return KeychainManager.shared.removeAll()
    }
}
