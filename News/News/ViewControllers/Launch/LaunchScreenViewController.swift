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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.checkIfUserAlreadyLoggedIn()
        }
    }
    
}

// MARK: - Setup

extension LaunchScreenViewController {
    
    private func setUpView() {
        self.view.backgroundColor = UI.Colors.backGroundColor
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
