//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var labelNoValue: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var resultBillTextField = 0.0
    var finalResult = "0.0"
    
    
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        let title = sender.currentTitle!
        
        let titleMinusPercentSing = String(title.dropLast())
        let buttonTitleAsNumber = Double(titleMinusPercentSing)!
        tip = buttonTitleAsNumber / 100
        billTextField.endEditing(true)
        
       
        
        
    }
    
    
    @IBAction func stepValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
        billTextField.endEditing(true)

    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
        
        if bill != "" {
            resultBillTextField = Double(bill) ?? 0.0
            
            let percent = resultBillTextField * tip
            let result = (resultBillTextField + percent) / Double(numberOfPeople)
            finalResult  = String(format: "%.2f", result)
        }
        if bill != "" {
            self.performSegue(withIdentifier: "goToResults", sender: self)
            labelNoValue.isHidden = true
        }else {
            labelNoValue.isHidden = false
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
    
}

