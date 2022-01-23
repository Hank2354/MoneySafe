//
//  AnalyticsViewController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation
import Charts
import UIKit

class AnalyticsViewController: UIViewController, AnalyticsViewControllerType {
    
    var presenter: AnalyticsPresenterType?
    
    var currentMonth: String = ""
    
    var currentYear: String = ""
    
    // MARK: - UI Elements
    lazy var backNavBarButton:  UIBarButtonItem        =      {
        let buttonItem = UIBarButtonItem()
        buttonItem.image = .backButtonImage
        buttonItem.tintColor = .white
        
        buttonItem.addTarget(sender: self, action: #selector(backAction))
        
        return buttonItem
    }()
    
    lazy var periodPicker:      ShortDatePickerView    =      {
        
        let picker = ShortDatePickerView()
        
        
        return picker
    }()
    
    lazy var periodTextField: UITextField              =      {
        
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = "  \(currentMonth) \(currentYear)"
        
        tf.backgroundColor = .white
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lazyGray.cgColor
        tf.layer.cornerRadius = 24
        
        tf.delegate = self
        
        tf.inputView = periodPicker
        tf.addDoneCancelToolBar(onDone: (target: self, action: #selector(newPeriodAction)), onCancel: nil)
        
        return tf
    }()
    
    lazy var mainPieChart: PieChartView = {
        
        let currentWidth = self.view.frame.size.width * 0.9
        
        let pieChart = PieChartView(frame: CGRect(x: 0, y: 0,
                                                  width: currentWidth,
                                                  height: currentWidth))
        
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        
        pieChart.legend.enabled = false
        
        pieChart.usePercentValuesEnabled = true
        
        pieChart.highlightPerTapEnabled = false
        
        pieChart.rotationEnabled = false
        
        return pieChart
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        
        let items = ["Расходы", "Доходы"]
        
        let sc = UISegmentedControl(items: items)
        sc.translatesAutoresizingMaskIntoConstraints = false
        
        sc.selectedSegmentIndex = 0
        
        sc.addTarget(self, action: #selector(segmentedControlAction), for: .valueChanged)
        
        return sc
    }()
    
    lazy var totalBudgetView: BudgetView = {
        
        let budgetView = BudgetView()
        budgetView.translatesAutoresizingMaskIntoConstraints = false
        budgetView.progressBar.dataSource = self
        
        budgetView.categoryNameLabel.text = "Общий месячный бюджет"
        
        return budgetView
    }()
    
    lazy var horizontalBarChart: HorizontalBarChartView = {
        
        let barChart = HorizontalBarChartView()
        barChart.translatesAutoresizingMaskIntoConstraints = false
        
        barChart.xAxis.enabled = false
        barChart.leftAxis.axisMinimum = 0
        barChart.rightAxis.enabled = false
        barChart.isUserInteractionEnabled = false
        barChart.legend.enabled = false
        barChart.drawValueAboveBarEnabled = true
        
        barChart.leftAxis.drawGridLinesEnabled = false
        
        return barChart
    }()
    
    // MARK: - Configuration methods
    func configure() {
        
        // Setup navBar
        navigationItem.leftBarButtonItem = backNavBarButton
        self.title = "Расходы"
        
        navigationController?.setNavBarStyle(color: .mainCyan)
        
        // Setup Elements
        view.addSubview(periodTextField)
        view.addSubview(mainPieChart)
        view.addSubview(segmentedControl)
        view.addSubview(totalBudgetView)
        view.addSubview(horizontalBarChart)
        
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(periodTextField.widthAnchor.constraint(equalToConstant: 130))
        constraints.append(periodTextField.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(periodTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 10))
        constraints.append(periodTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        
        constraints.append(mainPieChart.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width))
        constraints.append(mainPieChart.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width))
        constraints.append(mainPieChart.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(mainPieChart.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(mainPieChart.topAnchor.constraint(equalTo: periodTextField.bottomAnchor, constant: 10))
        
        constraints.append(segmentedControl.topAnchor.constraint(equalTo: mainPieChart.bottomAnchor, constant: 20))
        constraints.append(segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40))
        constraints.append(segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40))
        
        constraints.append(totalBudgetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(totalBudgetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        constraints.append(totalBudgetView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 40))
        constraints.append(totalBudgetView.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(horizontalBarChart.topAnchor.constraint(equalTo: totalBudgetView.bottomAnchor, constant: 40))
        constraints.append(horizontalBarChart.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(horizontalBarChart.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(horizontalBarChart.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(horizontalBarChart.heightAnchor.constraint(equalToConstant: 200))
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func activateProgressBarAnimation()                                          {
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0,
                       options: .curveLinear,
                       animations: {

            self.totalBudgetView.progressBar.setProgress(section: 0, to: self.totalBudgetView.getCurrentProgressBarPosition())

        })
        
    }
    
    // MARK: - Public methods
    func update(with pieData: GeneralMainAnalyticsModel,
                barData: GeneralBarAnalyticsModel,
                totalBudget: Decimal,
                totalExpensesMonth: Decimal) {
        
        // MARK: - Update main pieChart
        var entries = [ChartDataEntry]()
        var chartColors = [NSUIColor]()
        
        for data in pieData.data {
            let entry = PieChartDataEntry(value: (data.amount as NSDecimalNumber).doubleValue, label: data.category.categoryName)
            entries.append(entry)
            chartColors.append(data.category.color!)
        }
        
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.setColors(chartColors, alpha: 1)
        
        
        let chartData = PieChartData(dataSet: dataSet)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        formatter.percentSymbol = " %"
        
        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        mainPieChart.data = chartData
        
        let currentCenterText = "\(pieData.month) \(pieData.year)\n\(pieData.totalExpensesBalance) ₽"
        
        mainPieChart.centerAttributedText = NSAttributedString(string: currentCenterText, attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)
        ])
        
        mainPieChart.animate(yAxisDuration: 0.7)
        
        // MARK: - Update totalBudget chart
        totalBudgetView.budgetLabel.text = "\(totalBudget) ₽"
        totalBudgetView.spentMoneyLabel.text = "\(totalExpensesMonth) ₽"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.activateProgressBarAnimation()
        }
        
        // MARK: - Update barChart
        
        
        
        let barSet = BarChartDataSet(entries: [
            BarChartDataEntry(x: 1,
                              y: (barData.totalExpenses as NSDecimalNumber).doubleValue.roundToPlaces(2)),
            
            BarChartDataEntry(x: 2,
                              y: (barData.totalIncomes as NSDecimalNumber).doubleValue.roundToPlaces(2))
        ])
        
        barSet.setColors(.mainRed, .mainGreen)
        
        let barData = BarChartData(dataSet: barSet)
        
        horizontalBarChart.data = barData
        
        horizontalBarChart.animate(yAxisDuration: 0.7)
        
    }
    
    func presentWarnMessage(alertController: UIAlertController) {
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - User actions
    @objc func backAction()                                   {
        presenter?.backButtonPressed()
    }
    
    @objc func newPeriodAction() {
        
        currentMonth = periodPicker.selectedMonth
        currentYear = periodPicker.selectedYear
        
        periodTextField.text = "  \(currentMonth) \(currentYear)"
        
        let value = segmentedControl.selectedSegmentIndex
        
        switch value {
        case 0: presenter?.updateCharts(type: .expense)
        case 1: presenter?.updateCharts(type: .income)
        default:
            return
        }
        
        view.endEditing(true)
    }
    
    @objc func segmentedControlAction() {
        
        let value = segmentedControl.selectedSegmentIndex
        
        switch value {
        case 0: presenter?.updateCharts(type: .expense)
        case 1: presenter?.updateCharts(type: .income)
        default:
            return
        }
        
    }
    
    // MARK: - ViewController Life cycle
    override func loadView()                                          {
        
        self.view = UIScrollView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: UIScreen.main.bounds.width,
                                               height: UIScreen.main.bounds.height))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Аналитика"
        
        
        
        configure()
        
        presenter?.updateCharts(type: .expense)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}
