
//
//  UserDefaults.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 15.09.2025.
//

import Foundation

extension UserDefaults {
    
    public static var premium: Bool {
        get {
            (UserDefaults.standard.object(forKey: "premiumKey") as? Bool) ?? false
        }
        set {
            let old = (UserDefaults.standard.object(forKey: "premiumKey") as? Bool) ?? false
            guard old != newValue else { return }
            UserDefaults.standard.set(newValue, forKey: "premiumKey")
        }
    }

    
    public static var showMain: Bool {
        get {
            UserDefaults.standard.bool(forKey: "showMain")
        }
        set {
            guard UserDefaults.standard.bool(forKey: "showMain") != newValue else { return }
            UserDefaults.standard.set(newValue, forKey: "showMain")
            UserDefaults.standard.synchronize()
        }
    }
}
