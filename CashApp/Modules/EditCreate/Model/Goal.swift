//
//  Goal.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 18.09.2025.
//

import Foundation
import RealmSwift
import UIKit

class Goal: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var emoji: String = ""
    @objc dynamic var amount:  String = ""
    @objc dynamic var currency:  String = ""
    @objc dynamic var date:  String = ""

    
    override static func primaryKey() -> String? { "id" }
}
