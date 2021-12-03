//
//  ViewController.swift
//  spreadChat
//
//  Created by Ana Dzamelashvili on 11/20/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLable.text = ""
        var charIndex = 0.0
        let titleText = Con.appName
        
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) {
                (timer) in
                self.titleLable.text?.append(letter)
            }
            charIndex += 1
            
        }
    }
}
