//
//	Common.swift
//	Translator-UI
//
//	Created by Oleksii Yerko on 01.08.2022.
//

import Foundation

public extension LS {
    enum Common {}
}

public extension LS.Common {
    enum Strings: String, Localizable {
        case keepAll = "LS.Common.Strings.keepAll"
        case setUp = "LS.Common.Strings.setUp"
        case getDetailed = "LS.Common.Strings.getDetailed"
        case seeExactly = "LS.Common.Strings.seeExactly"
        case `continue` = "LS.Common.Strings.continue"
        case trackThe = "LS.Common.Strings.trackThe"
        case reviewEvery = "LS.Common.Strings.reviewEvery"
        case goPremium = "LS.Common.Strings.goPremium"
        case unlimitedSaving = "LS.Common.Strings.unlimitedSaving"
        case advancedStatistics = "LS.Common.Strings.advancedStatistics"
        case fullHistory = "LS.Common.Strings.fullHistory"
        case days3 = "LS.Common.Strings.days3"
        case slashMonth = "LS.Common.Strings.slashMonth"
        case noPayments = "LS.Common.Strings.noPayments"
        case yearly = "LS.Common.Strings.yearly"
        case bestPrice = "LS.Common.Strings.bestPrice"
        case slashYear = "LS.Common.Strings.slashYear"
        case continueFree = "LS.Common.Strings.continueFree"
        case savingsTracker = "LS.Common.Strings.savingsTracker"
        case beginBuilding = "LS.Common.Strings.beginBuilding"
        case setUr = "LS.Common.Strings.setUr"
        case newGoal = "LS.Common.Strings.newGoal"
        case addEmoji = "LS.Common.Strings.addEmoji"
        case goalName = "LS.Common.Strings.goalName"
        case vacatin = "LS.Common.Strings.vacatin"
        case goalAmount = "LS.Common.Strings.goalAmount"
        case currency = "LS.Common.Strings.currency"
        case dedline = "LS.Common.Strings.dedline"
        case setUrButton = "LS.Common.Strings.setUrButton"
        case save = "LS.Common.Strings.save"
        case smilys = "LS.Common.Strings.smilys"
        case people = "LS.Common.Strings.people"
        case animals = "LS.Common.Strings.animals"
        case food = "LS.Common.Strings.food"
        case travel = "LS.Common.Strings.travel"
        case object = "LS.Common.Strings.object"
        case symbols = "LS.Common.Strings.symbols"
        case flags = "LS.Common.Strings.flags"
        case doU = "LS.Common.Strings.doU"
        case theInformation = "LS.Common.Strings.theInformation"
        case exit = "LS.Common.Strings.exit"
        case cancel = "LS.Common.Strings.cancel"
        case december = "LS.Common.Strings.december"
        case warning = "LS.Common.Strings.warning"
        case notAll = "LS.Common.Strings.notAll"
    }
}
extension Localizable where Self == LS.Common.Strings {
    public var tableName: String? { return "Common" }
}

