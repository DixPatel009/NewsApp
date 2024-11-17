//
//  UIView.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

extension UIView {
    
    // Corner Rounding
    func roundCorners(with radius: CGFloat = UI.Layer.cornerRadius) {
        let center = self.center
        layer.cornerRadius = radius
        self.center = center
        clipsToBounds = true
    }
    
    // Centering Subview
    func center(subview: UIView) {
        guard subviews.contains(subview) else { return }
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        subview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
