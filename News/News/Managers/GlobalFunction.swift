//
//  GlobalFunction.swift
//  News
//
//  Created by Akabari Dixit on 18/11/24.
//

import Foundation

class GlobalFunction {
    
    static let shared = GlobalFunction()
    
    func oneMonthAgo() -> Date? {
        let calendar = Calendar.current
        let currentDate = Date()
        let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: currentDate)
        return oneMonthAgo
    }
    
}
