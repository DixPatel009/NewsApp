//
//  SettingsViewController.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpView()
    }

}

// MARK: - Setup

extension SettingsViewController {
    
    private func setUpView() {
        self.view.backgroundColor = UI.Colors.backGroundColor
    }
    
}
