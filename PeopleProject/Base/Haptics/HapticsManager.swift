//
//  HapticsManager.swift
//  PeopleProject
//
//  Created by Claire Roughan on 13/11/2024.
//

import Foundation
import UIKit

//restricts the use of an entity within the same defined source file / private access within the file itself
fileprivate final class HapticsManager {
    
    static let shared = HapticsManager()
    
    private let feedback = UINotificationFeedbackGenerator()
    
    private init() {}
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        feedback.notificationOccurred(notification)
    }
}

//Reduce amount of code needed to type to use Haptics as it wraps the above trigger func, just call haptic(thetype)
func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    
    //Check userDefaults to see if haptics should be enabled
    if UserDefaults.standard.bool(forKey: UserDefaultKeys.hapticsEnabled) {
        HapticsManager.shared.trigger(notification)
    }
}
