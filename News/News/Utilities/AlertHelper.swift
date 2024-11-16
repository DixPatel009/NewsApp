//
//  AlertHelper.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

class AlertHelper {
    
    static func showAlert(on viewController: UIViewController,
                          title: String,
                          message: String,
                          buttonTitle: String = "OK",
                          completion: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
        }
        
        alertController.addAction(action)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
