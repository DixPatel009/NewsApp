//
//  UIColor.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

extension UIColor {
    
    //RGB to UIColor
    class func with(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        let divisor: CGFloat = 255.0
        return UIColor(red: red / divisor, green: green / divisor, blue: blue / divisor, alpha: alpha)
    }
    
}
