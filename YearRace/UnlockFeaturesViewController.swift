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
    @IBOutlet weak var undoSwitch: UISwitch!
    @IBOutlet weak var answerSwitch: UISwitch!
    @IBOutlet weak var checkButton: UIBarButtonItem!
    
    let correctUndoPassword = "87"
    let correctAnswerPassword = "50000"
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        checkButtonTapped(checkButton)
        
        return false
    }
    
    @IBAction func checkButtonTapped(_ sender: UIBarButtonItem) {
        let undoPassword = undoPasswordTextField.text
        let answerPassword = answerPasswordTextField.text
        
        if undoPassword == correctUndoPassword {
            undoPasswordTextField.text = ""
            undoSwitch.setOn(true, animated: true)
            undoSwitch.isUserInteractionEnabled = true
            undoControls[0] = true
        }
        
        if answerPassword == correctAnswerPassword {
            answerPasswordTextField.text = ""
            answerSwitch.setOn(true, animated: true)
            answerSwitch.isUserInteractionEnabled = true
            showAnswerControls = true
        }
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        sender.isUserInteractionEnabled = false
        
        if sender == undoSwitch {
            undoControls[0] = false
        }
        else if sender == answerSwitch {
            showAnswerControls = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if undoControls[0] {
            undoSwitch.setOn(true, animated: false)
            undoSwitch.isUserInteractionEnabled = true
        }
        
        if showAnswerControls {
            answerSwitch.setOn(true, animated: false)
            answerSwitch.isUserInteractionEnabled = true
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
