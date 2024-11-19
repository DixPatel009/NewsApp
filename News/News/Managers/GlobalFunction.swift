//
//  GlobalFunction.swift
//  News
//
//  Created by Akabari Dixit on 18/11/24.
//

import Foundation
import UIKit

class GlobalFunction {
    
    // MARK: - Properties
    static let shared = GlobalFunction()
    
    func oneMonthAgo() -> Date? {
        let calendar = Calendar.current
        let currentDate = Date()
        let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: currentDate)
        return oneMonthAgo
    }
    
    func activityViewController(for shareable: String) -> UIActivityViewController {
        let viewController = UIActivityViewController(activityItems: [shareable], applicationActivities: nil)
        // if any type we need to exclud then enable this...
//        viewController.excludedActivityTypes = [
//            .airDrop, .print, .assignToContact, .saveToCameraRoll, .addToReadingList, .postToFlickr, .postToVimeo,
//        ]
        return viewController
    }
}
