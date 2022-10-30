//
//  ChartViewController.swift
//  MoneyTracker
//
//  Created by Viktoriya on 24.10.22.
//

import UIKit
import AAInfographics

class ChartViewController: UIViewController {
    
    let realmManeger = RealmManager()
    
    @IBOutlet weak var chartView: AAChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }
    
    func setup() {
        view.backgroundColor = #colorLiteral(red: 0.7012960315, green: 0.8611509204, blue: 1, alpha: 1)
        let aaChartModel = AAChartModel()
            .chartType(.column)//Can be any of the chart types listed under `AAChartType`.
            .animationType(.bounce)
            .title("Статистика")//The chart title
            .subtitle("затрат по категориям")//The chart subtitle
            .dataLabelsEnabled(false) //Enable or disable the data labels. Defaults to false
            .tooltipValueSuffix("USD")//the value suffix of the chart tooltip
            .categories(["Food", "Car", "House"]) // expense category
            .series([
                AASeriesElement()
                    .data([getExpensesForCategory(category: .food),
                           getExpensesForCategory(category: .car),
                           getExpensesForCategory(category: .house)])
                    ])
        chartView.aa_drawChartWithChartModel(aaChartModel)

    }
    
    func getExpensesForCategory(category: ExpenseCategory) -> Double {
        let filtred = realmManeger.getExpenses().filter { expense in
            expense.category == category // фильтр по категории
            
        }
        let prices = filtred.map { expense in
            expense.price
        }
        return prices.reduce(0, +)
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
