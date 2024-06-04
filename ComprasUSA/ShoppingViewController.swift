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
        setAmmount()

    }
    
    func setAmmount() {
        
    }
}

