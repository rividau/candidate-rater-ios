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
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var slider3: UISlider!
    @IBOutlet weak var slider4: UISlider!
    @IBOutlet weak var slider5: UISlider!

    var profile: Profile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(CandidateRateViewController.saveClicked))
        
        radarChart.descriptionText = ""
        radarChart.rotationEnabled = false
        radarChart.yAxis.axisMinValue = 0
        radarChart.yAxis.axisMaxValue = 10
        radarChart.yAxis.drawLabelsEnabled = false
        
        slider1.value = Float(profile.goodLooks)
        slider2.value = Float(profile.wealth)
        slider3.value = Float(profile.marriagePotential)
        slider4.value = Float(profile.swag)
        slider5.value = Float(profile.size)
        
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
        profile.goodLooks = Double(Int(sender.value + 0.5))
        setData()
    }

    @IBAction func wealthValueChanged(sender: UISlider) {
        profile.wealth = Double(Int(sender.value + 0.5))
        setData()
    }
    
    @IBAction func marriageValueChanged(sender: UISlider) {
        profile.marriagePotential = Double(Int(sender.value + 0.5))
        setData()
    }
    
    @IBAction func swagValueChanged(sender: UISlider) {
        profile.swag = Double(Int(sender.value + 0.5))
        setData()
    }
    
    @IBAction func sizeValueChanged(sender: UISlider) {
        profile.size = Double(Int(sender.value + 0.5))
        setData()

    }
    
    private func setData() {
        var dataEntries = [ChartDataEntry]()
        dataEntries.append(ChartDataEntry(value: profile.goodLooks, xIndex: 0))
        dataEntries.append(ChartDataEntry(value: profile.wealth, xIndex: 1))
        dataEntries.append(ChartDataEntry(value: profile.marriagePotential, xIndex: 2))
        dataEntries.append(ChartDataEntry(value: profile.swag, xIndex: 3))
        dataEntries.append(ChartDataEntry(value: profile.size, xIndex: 4))
        
        let radarDataSet = RadarChartDataSet(yVals: dataEntries, label: profile.name)
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
