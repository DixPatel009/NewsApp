//
//  UIViewController.swift
//  News
//
//  Created by Akabari Dixit on 18/11/24.
//

import UIKit

extension UIViewController {
    
    func setCustomBackButton(action: Selector = #selector(backButtonAction)) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32.0, height: 44.0))
        let backButton = UIButton(frame: CGRect(x: -8.0, y: 0, width: 32.0, height: 44.0))
        backButton.setImage(UIImage(named: Images.back), for: .normal)
        backButton.addTarget(self, action: action, for: .touchUpInside)
        view.addSubview(backButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
    }
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func presentActivityViewController(shareable: String, completion: (() -> Void)? = nil) {
        let activityViewController = GlobalFunction.shared.activityViewController(for: shareable)
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            completion?()
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    func displayLogin() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.configureLoginViewController()
    }
}
