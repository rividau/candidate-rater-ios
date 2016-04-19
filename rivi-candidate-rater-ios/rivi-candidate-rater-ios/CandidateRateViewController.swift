//
//  CandidateRateViewController.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/18/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

import Charts
import UIKit

class CandidateRateViewController: UIViewController {
    @IBOutlet weak var radarChart: RadarChartView!

    private let PARAMETERS = ["Good Looks", "Wealth O'Meter", "Marriage Potential", "Swag Level", "Height"]

    var name = ""
    private var values = [0.0, 0.0, 0.0, 0.0, 0.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(CandidateRateViewController.saveClicked))
        
        radarChart.descriptionText = ""
        radarChart.rotationEnabled = false
        radarChart.yAxis.axisMinValue = 0
        radarChart.yAxis.axisMaxValue = 10
        radarChart.yAxis.drawLabelsEnabled = false
        setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveClicked() {
        print("SAVE CANDIDATE RATING")
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func goodLooksValueChanged(sender: UISlider) {
        values[0] = Double(Int(sender.value + 0.5))
        setData()
    }

    @IBAction func wealthValueChanged(sender: UISlider) {
        values[1] = Double(Int(sender.value + 0.5))
        setData()
    }
    
    @IBAction func marriageValueChanged(sender: UISlider) {
        values[2] = Double(Int(sender.value + 0.5))
        setData()
    }
    
    @IBAction func swagValueChanged(sender: UISlider) {
        values[3] = Double(Int(sender.value + 0.5))
        setData()
    }
    
    @IBAction func heightValueChanged(sender: UISlider) {
        values[4] = Double(Int(sender.value + 0.5))
        setData()

    }
    
    private func setData() {
        var dataEntries = [ChartDataEntry]()
        for i in 0 ..< values.count {
            dataEntries.append(ChartDataEntry(value: values[i], xIndex: i))
        }
        let radarDataSet = RadarChartDataSet(yVals: dataEntries, label: name)
        radarDataSet.fillColor = UIColor.blueColor()
        radarDataSet.setColor(UIColor.blueColor())
        radarDataSet.drawFilledEnabled = true
        let radarData = RadarChartData(xVals: PARAMETERS, dataSets: [radarDataSet])
        if let font = UIFont(name: "HelveticaNeue-Light", size: 8) {
            radarData.setValueFont(font)
        }
        radarChart.data = radarData
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
