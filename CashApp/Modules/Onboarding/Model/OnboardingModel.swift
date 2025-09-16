//
//  OnboardingNodel.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

struct OnboardingModel {
    let title: String
    let subtitle: String
    let image: UIImage
}

struct OnboardingData {
    static let data: [OnboardingModel] = [
        OnboardingModel(title: LS.Common.Strings.keepAll.localized, subtitle:  LS.Common.Strings.setUp.localized, image: UIImage.asset(.onboard1Image)),
        OnboardingModel(title: LS.Common.Strings.getDetailed.localized, subtitle:  LS.Common.Strings.seeExactly.localized, image: UIImage.asset(.onboard2Image)),
        OnboardingModel(title: LS.Common.Strings.trackThe.localized, subtitle:  LS.Common.Strings.reviewEvery.localized, image: UIImage.asset(.onboard3Image))
            ]
}
