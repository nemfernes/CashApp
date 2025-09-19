//
//  EditCreateRouter.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 17.09.2025.
//

import UIKit

public class EditCreateRouter: Router {
    func toEmoji(emojiCompletion: ((String) -> Void)?) {
        openSelectEmoji(transition:  ModalTransition(fromViewController: viewController, transitionStyle: .crossDissolve, presentationStyle: .pageSheet), router: SelectEmojiRouter.self, emojiCompletion: emojiCompletion)
    }

    func toCurrency(currencyCompletion: ((String) -> Void)?) {
        openSelectCurrency(transition:  ModalTransition(fromViewController: viewController, transitionStyle: .crossDissolve, presentationStyle: .pageSheet), router: SelectCurrencyRouter.self, currencyCompletion: currencyCompletion)
    }
    
    func toDatePick(dateCompletion: ((String) -> Void)?) {
        openSelectDate(transition:  ModalTransition(fromViewController: viewController, transitionStyle: .crossDissolve, presentationStyle: .pageSheet), router: SelectDateRouter.self, dateCompletion: dateCompletion)
    }
}

extension EditCreateRouter: SelectEmojiRoute { }
extension EditCreateRouter: SelectCurrencyRoute { }
extension EditCreateRouter: SelectDateRoute { }

