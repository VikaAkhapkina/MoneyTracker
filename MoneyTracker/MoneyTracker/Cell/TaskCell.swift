//
//  TaskCell.swift
//  MoneyTracker
//
//  Created by Viktoriya on 11.10.22.
//

import UIKit

class TaskCell: UITableViewCell {
    
    static let identificator = "TaskCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var isDoneImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup (expense: Expense) {
        titleLabel.text = expense.name
        priceLabel.text = String(expense.price) + "$"
        let  dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        dateLabel.text = dateFormater.string(from: expense.date)
    }
    
}
