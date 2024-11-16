//
//  LaunchScreenViewController.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    var animationCompletion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.animationCompletion?()
        }
    }
}
