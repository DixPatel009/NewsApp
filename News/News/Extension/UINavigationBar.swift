//
//  UINavigationBar.swift
//  News
//
//  Created by Akabari Dixit on 18/11/24.
//

import UIKit

extension UINavigationBar {

    func setTransparent() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
    }
    
}
