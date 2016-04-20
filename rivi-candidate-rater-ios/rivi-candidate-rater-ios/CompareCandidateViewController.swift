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
        UIColor.orangeColor()
    ]
    
    private var colorIndex = 0
    private var selectedCandidates = [Profile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radarChart.descriptionText = ""
        radarChart.rotationEnabled = false
        radarChart.yAxis.axisMinValue = 0
        radarChart.yAxis.axisMaxValue = 10
        radarChart.yAxis.drawLabelsEnabled = false
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        colorIndex = 0
        selectedCandidates = Candidates.sharedInstance.selectedCandidates
        setData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setData() {
        var dataSets = [RadarChartDataSet]()
        for profile in selectedCandidates {
            dataSets.append(profileToRadarDataSet(profile))
        }
        let radarData = RadarChartData(xVals: PARAMETERS, dataSets: dataSets)
        if let font = UIFont(name: "HelveticaNeue-Light", size: 8) {
            radarData.setValueFont(font)
        }
        radarChart.data = radarData
    }

    
    private func profileToRadarDataSet(profile: Profile) -> RadarChartDataSet {
        var dataEntries = [ChartDataEntry]()
        dataEntries.append(ChartDataEntry(value: Double(profile.goodLooks), xIndex: 0))
        dataEntries.append(ChartDataEntry(value: Double(profile.wealth), xIndex: 1))
        dataEntries.append(ChartDataEntry(value: Double(profile.marriagePotential), xIndex: 2))
        dataEntries.append(ChartDataEntry(value: Double(profile.swag), xIndex: 3))
        dataEntries.append(ChartDataEntry(value: Double(profile.size), xIndex: 4))

        let radarDataSet = RadarChartDataSet(yVals: dataEntries, label: profile.name)
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
