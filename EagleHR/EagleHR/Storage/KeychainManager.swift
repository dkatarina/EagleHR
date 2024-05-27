//
// Created by Katarina Dokic
//

import Foundation

struct KeychainManager {
    static let shared = KeychainManager()

    private init() {
        cleanKeychainOnFirstAppRun()
    }

    private func cleanKeychainOnFirstAppRun() {
        let userDefaults = UserDefaults.standard

        if userDefaults.bool(forKey: "appRunBefore") == false {
            clean()

            userDefaults.set(true, forKey: "appRunBefore")
            userDefaults.synchronize()

            return
        }
    }

    private func clean() {
        let secItemClasses =  [
            kSecClassGenericPassword,
            kSecClassInternetPassword,
            kSecClassCertificate,
            kSecClassKey,
            kSecClassIdentity,
        ]
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }

    func store(_ value: String, key: String) -> Bool {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
            ]

            let status = SecItemAdd(query as CFDictionary, nil)

            return status == errSecSuccess
        }
        return false
    }

    func remove(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]

        SecItemDelete(query as CFDictionary)
    }

    func get(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8) ?? nil
        }

        return nil
    }
}
