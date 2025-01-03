//
//  String.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
   
    func dateFromString() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Strings.dateFrormatter.yyyyMMdd
        return dateFormatter.date(from: self)
    }
}
