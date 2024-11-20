//
//  PickerView.swift
//  News
//
//  Created by Akabari Dixit on 20/11/24.
//

import UIKit

protocol PickerViewDelegate: AnyObject {
    func didSelectOption(_ picker: PickerView, selectedOption: String)
    func didCancelSelection(_ picker: PickerView)
}

class PickerView: UIView {
    
    // MARK: - Properties
    
    private let pickerView = UIPickerView()
    private var options: [String] = []
    private let toolbar = UIToolbar()
    weak var delegate: PickerViewDelegate?

    private var selectedOption: String?

    // MARK: - Initialization
    
    init(options: [String]) {
        super.init(frame: .zero)
        self.options = options
        selectedOption = options.first
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI Setup

extension PickerView {
    
    private func setupUI() {
        
        self.backgroundColor = UI.Colors.backGroundColor
        
        // Picker View
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.setValue(UIColor.white, forKey: "textColor")

        // Toolbar
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.sizeToFit()
        toolbar.tintColor = .black
        toolbar.backgroundColor = .white
        
        let doneButton = UIBarButtonItem(title: Strings.done, style: .done, target: self, action: #selector(doneTapped))
        let cancelButton = UIBarButtonItem(title: Strings.cancel, style: .plain, target: self, action: #selector(cancelTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [cancelButton, spacer, doneButton]

        // Add to view
        addSubview(toolbar)
        addSubview(pickerView)

        // Layout
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: trailingAnchor),
            toolbar.topAnchor.constraint(equalTo: topAnchor),

            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}

// MARK: - Actions

extension PickerView {
    
    @objc private func doneTapped() {
        if let selectedOption = selectedOption {
            delegate?.didSelectOption(self, selectedOption: selectedOption)
        }
    }

    @objc private func cancelTapped() {
        delegate?.didCancelSelection(self)
    }
    
}

// MARK: - UIPickerView Delegate & DataSource

extension PickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = options[row]
    }
    
}
