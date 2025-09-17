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
    }
}
extension Localizable where Self == LS.Common.Strings {
    public var tableName: String? { return "Common" }
}

