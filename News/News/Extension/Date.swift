//
//  Date.swift
//  News
//
//  Created by Akabari Dixit on 18/11/24.
//

import Foundation

extension Date {
    
    func stringFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Strings.dateFrormatter.yyyyMMdd
        return dateFormatter.string(from: self)
    }
    
}
