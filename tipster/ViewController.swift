//
//  ViewController.swift
//  tipster
//
//  Created by Omar Ihmoda on 1/10/18.
//  Copyright © 2018 Omar Ihmoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var calc_clear = true
    var decimal_used = false
    var tip_low = 0.05
    var tip_med = 0.10
    var tip_high = 0.15
    var amount = 0.0
    var group_size = 1.0
    var tip_amt_low = 0.0
    var tip_amt_med = 0.0
    var tip_amt_high = 0.0
    
    @IBOutlet weak var labelAmount: UILabel!
    
    @IBOutlet weak var tipLabelLow: UILabel!
    
    @IBOutlet weak var tipLabelMed: UILabel!
    
    @IBOutlet weak var tipLabelHigh: UILabel!
    
    @IBOutlet weak var tipSlider: UISlider!
    
    @IBOutlet weak var groupSizeSlider: UISlider!
    
    @IBOutlet weak var tipLowLabel: UILabel!
    
    @IBOutlet weak var tipMedLabel: UILabel!
    
    @IBOutlet weak var tipHighLabel: UILabel!
    
    @IBOutlet weak var totalLowLabel: UILabel!
    
    @IBOutlet weak var totalMedLabel: UILabel!
    
    @IBOutlet weak var totalHighLabel: UILabel!
    
    @IBOutlet weak var groupSizeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelAmount.text = "0"
        self.tipLabelLow.text = "5%"
        self.tipLabelMed.text = "10%"
        self.tipLabelHigh.text = "15%"
        self.tipSlider.value = 0.05
        self.tipSlider.maximumValue = 0.90
        self.groupSizeSlider.minimumValue = 1
        self.groupSizeSlider.maximumValue = 20
        self.groupSizeSlider.value = 1
        self.tipLowLabel.text = "0"
        self.tipMedLabel.text = "0"
        self.tipHighLabel.text = "0"
        self.totalLowLabel.text = "0"
        self.totalMedLabel.text = "0"
        self.totalHighLabel.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if !self.calc_clear {
           
            if sender.tag < 11 {
                self.labelAmount.text?.append(String(sender.tag))
            } else if sender.tag == 11 {
                self.labelAmount.text?.append("0")
            } else if sender.tag == 12 && !decimal_used {
            self.labelAmount.text?.append(".")
                decimal_used = true
            } else if sender.tag == 13 {
                self.clear()
            }
            
        } else {
            if sender.tag < 11 {
                self.labelAmount.text = String(sender.tag)
                self.calc_clear = false
            } else if sender.tag == 12 {
                self.labelAmount.text = "0."
                self.calc_clear = false
                decimal_used = true
            }
            
        }
        self.calc()
    }
    
    
    @IBAction func tipAmountSliderChanged(_ sender: UISlider) {
        self.tipLabelLow.text = String(Int(sender.value * 100)) + "%"
        self.tipLabelMed.text = String(Int(sender.value * 100) + 5) + "%"
        self.tipLabelHigh.text = String(Int(sender.value * 100) + 10) + "%"
        
        self.tip_low = Double(sender.value)
        self.tip_med = self.tip_low + 0.05
        self.tip_high = self.tip_low + 0.10
        
        self.calc()
        
    }
    
    @IBAction func groupSizeSliderChanged(_ sender: UISlider) {
        self.group_size = Double(sender.value)
        self.groupSizeLabel.text = "Group Size: \(Int(self.group_size))"
        self.calc()
    }
    
    
    func clear(){
        self.labelAmount.text = "0"
        self.calc_clear = true
        self.decimal_used = false
    }
    
    func calc(){

        if let cost = Double(labelAmount.text!) {
            self.amount = cost/Double(floor(self.group_size))
        }
        
        self.tip_amt_low  = self.amount * self.tip_low
        self.tip_amt_med  = self.amount * self.tip_med
        self.tip_amt_high = self.amount * self.tip_high
        
        self.tipLowLabel.text = String(format: "%.2f", arguments: [self.tip_amt_low])
        self.tipMedLabel.text = String(format: "%.2f", arguments: [self.tip_amt_med])
        self.tipHighLabel.text = String(format: "%.2f", arguments: [self.tip_amt_high])
        
        self.totalLowLabel.text = String(format: "%.2F", arguments: [self.tip_amt_low + self.amount])
        
        self.totalMedLabel.text = String(format: "%.2F", arguments: [self.tip_amt_med + self.amount])
        
        self.totalHighLabel.text = String(format: "%.2F", arguments: [self.tip_amt_high + self.amount])

    }
    
}

