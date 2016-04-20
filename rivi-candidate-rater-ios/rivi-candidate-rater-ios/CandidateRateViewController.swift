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
    var newCandidate: Candidate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(CandidateRateViewController.saveClicked))
        
        radarChart.descriptionText = ""
        radarChart.rotationEnabled = false
        radarChart.yAxis.axisMinValue = 0
        radarChart.yAxis.axisMaxValue = 10
        radarChart.yAxis.drawLabelsEnabled = false
        
        copyCandidate()
        
        slider1.value = Float(newCandidate.goodLooks)
        slider2.value = Float(newCandidate.wealth)
        slider3.value = Float(newCandidate.marriagePotential)
        slider4.value = Float(newCandidate.swag)
        slider5.value = Float(newCandidate.size)
        
        setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func copyCandidate() {
        newCandidate = Candidate(json: candidate.json)
        newCandidate.name = candidate.name
        newCandidate.id = candidate.id
        newCandidate.goodLooks = candidate.goodLooks
        newCandidate.wealth = candidate.wealth
        newCandidate.marriagePotential = candidate.marriagePotential
        newCandidate.swag = candidate.swag
        newCandidate.size = candidate.size
    }
    
    func saveClicked() {
        Candidates.saveUserRatings(newCandidate) { [weak self] (error) in
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
        newCandidate.goodLooks = Int(sender.value + 0.5)
        setData()
    }

    @IBAction func wealthValueChanged(sender: UISlider) {
        newCandidate.wealth = Int(sender.value + 0.5)
        setData()
    }
    
    @IBAction func marriageValueChanged(sender: UISlider) {
        newCandidate.marriagePotential = Int(sender.value + 0.5)
        setData()
    }
    
    @IBAction func swagValueChanged(sender: UISlider) {
        newCandidate.swag = Int(sender.value + 0.5)
        setData()
    }
    
    @IBAction func sizeValueChanged(sender: UISlider) {
        newCandidate.size = Int(sender.value + 0.5)
        setData()

    }
    
    private func setData() {
        var dataEntries = [ChartDataEntry]()
        dataEntries.append(ChartDataEntry(value: Double(newCandidate.goodLooks), xIndex: 0))
        dataEntries.append(ChartDataEntry(value: Double(newCandidate.wealth), xIndex: 1))
        dataEntries.append(ChartDataEntry(value: Double(newCandidate.marriagePotential), xIndex: 2))
        dataEntries.append(ChartDataEntry(value: Double(newCandidate.swag), xIndex: 3))
        dataEntries.append(ChartDataEntry(value: Double(newCandidate.size), xIndex: 4))
        
        let radarDataSet = RadarChartDataSet(yVals: dataEntries, label: newCandidate.name)
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
