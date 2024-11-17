//
//  UI.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

struct UI {
    
    struct Colors {
        static let backGroundColor = UIColor.with(red: 12, green: 12, blue: 12)
        static let darkGray = UIColor.with(red: 128, green: 128, blue: 128)
        static let white = UIColor.white
        static let coreBlue = UIColor.with(red: 0, green: 255, blue: 235)
    }
    
    struct Layer {
        static let borderRadius: CGFloat = 2
        static let borderColor: CGColor = Colors.white.cgColor
        static let borderGrayColor: CGColor = Colors.darkGray.cgColor
        static let cornerRadius: CGFloat = 8
        static let shadowOffsetWidth: CGFloat = 2
    }
}
