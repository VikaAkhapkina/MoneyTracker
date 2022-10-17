//
//  AddRecordViewController.swift
//  MoneyTracker
//
//  Created by Viktoriya on 10.10.22.
//

import UIKit
import RealmSwift


class AddRecordViewController: UIViewController {

    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var categorySegment: UISegmentedControl!
    
    private let realManager = RealmManager()
    
    private lazy var datePicker: UIDatePicker = {
      let datePicker = UIDatePicker(frame: .zero)
      datePicker.datePickerMode = .date
      datePicker.timeZone = TimeZone.current
      return datePicker
    }()
    
    private var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func screenTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    func setup() {
        priceTextField.keyboardType = .decimalPad //клавитура где только числа и точка
        dateTextField.inputView = datePicker
          datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateTextField.text = dateFormatter.string(from: sender.date)
        selectedDate = sender.date
     }

    @IBAction func addButtenPressed(_ sender: Any) {
        guard let title = TitleTextField.text,
              !title.isEmpty,
              let priceString = priceTextField.text,
              let price = Double(priceString),
            let date = selectedDate else {
            return
              }
        let category = getCategory()
        realManager.saveExpense(name: title, price: price, date: date, category: category)
        navigationController?.popViewController(animated: true)
    }
    
    private func getCategory() -> ExpenseCategory {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            return .food
        case 1:
            return .house
        case 2:
            return .car
        default:
            return .food
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
