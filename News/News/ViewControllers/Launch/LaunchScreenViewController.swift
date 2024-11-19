//
//  LaunchScreenViewController.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    var userAlreadyLoggedIn: ((Bool) -> Void)?
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
}

// MARK: - Setup

extension LaunchScreenViewController {
    
    private func setUpView() {
        self.view.backgroundColor = UI.Colors.backGroundColor
        self.setUpLogoView()
    }
    
    private func setUpLogoView() {
        let imageV = UIImageView(frame: CGRect(x: 50, y: 100, width: 75, height: 75))
        imageV.center = view.center
        imageV.image = UIImage(named: "news")
        view.addSubview(imageV)
        
        UIView.animate(withDuration: 2.0, animations: {
            imageV.transform = CGAffineTransform(scaleX: 2, y: 2)
        }) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.checkIfUserAlreadyLoggedIn()
        }
    }
    
    private func checkIfUserAlreadyLoggedIn() {
        let viewModel = KeychainViewModel()
        if let value = viewModel.fetchData(forKey: Constants.KeychainKey.apiKey),
           value != "" {
            self.userAlreadyLoggedIn?(true)
        } else {
            self.userAlreadyLoggedIn?(false)
        }
    }
    
}
