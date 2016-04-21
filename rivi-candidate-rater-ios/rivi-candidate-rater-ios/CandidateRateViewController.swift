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

    var candidate: Candidate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(CandidateRateViewController.saveClicked))
        
        radarChart.descriptionText = ""
        radarChart.rotationEnabled = false
        radarChart.yAxis.axisMinValue = 0
        radarChart.yAxis.axisMaxValue = 10
        radarChart.yAxis.drawLabelsEnabled = false
        
        slider1.value = Float(candidate.goodLooks)
        slider2.value = Float(candidate.wealth)
        slider3.value = Float(candidate.marriagePotential)
        slider4.value = Float(candidate.swag)
        slider5.value = Float(candidate.size)
        
        setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveClicked() {
        Candidates.saveUserRatings(candidate) { [weak self] (error) in
            if let strongSelf = self {
                if error == nil {
                    strongSelf.navigationController?.popViewControllerAnimated(true)
                } else {
                    Utility.showAutoHideAlert(strongSelf, title: nil, message: "Unable to save user ratings")
                }
            }
        }
    }
    
    @IBAction func goodLooksValueChanged(sender: UISlider) {
        candidate.goodLooks = Int(sender.value + 0.5)
        setData()
    }

    @IBAction func wealthValueChanged(sender: UISlider) {
        candidate.wealth = Int(sender.value + 0.5)
        setData()
    }
    
    @IBAction func marriageValueChanged(sender: UISlider) {
        candidate.marriagePotential = Int(sender.value + 0.5)
        setData()
    }
    
    @IBAction func swagValueChanged(sender: UISlider) {
        candidate.swag = Int(sender.value + 0.5)
        setData()
    }
    
    @IBAction func sizeValueChanged(sender: UISlider) {
        candidate.size = Int(sender.value + 0.5)
        setData()

    }
    
    private func setData() {
        var dataEntries = [ChartDataEntry]()
        dataEntries.append(ChartDataEntry(value: Double(candidate.goodLooks), xIndex: 0))
        dataEntries.append(ChartDataEntry(value: Double(candidate.wealth), xIndex: 1))
        dataEntries.append(ChartDataEntry(value: Double(candidate.marriagePotential), xIndex: 2))
        dataEntries.append(ChartDataEntry(value: Double(candidate.swag), xIndex: 3))
        dataEntries.append(ChartDataEntry(value: Double(candidate.size), xIndex: 4))
        
        let radarDataSet = RadarChartDataSet(yVals: dataEntries, label: candidate.name)
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
