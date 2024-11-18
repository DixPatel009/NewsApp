//
//  DatePickerManager.swift
//  News
//
//  Created by Akabari Dixit on 18/11/24.
//

import UIKit

class DatePickerManager: NSObject {
    
    static let shared = DatePickerManager()

    private var onDateSelected: ((String) -> Void)?
    
    private override init() {}

    func showDatePicker(in viewController: UIViewController, selectedDate: String?, completion: @escaping (String) -> Void) {
        self.onDateSelected = completion
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: alert.view.bounds.width - 16, height: 200))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) // Max date is yesterday
        
        if let parsedDate = selectedDate?.dateFromString() {
            datePicker.date = parsedDate
        } else {
            datePicker.date = Date()
        }

        alert.view.addSubview(datePicker)
        
        let selectAction = UIAlertAction(title: "Done", style: .default) { _ in
            let selectedDateString = datePicker.date.stringFromDate()
            self.onDateSelected?(selectedDateString)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(selectAction)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true)
    }
    
}
