//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    let coinManager = CoinManager()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        
        pickerView.selectRow(coinManager.currencyArray.firstIndex(of: "USD")!, inComponent: 0, animated: false)
            }
}
//MARK: - UIPickerViewDataSource
    
extension ViewController: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedCurrency = coinManager.currencyArray[row]
        
        currencyLabel.text = selectedCurrency
        
        print("Currency selected: \(selectedCurrency)")
        
        coinManager.getURL(currency: selectedCurrency)
    }
}
