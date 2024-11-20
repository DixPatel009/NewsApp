//
//  PickerBottomSheetViewController.swift
//  News
//
//  Created by Akabari Dixit on 20/11/24.
//

import UIKit

class PickerBottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    private var pickerView: PickerView!
    private let options: [String]
    var onOptionSelected: ((String) -> Void)?

    // MARK: - Initializer
    
    init(options: [String]) {
        self.options = options
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        pickerView = PickerView(options: options)
        pickerView.delegate = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
}

// MARK: - PickerViewDelegate

extension PickerBottomSheetViewController: PickerViewDelegate {
    
    func didSelectOption(_ picker: PickerView, selectedOption: String) {
        dismiss(animated: true) {
            self.onOptionSelected?(selectedOption)
        }
    }

    func didCancelSelection(_ picker: PickerView) {
        dismiss(animated: true, completion: nil)
    }
    
}
