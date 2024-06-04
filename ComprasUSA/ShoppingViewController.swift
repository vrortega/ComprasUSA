//
//  ViewController.swift
//  ComprasUSA
//
//  Created by Vitoria Ortega on 29/05/24.
//

import UIKit

class ShoppingViewController: UIViewController {
    @IBOutlet weak var dolarTf: UITextField!
    @IBOutlet weak var realDescriptionLb: UILabel!
    @IBOutlet weak var realLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAmmount()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dolarTf.resignFirstResponder()
        setAmmount()

    }
    
    func setAmmount() {
        tc.shoppingValue = tc.convertToDouble(dolarTf.text!)
        realLb.text = tc.getFormattedValue(of: tc.shoppingValue * tc.dolar, withCurrency: "R$ ")
        let dolar = tc.getFormattedValue(of: tc.dolar, withCurrency: "")
        realDescriptionLb.text = "Valor sem impostos (dólar \(dolar))"
    }
}

