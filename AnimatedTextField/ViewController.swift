//
//  ViewController.swift
//  AnimatedTextField
//
//  Created by Bhavishya Sharma on 17/09/24.
//

import UIKit

class ViewController: UIViewController, AnimatedTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: AnimatedTextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: AnimatedTextField) {
        
    }
    
    func textField(_ textField: AnimatedTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        true
    }
    

    @IBOutlet var textfield: AnimatedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textfield.delegate = self
    }


}

