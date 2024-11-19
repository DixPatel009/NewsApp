//
//  SettingsViewController.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var changeAPIKeyButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
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
        self.changeAPIKeyButton.roundCorners()
        self.logoutButton.roundCorners()
    }
    
}

// MARK: - IBAction

extension SettingsViewController {
    
    @IBAction func logoutButtonAction(_ sender: UIButton) {
        AlertHelper.showAlert(on: self, title: Strings.AlertMessage.warning, message: Strings.AlertMessage.logout, isCancelButton: true, completion:  {
            LogoutHandler.logout()
            self.displayLogin()
        })
    }
    
    @IBAction func changeAPIKeyButtonAction(_ sender: UIButton) {
        let viewController = ChangeAPIKeyViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
