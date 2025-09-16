//
//  AlertAction.swift
//  VoiceTranslator-UI
//
//  Created by Oleksandr Vynnyk on 05.12.2022.
//

import UIKit

public struct AlertAction {
  public var title: String
  public var action: (()->())
  public var style: UIAlertAction.Style = .default
  
  public init(title: String, action: @escaping () -> Void, style: UIAlertAction.Style = .default) {
    self.title = title
    self.action = action
    self.style = style
  }
}
