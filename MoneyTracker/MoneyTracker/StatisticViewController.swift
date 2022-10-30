//
//  StatisticViewController.swift
//  MoneyTracker
//
//  Created by Viktoriya on 24.10.22.
//

import UIKit
import AAInfographics

class StatisticViewController: UIViewController {

    let realmManeger = RealmManager()
    var startDate: Date?
    var endDate: Date?
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var periodPriceLabel: UILabel!
    @IBOutlet weak var calculatorButten: UIButton!
    @IBOutlet weak var sumLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func screenTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculatorButtenAction(_ sender: Any) {
        getPriceForPeriod()
    }
    
    private lazy var startDatePicker: UIDatePicker = {
      let datePicker = UIDatePicker(frame: .zero)
      datePicker.datePickerMode = .date
      datePicker.timeZone = TimeZone.current
      return datePicker
    }()
    
    private lazy var endDatePicker: UIDatePicker = {
      let datePicker = UIDatePicker(frame: .zero)
      datePicker.datePickerMode = .date
      datePicker.timeZone = TimeZone.current
      return datePicker
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculate()
    }
    
    func setup() {
        view.backgroundColor = #colorLiteral(red: 0.5909224153, green: 0.8026877642, blue: 0.9100808501, alpha: 1)
        sumLabel.layer.cornerRadius = 5
        sumLabel.layer.masksToBounds = true
        calculatorButten.layer.cornerRadius = 5
        calculatorButten.layer.masksToBounds = true
        calculatorButten.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        calculatorButten.titleLabel?.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        startDateTextField.inputView = startDatePicker
          startDatePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        endDateTextField.inputView = endDatePicker
          endDatePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        if #available(iOS 14, *) {
            startDatePicker.preferredDatePickerStyle = .wheels
            endDatePicker.preferredDatePickerStyle = .wheels
        }
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        if sender == startDatePicker {
            startDateTextField.text = dateFormatter.string(from: sender.date)
            startDate = sender.date
        } else {
            endDateTextField.text = dateFormatter.string(from: sender.date)
            endDate = sender.date
        }
     }
    
    func getPriceForPeriod() {
        guard let startDate = startDate, // проверяем что у нас есть старт и энд
              let endDate = endDate else {
            return
        }
        
        // получение
        let filtred = RealmManager().getExpenses().filter { expense in
            return expense.date > startDate && expense.date < endDate
        }
        
//        let expenses = realmManeger.getExpenses() второй вариант
//        var filtred = [Expense]()
//        for expense in expenses {
//            if expense.date > startDate && expense.date < endDate {
//                filtred.append(expense)
//            }
//        }
        if filtred.isEmpty {
            periodPriceLabel.text = "Empty"
        } else {
//            var sum: Double = 0
//            for expense in filtred {
//                sum += expense.price
//            }
//            periodPriceLabel.text = String(sum)
            let prices = filtred.map { expense in // массив цен
                return expense.price
            }
            let sum = prices.reduce(0, +) // метод редьюс, начальное значение ноль, прибавляем
            periodPriceLabel.text = String(sum)
        }

    }
    
    func calculate() {
        let expenses = realmManeger.getExpenses() // получаем
        var sum: Double = 0 // считаем общую сумму затрат
        for expense in expenses {
            sum += expense.price
        }
        priceLabel.text = String(sum)
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
