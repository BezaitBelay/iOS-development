//
//  ViewController.swift
//  Delivery
//
//  Created by Dynamo Software on 8.04.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var USD: UIButton!
    @IBOutlet weak var EUR: UIButton!
    @IBOutlet weak var BGN: UIButton!
    
    @IBOutlet weak var soupFIeld: UITextField!
    @IBOutlet weak var dishField: UITextField!
    @IBOutlet weak var desertField: UITextField!
    @IBOutlet weak var colaSLider: UISlider!
    @IBOutlet weak var deliveryToggle: UISwitch!
    
    @IBOutlet weak var calculateLabel: UILabel!
    
    var currency = 1.0
    var currencyLabel = " EUR"
    
    var totalPrice = 0.0
    var colaValue = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deliveryToggle.isOn = false
    }
    
    
    @IBAction func currencyTapped(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "USD" :
            USD.isSelected = true
            EUR.isSelected = false
            BGN.isSelected = false
            
            USD.isHighlighted = true
            EUR.isHighlighted = false
            BGN.isHighlighted = false
            
            currencyLabel = " USD"
            currency = 1.09
        case "EUR" :
            USD.isSelected = false
            EUR.isSelected = true
            BGN.isSelected = false
            
            USD.isHighlighted = false
            EUR.isHighlighted = true
            BGN.isHighlighted = false
            currencyLabel = " EUR"
            currency = 1.0
        case "BGN" :
            USD.isSelected = false
            EUR.isSelected = false
            BGN.isSelected = true
            
            USD.isHighlighted = false
            EUR.isHighlighted = false
            BGN.isHighlighted = true
            
            currencyLabel = " BGN"
            currency = 1.96
        default :
            USD.isSelected = false
            EUR.isSelected = false
            BGN.isSelected = false
            
            USD.isHighlighted = false
            EUR.isHighlighted = false
            BGN.isHighlighted = false
            currencyLabel = " EUR"
            currency = 1.00
        }
        calculate()
    }
    
    
    
    @IBAction func plusSoupTapped(_ sender: UIButton) {
        if var editValue = Int(soupFIeld.text ?? "") {
            if editValue < 10 {
                editValue += 1
                soupFIeld.text = String(editValue)
            }
        }
    }
    @IBAction func minusSoupTapped(_ sender: Any) {
        if var editValue = Int(soupFIeld.text ?? "") {
            if editValue > 0 {
                editValue -= 1
                soupFIeld.text = String(editValue)
            }
        }
    }
    
    @IBAction func plusDishTapped(_ sender: Any) {
        if var editValue = Int(dishField.text ?? "") {
            if editValue < 10 {
                editValue += 1
                dishField.text = String(editValue)
            }
        }
    }
    
    @IBAction func minusDishTapped(_ sender: Any) {
        if var editValue = Int(dishField.text ?? "") {
            if editValue > 0 {
                editValue -= 1
                dishField.text = String(editValue)
            }
        }
    }
    @IBAction func plusDesertTapped(_ sender: Any) {
        if var editValue = Int(desertField.text ?? "") {
            if editValue < 10 {
                editValue += 1
                desertField.text = String(editValue)
            }
        }
    }
    
    @IBAction func minusDeserTapped(_ sender: Any) {
        if var editValue = Int(desertField.text ?? "") {
            if editValue > 0 {
                editValue -= 1
                desertField.text = String(editValue)
            }
        }
    }
    
    @IBAction func colaSliderMoved(_ sender: UISlider) {
        let sliderValue = String(sender.value).prefix(4)
        
        colaValue = 2.0 * (Double(sliderValue) ?? 0)
    }
    
    
    @IBAction func calculateTapped(_ sender: Any) {
        calculate()
    }
    
    func calculate(){
        let soupValue = (Double(soupFIeld.text ?? "0") ?? 0)  * 2.0
        let dishValue = (Double(dishField.text ?? "0") ?? 0)  * 4.5
        let desertValue = (Double(desertField.text ?? "0") ?? 0)  * 1.5
        let homeDelivery = deliveryToggle.isOn ? 10.0 : 0
        
        let totalPrice = (soupValue + dishValue + desertValue + homeDelivery + colaValue)*currency
        
        let roundedTotal = Double(round(100*totalPrice)/100)
        
        calculateLabel.text = (String(roundedTotal) == "0.0" ? "0":  String(roundedTotal)) + currencyLabel
    }
    
}

