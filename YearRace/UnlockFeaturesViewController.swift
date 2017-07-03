//
//  UnlockFeaturesViewController.swift
//  YearRace
//
//  Created by David Ruvinskiy on 7/3/17.
//  Copyright © 2017 David Ruvinskiy. All rights reserved.
//

import UIKit

class UnlockFeaturesViewController: UIViewController {
    
    @IBOutlet weak var undoPasswordTextField: UITextField!
    @IBOutlet weak var answerPasswordTextField: UITextField!
    
    let correctUndoPassword = "undoPassword"
    let correctAnswerPassword = "answerPassword"

    @IBAction func submitButtonTapped(_ sender: Any) {
        let undoPassword = undoPasswordTextField.text
        let answerPassword = answerPasswordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
