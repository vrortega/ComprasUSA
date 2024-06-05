<div align="center"><h1>Compras USA</h1></div>

## 📘 Introdução
O ComprasUSA é um aplicativo desenvolvido em Swift que calcula o valor dos gastos nos EUA conforme a cotação do dólar, IOF e imposto do estado.

## 🗂️ Arquivos e Diretórios
- ShoppingViewController.swift: Controlador da tela de compras.
- SettingsViewController.swift: Controlador da tela de configurações.
- TaxesViewController.swift: Controlador da tela de impostos.
- TaxesCalculator.swift: Lógica de cálculo dos valores de compra e impostos.
- UIViewController+TaxesCalculator.swift: Extensão para acessar facilmente o TaxesCalculator.
- Main.storyboard: Interface visual do app, contendo as três telas principais.

## 📱 Telas do App

### 🛒 ShoppingViewController
Controlador da tela principal onde o usuário insere o valor das compras em dólares e visualiza o valor em reais.

```swift
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
```

### ⚙️ SettingsViewController
Controlador da tela de configurações onde o usuário define a cotação do dólar, IOF e impostos estaduais.

```swift
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
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }

  func setValues() {
    tc.dolar = tc.convertToDouble(dolarTf.text!)
    tc.iof = tc.convertToDouble(iofTf.text!)
    tc.stateTax = tc.convertToDouble(stateTaxesTf.text!)
  }
}

extension SettingsViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    setValues()
  }
}

```

### 💰 TaxesViewController
Controlador da tela de visualização detalhada dos impostos aplicados sobre as compras.

```swift
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
```

### 💡 Lógica de Negócio
A lógica de cálculo dos valores de compra, impostos e conversão é gerenciada pela classe TaxesCalculator.

```swift
import Foundation

class TaxesCalculator {
  static let shared = TaxesCalculator()
  var dolar: Double = 3.5
  var iof: Double = 6.38
  var stateTax: Double = 7.0
  var shoppingValue: Double = 0
  let formatter = NumberFormatter()

  var shoppingValueInReal: Double {
    return shoppingValue * dolar
  }

  var stateTaxValue: Double {
    return shoppingValue * stateTax / 100
  }

  var iofValue: Double {
    return (shoppingValue + stateTaxValue) * iof / 100
  }

  func calculate(usingCreditCard: Bool) -> Double {
    var finalValue = shoppingValue + stateTaxValue
    if (usingCreditCard) {
      finalValue += iofValue
    }
    return finalValue * dolar
  }

  func convertToDouble(_ string: String) -> Double {
    formatter.numberStyle = .none
    return formatter.number(from: string)!.doubleValue
  }

  func getFormattedValue(of value: Double, withCurrency currency: String) -> String {
    formatter.numberStyle = .currency
    formatter.currencySymbol = currency
    formatter.alwaysShowsDecimalSeparator = true
    return formatter.string(for: value)!
  }

  private init () {
    formatter.usesGroupingSeparator = true
  }
}

```

## 🔄 Extensão UIViewController
Extensão para facilitar o acesso ao TaxesCalculator a partir de qualquer UIViewController.

```swift
import UIKit

extension UIViewController {
  var tc: TaxesCalculator {
    return TaxesCalculator.shared
  }
}
```

## 🚀 Como Rodar o Projeto
* **Clone o Repositório:**

```sh
git clone https://github.com/vrortega/ComprasUSA.git
cd ComprasUSA
```
* **Abra o Projeto no Xcode:**

Navegue até o arquivo `ComprasUSA.xcodeproj` e abra-o com o Xcode.

* **Instale as Dependências:**

Se o projeto utilizar CocoaPods, execute `pod install` para instalar as dependências necessárias.

* **Compile e Rode o Projeto:**

Pressione `Cmd + R` ou clique no botão de rodar no Xcode.

## 📖 Referência
Projeto desenvolvido como parte do <a href="https://www.udemy.com/course/curso-completo-de-desenvolvimento-ios11swift4" target="_blank">
curso de desenvolvimento iOS, do Desenvolvedor Eric Alves Brito</a>.
