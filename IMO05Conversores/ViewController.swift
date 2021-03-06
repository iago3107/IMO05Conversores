//
//  ViewController.swift
//  IMO05Conversores
//
//  Created by Iago Jose on 15/10/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var btUnit1: UIButton!
    @IBOutlet weak var btUnit2: UIButton!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var lbResultUnit: UILabel!
    @IBOutlet weak var lbUnit: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tfValue.text = ""
        
        btUnit1.titleLabel?.numberOfLines = 1
        btUnit1.titleLabel?.adjustsFontSizeToFitWidth = true
        btUnit1.titleLabel?.lineBreakMode = .byClipping //<-- MAGIC LINE
        
        btUnit2.titleLabel?.numberOfLines = 1
        btUnit2.titleLabel?.adjustsFontSizeToFitWidth = true
        btUnit2.titleLabel?.lineBreakMode = .byClipping //<-- MAGIC LINE

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @IBAction func showNext(_ sender: UIButton) {
        switch lbUnit.text! {
            case "Temperatura":
                lbUnit.text = "Peso"
                btUnit1.setTitle("Quilograma", for: .normal)
                btUnit2.setTitle("Libra", for: .normal)
            case "Peso":
                lbUnit.text = "Moeda"
                btUnit1.setTitle("Real", for: .normal)
                btUnit2.setTitle("Dolar", for: .normal)
            case "Moeda":
                lbUnit.text = "Distância"
                btUnit1.setTitle("Metro", for: .normal)
                btUnit2.setTitle("Quilometro", for: .normal)
            default:
                lbUnit.text = "Temperatura"
                btUnit1.setTitle("Celsius", for: .normal)
                btUnit2.setTitle("Farenheint", for: .normal)
        }
        Conversor(nil)
    }
    

    
    @IBAction func Conversor(_ sender: UIButton?) {
        if let botaoClicado = sender {
            if botaoClicado == btUnit1 {
                btUnit2.alpha = 0.5
            }else {
                btUnit1.alpha = 0.5
            }
            botaoClicado.alpha = 1.0
        }
        switch lbUnit.text! {
            case "Temperatura":
                calcTemperature()
            case "Peso":
                calcWeight()
            case "Moeda":
                calcCurrency()
            default:
                calcDistance()
        }
        view.endEditing(true)
        
        let result = lbResult.text!.isEmpty ? Double("0.0")! : Double((lbResult.text!).replacingOccurrences(of: ",", with: "."))!
        lbResult.text = String(format: "%.2f", result)
        lbResult.text = lbResult.text!.replacingOccurrences(of: ".", with: ",")
    }
    func calcTemperature()  {
        guard let temperature = Double((tfValue.text!).replacingOccurrences(of: ",", with: ".")) else {return}
        if btUnit1.alpha == 1.0{
            lbResultUnit.text = "Farenheint"
            lbResult.text = String(temperature * 1.8 + 32.0)
        }else{
            lbResultUnit.text = "Celsius"
            lbResult.text = String((temperature - 32.0) / 1.8)
        }
    }
    
    func calcWeight()  {
        guard let weight = Double((tfValue.text!).replacingOccurrences(of: ",", with: ".")) else {return}
        if btUnit1.alpha == 1.0{
            lbResultUnit.text = "Libra"
            lbResult.text = String(weight / 2.2046)
        }else{
            lbResultUnit.text = "Kilograma"
            lbResult.text = String(weight * 2.2046)
        }
    }
    func calcCurrency(){
        guard let currency = Double((tfValue.text!).replacingOccurrences(of: ",", with: ".")) else {return}
        if btUnit1.alpha == 1.0{
            lbResultUnit.text = "Dólar"
            lbResult.text = String(currency / 5.2)
        }else{
            lbResultUnit.text = "Real"
            lbResult.text = String(currency * 5.2)
        }
    }
    func calcDistance() {
        guard let distance = Double((tfValue.text!).replacingOccurrences(of: ",", with: ".")) else {return}
        if btUnit1.alpha == 1.0{
            lbResultUnit.text = "Quilômetro"
            lbResult.text = String(distance / 1000.0)
        }else{
            lbResultUnit.text = "Metros"
            lbResult.text = String(distance * 1000.0)
        }
    }

}
