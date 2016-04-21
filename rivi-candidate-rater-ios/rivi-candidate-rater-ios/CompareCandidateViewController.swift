//
//  CompareCandidateViewController.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/19/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

import Charts
import UIKit

class CompareCandidateViewController: UIViewController {
    @IBOutlet weak var radarChart: RadarChartView!

    private let SET_COLORS = [
        UIColor.blueColor(),
        UIColor.yellowColor(),
        UIColor.redColor(),
        UIColor.greenColor(),
        UIColor.orangeColor(),
        UIColor.brownColor(),
        UIColor.cyanColor(),
        UIColor.lightGrayColor(),
        UIColor.purpleColor(),
        UIColor.magentaColor()
    ]
    
    private var colorIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radarChart.descriptionText = ""
        radarChart.rotationEnabled = false
        radarChart.yAxis.axisMinValue = 0
        radarChart.yAxis.axisMaxValue = 10
        radarChart.yAxis.drawLabelsEnabled = false
        radarChart.legend.wordWrapEnabled = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        colorIndex = 0
        setData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setData() {
        var dataSets = [RadarChartDataSet]()
        for candidate in Candidates.selectedCandidates {
            dataSets.append(candidateToRadarDataSet(candidate))
        }
        let radarData = RadarChartData(xVals: PARAMETERS, dataSets: dataSets)
        if let font = UIFont(name: "HelveticaNeue-Light", size: 8) {
            radarData.setValueFont(font)
        }
        radarChart.data = radarData
    }

    private func candidateToRadarDataSet(candidate: Candidate) -> RadarChartDataSet {
        var dataEntries = [ChartDataEntry]()
        dataEntries.append(ChartDataEntry(value: Double(candidate.goodLooks), xIndex: 0))
        dataEntries.append(ChartDataEntry(value: Double(candidate.wealth), xIndex: 1))
        dataEntries.append(ChartDataEntry(value: Double(candidate.marriagePotential), xIndex: 2))
        dataEntries.append(ChartDataEntry(value: Double(candidate.swag), xIndex: 3))
        dataEntries.append(ChartDataEntry(value: Double(candidate.size), xIndex: 4))

        let radarDataSet = RadarChartDataSet(yVals: dataEntries, label: candidate.name)
        radarDataSet.fillColor = SET_COLORS[colorIndex]
        radarDataSet.setColor(SET_COLORS[colorIndex])
        radarDataSet.drawFilledEnabled = true
        
        colorIndex += 1
        if colorIndex == SET_COLORS.count {
            colorIndex = 0
        }
        
        return radarDataSet
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
