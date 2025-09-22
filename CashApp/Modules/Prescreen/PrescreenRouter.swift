//
//  PrescreenRouter.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 17.09.2025.
//

import UIKit

public class PrescreenRouter: Router {
    
    func toEditCreate() {
        openEditCreate(transition: ModalTransition(fromViewController: viewController, transitionStyle: .crossDissolve, presentationStyle: .fullScreen), router: EditCreateRouter.self, closeCompletion: {})
    }
    
    func toDetail(goal: Goal) {
        openDetailGoal(transition: ModalTransition(fromViewController: viewController, transitionStyle: .crossDissolve, presentationStyle: .fullScreen), router: DetailGoalRouter.self, goal: goal)
    }
    
    func toPremium() {
        openPremiumContainer(closeCompletion: nil, adaptyPlacement: .main, transition: ModalTransition(fromViewController: viewController, transitionStyle: .crossDissolve, presentationStyle: .fullScreen), router: PremiumContainerRouter.self)
    }
}



extension PrescreenRouter: EditCreateRoute { }
extension PrescreenRouter: DetailGoalRoute {}
extension PrescreenRouter: PremiumContainerRoute { }
