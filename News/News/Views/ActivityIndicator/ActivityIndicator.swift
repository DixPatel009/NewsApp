//
//  ActivityIndicator.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView {
    
    override init(style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.large) {
        super.init(style: style)
        color = UI.Colors.white
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(in view: UIView) {
        backgroundColor = UIColor.clear
        view.addSubview(self)
        view.center(subview: self)
        startAnimating()
    }
    
    func dismiss() {
        removeFromSuperview()
        stopAnimating()
    }
    
}
