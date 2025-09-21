//
//  AddTransactionRouter.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 21.09.2025.
//

import UIKit

public class AddTransactionRouter: Router {
    
    func toDatePick(dateCompletion: ((String) -> Void)?) {
        openSelectDate(transition:  ModalTransition(fromViewController: viewController, transitionStyle: .crossDissolve, presentationStyle: .pageSheet), router: SelectDateRouter.self, dateCompletion: dateCompletion)
    }
}


extension AddTransactionRouter: SelectDateRoute { }
