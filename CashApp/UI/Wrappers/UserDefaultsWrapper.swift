//
//  UserDefaultsWrapper.swift
//  AIAvatar_UI
//
//  Created by Oleksandr Yakobshe on 22.02.2023.
//

import Foundation

@propertyWrapper
public struct UserDefaultsWrapper<Value: Codable> {
	public let key: String
	public let defaultValue: Value
	public let userDefaults = UserDefaults.standard

	public var wrappedValue: Value {
		get {
			let data = userDefaults.data(forKey: key)
			let value = data.flatMap { try? JSONDecoder().decode(Value.self, from: $0) }
			return value ?? defaultValue
		}

		set {
			let data = try? JSONEncoder().encode(newValue)
			userDefaults.set(data, forKey: key)
			userDefaults.synchronize()
		}
	}

	public init(key: String, defaultValue: Codable) {
		self.key = key
		self.defaultValue = defaultValue as! Value
	}
}
