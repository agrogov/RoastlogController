//
//  Charts.swift
//  HM10Controller
//
//  Created by Dr. Morg on 02.06.16.
//  Copyright © 2016 Alexey Rogov. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: UIViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setChart(months, values: unitsSold)
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }

        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
        lineChartView.xAxis.labelPosition = .Bottom
        
        let ll = ChartLimitLine(limit: 10.0, label: "Target")
        lineChartView.rightAxis.addLimitLine(ll)
    }
    

    @IBAction func saveChart(sender: UIBarButtonItem) {
        lineChartView.saveToCameraRoll()
    }
    
}