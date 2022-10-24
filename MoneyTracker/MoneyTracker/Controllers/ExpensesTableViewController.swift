//
//  ViewController.swift
//  MoneyTracker
//
//  Created by Viktoriya on 10.10.22.
//

import UIKit
import RealmSwift

class ExpensesTableViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    
    private var dataSourse = [Expense]()
    
    private let realManager = RealmManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readDate()
    }
    
    func readDate() {
        dataSourse = realManager.getExpenses()
        tableView.reloadData()
    }
    
    func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: TaskCell.identificator)
    }

    
    @IBAction func addButtenPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destionation = storyboard.instantiateViewController(withIdentifier: "AddRecordViewController") as? AddRecordViewController else { return }
        navigationController?.pushViewController(destionation, animated: true)
        
        }
}

extension ExpensesTableViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var expense = expenses[indexPath.section][indexPath.row]
//        expense.category.self
//        dataSourse[indexPath.section].remove(at: indexPath.row)
//
//        let newSetion = indexPath.section == 0 ? 1 : 0
//        expenses[newSetion].append(expense)
//        tableView.reloadData()
//    }
}

extension ExpensesTableViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identificator, for: indexPath) as? TaskCell else { return UITableViewCell()
            }
            let expense = dataSourse[indexPath.row]
            cell.setup(expense: expense)
            return cell

        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataSourse.count
        }
//        func numberOfSections(in tableView: UITableView) -> Int {
//           return expenses.count
//    }

    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Pending"
//        } else {
//            return "Done"
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? { // свайп
        let action = UIContextualAction(style: .normal, title: "Delete") { _, _, completion in
            self.dataSourse.remove(at: indexPath.row)
            tableView.reloadData()
            completion(true)
        }
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
    }

}
