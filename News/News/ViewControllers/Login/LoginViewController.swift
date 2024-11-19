//
//  LoginViewController.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var apiKeyTextFiled: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Properties
    private var viewModel = AuthViewModel()
    var loginSucessfull: (() -> Void)?
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setupViewModel()
    }
    
}

// MARK: - Setup

extension LoginViewController {
    
    private func setUpView() {
        self.view.backgroundColor = UI.Colors.backGroundColor
        self.loginButton.roundCorners()
    }
    
    private func setupViewModel() {
        
        viewModel.onAuthenticationSuccess = { [weak self] in
            guard let self = self else { return }
            self.saveKeyInLocalStorage()
        }
        
        viewModel.onAuthenticationFailure = { [weak self] error in
            guard let self = self else { return }
            AlertHelper.showAlert(on: self, title: Strings.AlertMessage.error, message: error)
        }
        
    }
    
    private func verfiryingAPIKey() {
        
        guard let text = apiKeyTextFiled.text,
              !text.isEmpty else {
            AlertHelper.showAlert(on: self, title: "", message: "Please enter the API Key")
            return
        }
        
        viewModel.authenticate(apiKey: text)
    }
    
    private func saveKeyInLocalStorage() {
        
        guard let text = apiKeyTextFiled.text,
              !text.isEmpty else {
            AlertHelper.showAlert(on: self, title: "", message: "Please enter the API Key")
            return
        }
        
        let viewModel = KeychainViewModel()
        let isSaved = viewModel.saveData(value: text, forKey: Constants.KeychainKey.apiKey)
        if isSaved {
            self.loginSucessfull?()
        } else {
            AlertHelper.showAlert(on: self, title: "", message: "Something went wrong..!")
        }
        
    }
    
}

// MARK: IBAction

extension LoginViewController {
    
    @IBAction func LoginButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.verfiryingAPIKey()
    }
    
}
