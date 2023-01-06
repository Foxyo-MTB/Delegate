//
//  ViewController.swift
//  UIKit_homework
//
//  Created by Vladimir Beliakov on 25.08.2022.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var viewToChangeColor: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    
    @IBOutlet var redSliderOutlet: UISlider!
    @IBOutlet var greenSliderOutlet: UISlider!
    @IBOutlet var blueSliderOutlet: UISlider!
    
    var delegate: MainViewControllerDelegate!
    var colorDefault: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setViewDefault()
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        viewToChangeColor.backgroundColor = colorDefault
        
        
    }
    
    //MARK: - Setting default view when app just loaded
    
    func setViewDefault() {
        
        viewToChangeColor.layer.cornerRadius = 50
        viewToChangeColor.backgroundColor = UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1.0)
        updateColorView()
    }
    
    //MARK: - Function to change color.
    
    func updateColorView() {
        
        // We did create this function because we use it in delegate method for hand input also we use this when we hit sliders.
        let backgroundColor = UIColor(red: CGFloat(redSliderOutlet.value),
                                      green: CGFloat(greenSliderOutlet.value),
                                      blue: CGFloat(blueSliderOutlet.value),
                                      alpha: 1.0)
        viewToChangeColor.backgroundColor = backgroundColor
        
        redLabel.text = String(format: "%.2f", redSliderOutlet.value)
        redTextField.text = String(format: "%.2f", redSliderOutlet.value)
        greenLabel.text = String(format: "%.2f", greenSliderOutlet.value)
        greenTextField.text = String(format: "%.2f", greenSliderOutlet.value)
        blueLabel.text = String(format: "%.2f", blueSliderOutlet.value)
        blueTextField.text = String(format: "%.2f", blueSliderOutlet.value)
        
    }
    
    //MARK: - Action - slider moves
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        updateColorView()
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
        delegate.getSettings(viewToChangeColor.backgroundColor!)
        
    }
    
    
}

    //MARK: - Extension for TextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {          // Needs for applying changes after pressing "Enter" in TextField.
        
        redTextField.resignFirstResponder()
        greenTextField.resignFirstResponder()
        blueTextField.resignFirstResponder()
        redTextField.returnKeyType = .done
        return true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {                 // Need for applying logic we need. It will apply logic when we finished edit our text.
        
        if let redText = Float(redTextField.text ?? "0.50") {
            redSliderOutlet.value = redText
        }
        if let greenText = Float(greenTextField.text ?? "0.50") {
            greenSliderOutlet.value = greenText
    
        }
        if let blueText = Float(blueTextField.text ?? "0.50") {
            blueSliderOutlet.value = blueText
        }
        updateColorView()
    }
    
}

//MARK: - Extension for possibility to choose accessory - Done button in storyboard.

extension UITextField{

    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }

    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}


