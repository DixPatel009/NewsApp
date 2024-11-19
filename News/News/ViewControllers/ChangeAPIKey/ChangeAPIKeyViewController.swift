//
//  ChangeAPIKeyViewController.swift
//  News
//
//  Created by Akabari Dixit on 19/11/24.
//

import UIKit

class ChangeAPIKeyViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var oldAPIKeyTextfiled: UITextField!
    @IBOutlet weak var NewAPIKeyTextfiled: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    var authViewModel = AuthViewModel()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
}

// MARK: - Setup

extension ChangeAPIKeyViewController {
    
    private func setUpView() {
        self.view.backgroundColor = UI.Colors.backGroundColor
        navigationController?.navigationBar.setTransparent()
        self.updateButton.roundCorners()
        self.setCustomBackButton()
        self.setupViewModel()
    }
    
    private func checkValidation() {
        guard let oldAPIKey = oldAPIKeyTextfiled.text,
              !oldAPIKey.isEmpty else {
            AlertHelper.showAlert(on: self, title: Strings.AlertMessage.warning, message: Strings.AlertMessage.emptyOldKey)
            return
        }
        
        let viewModel = KeychainViewModel()
        guard let storedOldAPIKey = viewModel.fetchData(forKey: Constants.KeychainKey.apiKey),
              storedOldAPIKey != "" else {
            AlertHelper.showAlert(on: self, title: Strings.AlertMessage.warning, message: Strings.AlertMessage.notFoundOldKey)
            return
        }
        
        guard oldAPIKey == storedOldAPIKey else {
            AlertHelper.showAlert(on: self, title: Strings.AlertMessage.warning, message: Strings.AlertMessage.inValidOldKey)
            return
        }
        
        guard let newAPIKey = NewAPIKeyTextfiled.text,
              !newAPIKey.isEmpty else {
            AlertHelper.showAlert(on: self, title: Strings.AlertMessage.warning, message: Strings.AlertMessage.emptyNewKey)
            return
        }
        
        authViewModel.authenticate(apiKey: newAPIKey)
    }
    
    private func setupViewModel() {
        
        authViewModel.onAuthenticationSuccess = { [weak self] in
            guard let self = self else { return }
            self.saveKeyInLocalStorage()
        }
        
        authViewModel.onAuthenticationFailure = { [weak self] error in
            guard let self = self else { return }
            AlertHelper.showAlert(on: self, title: Strings.AlertMessage.error, message: error)
        }
        
    }
    
    private func saveKeyInLocalStorage() {
        
        guard let text = NewAPIKeyTextfiled.text,
              !text.isEmpty else {
            AlertHelper.showAlert(on: self, title: Strings.AlertMessage.warning, message: Strings.AlertMessage.emptyNewKey)
            return
        }
        
        let viewModel = KeychainViewModel()
        let isSaved = viewModel.updateData(value: text, forKey: Constants.KeychainKey.apiKey)
        if isSaved {
            AlertHelper.showAlert(on: self, title: Strings.AlertMessage.success, message: Strings.AlertMessage.keyUpdateSucessfully, completion:  {
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            AlertHelper.showAlert(on: self, title: Strings.AlertMessage.error, message: Strings.AlertMessage.somethingWrong)
        }
        
    }
    
}

// MARK: - IBAction

extension ChangeAPIKeyViewController {
    
    @IBAction func updateButtonAction(_ sender: UIButton) {
        self.checkValidation()
    }
    
}
