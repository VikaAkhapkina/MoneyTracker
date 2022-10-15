//
//  ViewController.swift
//  MoneyTracker
//
//  Created by Viktoriya on 10.10.22.
//

import UIKit

class ExpensesTableViewController: UIViewController {
    
    var expenses: [[Expense]] = [[], []]

    @IBOutlet weak var tableView: UITableView!
    
    private var dataSourse = [Expense]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        // Do any additional setup after loading the view.
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
        destionation.delegate = self
        navigationController?.pushViewController(destionation, animated: true)
        
        }
}

extension ExpensesTableViewController: AddRecordViewControllerDelegate {
    func expenseAdded(expense: Expense) {
        expenses[0].append(expense)
        tableView.reloadData()
        
    }
}

extension ExpensesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var expense = expenses[indexPath.section][indexPath.row]
        expense.category.self
        expenses[indexPath.section].remove(at: indexPath.row)
      
        let newSetion = indexPath.section == 0 ? 1 : 0
        expenses[newSetion].append(expense)
        tableView.reloadData()
    }
}

extension ExpensesTableViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identificator, for: indexPath)
            let array = expenses[indexPath.section]
            let expense = array[indexPath.row]
            return cell

        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return expenses[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Pending"
        } else {
            return "Done"
        }
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? { // свайп
        let action = UIContextualAction(style: .normal, title: "Delete") { _, _, completion in
            tableView.reloadData()
            completion(true)
        }
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
    }



