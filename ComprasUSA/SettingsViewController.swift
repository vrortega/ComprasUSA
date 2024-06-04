//
//  SettingsViewController.swift
//  ComprasUSA
//
//  Created by Vitoria Ortega on 29/05/24.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var dolarTf: UITextField!
    @IBOutlet weak var iofTf: UITextField!
    @IBOutlet weak var stateTaxesTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dolarTf.text = tc.getFormattedValue(of: tc.dolar, withCurrency: "")
        iofTf.text = tc.getFormattedValue(of: tc.iof, withCurrency: "")
        stateTaxesTf.text = tc.getFormattedValue(of: tc.stateTax, withCurrency: "")

        // Do any additional setup after loading the view.
    }
    

}
