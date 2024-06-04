//
//  TaxesViewController.swift
//  ComprasUSA
//
//  Created by Vitoria Ortega on 29/05/24.
//

import UIKit

class TaxesViewController: UIViewController {
    @IBOutlet weak var dolarLb: UILabel!
    @IBOutlet weak var stateTaxesLb: UILabel!
    @IBOutlet weak var stateTaxesDescriptionLb: UILabel!
    @IBOutlet weak var iofDescriptionLb: UILabel!
    @IBOutlet weak var iofLb: UILabel!
    @IBOutlet weak var creditCardSw: UISwitch!
    @IBOutlet weak var realLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stateTaxesLb.setContentCompressionResistancePriority(.required, for: .horizontal)
        stateTaxesDescriptionLb.adjustsFontSizeToFitWidth = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculateTaxes()
    }
    
    @IBAction func changeIOF(_ sender: UISwitch) {
        calculateTaxes()
    }
    
    
    func calculateTaxes() {
        stateTaxesDescriptionLb.text = "Imposto do Estado (\(tc.getFormattedValue(of: tc.stateTax, withCurrency: ""))%)"
        iofDescriptionLb.text = "IOF (\(tc.getFormattedValue(of: tc.iof, withCurrency: ""))%)"

        dolarLb.text = tc.getFormattedValue(of: tc.shoppingValue, withCurrency: "US$ ")
        stateTaxesLb.text = tc.getFormattedValue(of: tc.stateTaxValue, withCurrency: "US$ ")
        iofLb.text = tc.getFormattedValue(of: tc.iofValue, withCurrency: "US$ ")
        
        let real = tc.calculate(usingCreditCard: creditCardSw.isOn)
        realLb.text = tc.getFormattedValue(of: real, withCurrency: "R$ ")
    }
}
